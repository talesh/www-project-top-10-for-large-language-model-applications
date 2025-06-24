import re
import unicodedata
from collections import defaultdict

import pdfplumber
from bidi import get_display


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
                    'size': avg_size
                })
    
    return lines_with_sizes

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
# Only keep lines that are headers by size
header_lines = []
for line in lines:
    if line['size'] > 25:
        header_lines.append({'level': 2, 'page': line['page'], 'size': line['size']})
    elif line['size'] > 20:
        header_lines.append({'level': 3, 'page': line['page'], 'size': line['size']})

# Extract headers from Markdown
md_headers = extract_headers_from_md("body.md")

# Sanity check: warn if counts don't match
if len(md_headers) != len(header_lines):
    print(f"Warning: Found {len(md_headers)} headers in body.md but {len(header_lines)} in PDF.")

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