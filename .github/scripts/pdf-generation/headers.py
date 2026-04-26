import re
import sys
import unicodedata
from collections import defaultdict

import pdfplumber
import tinycss2
from bidi import get_display


def parse_header_sizes_pt(css_path):
    """Read h2/h3/h4 font-size from a stylesheet, return as a {selector: pt} dict.

    Hard-fails on missing rules, missing font-size declarations, unsupported
    units, or inverted sizes (h3 >= h2 or h4 >= h3).
    """
    with open(css_path, "rb") as f:
        rules = tinycss2.parse_stylesheet_bytes(
            f.read(), skip_whitespace=True, skip_comments=True
        )[0]

    sizes = {}
    for rule in rules:
        if rule.type != "qualified-rule":
            continue
        # Selector lists like `h2, h6 { ... }` need each selector matched
        # individually so a heading rule grouped with unrelated elements
        # still applies to h2/h3/h4.
        selectors = [s.strip() for s in tinycss2.serialize(rule.prelude).split(",")]
        matching = [s for s in selectors if s in ("h2", "h3", "h4")]
        if not matching:
            continue
        for decl in tinycss2.parse_blocks_contents(
            rule.content, skip_whitespace=True, skip_comments=True
        ):
            if decl.type != "declaration" or decl.lower_name != "font-size":
                continue
            dim = next(
                (t for t in decl.value if t.type == "dimension"), None
            )
            if dim is None:
                continue
            if dim.unit == "px":
                size_pt = float(dim.value) * 0.75
            elif dim.unit == "pt":
                size_pt = float(dim.value)
            else:
                sys.exit(
                    f"ERROR: styles.css {matching[0]} font-size uses unsupported "
                    f"unit '{dim.unit}'. Use px or pt."
                )
            # Last rule in source order wins, matching the CSS cascade
            for sel in matching:
                sizes[sel] = size_pt

    for sel in ("h2", "h3", "h4"):
        if sel not in sizes:
            sys.exit(f"ERROR: styles.css must define a font-size for '{sel}'.")
    if not (sizes["h2"] > sizes["h3"] > sizes["h4"]):
        sys.exit(
            f"ERROR: styles.css font sizes must satisfy h2 > h3 > h4. "
            f"Got h2={sizes['h2']:.1f}pt, h3={sizes['h3']:.1f}pt, h4={sizes['h4']:.1f}pt."
        )
    return sizes


def is_rtl_text(text):
    for ch in text:
        bidi = unicodedata.bidirectional(ch)
        if bidi in ('R', 'AL'):
            return True
        elif bidi == 'L':
            return False
    return False

# Added a function to solve the problem of Korean characters not being spaced
def join_line_with_spaces(line_chars, space_threshold=2.0):
    # Detect character spacing, insert spaces, and merge into one line
    text = ""
    prev_char = None
    for c in line_chars:
        if prev_char is not None:
            # Measure space between characters (current character x0 - previous character x1)
            gap = c['x0'] - prev_char['x1']
            if gap > space_threshold:  # Insert blank space if threshold is exceeded
                text += " "
        text += c['text']
        prev_char = c
    return text

def clean_text(text):
    # Remove NUL and non-printable characters
    text = text.replace('\x00', '')
    # Normalize Unicode (important for Devanagari)
    text = unicodedata.normalize('NFC', text)
    return text

def extract_lines_with_sizes(pdf_path):
    lines_with_sizes = []
    with pdfplumber.open(pdf_path) as pdf:
        for page_number, page in enumerate(pdf.pages, start=1):
            # Extract characters with their properties
            chars = page.chars
            
            # Group characters into lines using document-top position
            lines = defaultdict(list)
            for char in chars:
                lines[round(char['doctop'])].append(char)
            
            # Analyze each line
            for ypos, line_chars in lines.items():
                if not line_chars:
                    continue
                
                # Sort characters left-to-right
                line_chars.sort(key=lambda x: x['x0'])
                
                # Extract text and average size for the line
                #text = ''.join(c['text'] for c in line_chars)
                text = join_line_with_spaces(line_chars, space_threshold=2.0)   # Calling a function to solve the Korean character spacing problem
                text = clean_text(text)
                sizes = [c['size'] for c in line_chars if c['size']]
                avg_size = sum(sizes) / len(sizes) if sizes else 0
                
                lines_with_sizes.append({
                    'text': text.strip(),
                    'page': page_number,
                    'size': avg_size,
                    'doctop': ypos,
                })

    # pdfplumber's per-page bucket order is roughly visual order, but not
    # guaranteed — sort explicitly so coalesce_wrapped sees neighbors adjacent.
    lines_with_sizes.sort(key=lambda l: (l['page'], l['doctop']))
    return lines_with_sizes


def coalesce_wrapped(headers):
    """Merge consecutive detections that are wrapped continuations of one heading.

    A long heading wraps to multiple visual lines; pdfplumber reports each as
    a separate detection with the same font size. Distinct headings are
    separated by body content and end up far apart vertically. Heuristic:
    same level + same page + vertical gap less than ~1.5 line-heights ⇒ merge.
    """
    if not headers:
        return headers
    coalesced = [headers[0]]
    for h in headers[1:]:
        prev = coalesced[-1]
        if (
            h['level'] == prev['level']
            and h['page'] == prev['page']
            and abs(h['doctop'] - prev['doctop']) < 1.5 * h['size']
        ):
            continue
        coalesced.append(h)
    return coalesced

def extract_headers_from_md(md_path):
    headers = []
    with open(md_path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line.startswith("### "):
                headers.append({'level': 3, 'text': line[4:].strip()})
            elif line.startswith("## "):
                headers.append({'level': 2, 'text': line[3:].strip()})
    return headers

# --- Main logic ---

lines = extract_lines_with_sizes("body.pdf")

# Derive header thresholds from the per-translation stylesheet so the
# script adapts when translators tweak font sizes for non-Latin scripts.
header_sizes = parse_header_sizes_pt("styles.css")
cutoff_h2 = (header_sizes['h2'] + header_sizes['h3']) / 2
cutoff_h3 = (header_sizes['h3'] + header_sizes['h4']) / 2

header_lines = []
for line in lines:
    if line['size'] >= cutoff_h2:
        header_lines.append({'level': 2, 'page': line['page'], 'size': line['size'], 'doctop': line['doctop']})
    elif line['size'] >= cutoff_h3:
        header_lines.append({'level': 3, 'page': line['page'], 'size': line['size'], 'doctop': line['doctop']})

# Long headings wrap to multiple visual lines in the PDF — collapse those
# wrapped continuations back into a single detection per heading.
header_lines = coalesce_wrapped(header_lines)

# Extract headers from Markdown
md_headers = extract_headers_from_md("body.md")

# Hard-fail on mismatch — silently truncating produces a wrong TOC
if len(md_headers) != len(header_lines):
    print(
        f"ERROR: TOC mismatch — body.md has {len(md_headers)} headers but "
        f"body.pdf has {len(header_lines)} detected.",
        file=sys.stderr,
    )
    print(
        f"Cutoffs derived from styles.css: level-2 >= {cutoff_h2:.1f}pt, "
        f"level-3 >= {cutoff_h3:.1f}pt",
        file=sys.stderr,
    )
    print("\nHeaders in body.md:", file=sys.stderr)
    for i, h in enumerate(md_headers, 1):
        print(f"  {i:3d}. (h{h['level']}) {h['text']}", file=sys.stderr)
    print("\nDetections in body.pdf:", file=sys.stderr)
    for i, h in enumerate(header_lines, 1):
        print(
            f"  {i:3d}. p{h['page']} (size={h['size']:.1f}pt, level={h['level']})",
            file=sys.stderr,
        )
    sys.exit(1)

# Detect direction from the first header line in PDF
document_is_rtl = False
if header_lines:
    # Try to get the actual text from the PDF for direction detection
    first_pdf_line = next((l for l in lines if l['size'] == header_lines[0]['size'] and l['page'] == header_lines[0]['page']), None)
    if first_pdf_line:
        document_is_rtl = is_rtl_text(first_pdf_line['text'])

toc = []
toc.append("| | |")
toc.append("|-----------|-------|")

for i, md_header in enumerate(md_headers):
    if i >= len(header_lines):
        break
    page = header_lines[i]['page']
    text = md_header['text']
    if document_is_rtl:
        text = get_display(text)
    if md_header['level'] == 2:
        toc.append(f"| **{text}** | **{page}** |")
    elif md_header['level'] == 3:
        toc.append(f"| {text} | {page} |")

print('\n'.join(toc))

with open("toc.md", "a", encoding="utf-8") as f:
    f.write('\n')
    f.write('\n'.join(toc))