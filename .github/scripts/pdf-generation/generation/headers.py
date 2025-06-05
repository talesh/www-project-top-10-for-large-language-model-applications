from collections import defaultdict

import pdfplumber


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
                text = ''.join(c['text'] for c in line_chars)
                sizes = [c['size'] for c in line_chars if c['size']]
                avg_size = sum(sizes) / len(sizes) if sizes else 0
                
                lines_with_sizes.append({
                    'text': text.strip(),
                    'page': page_number,
                    'size': avg_size
                })
    
    return lines_with_sizes


# Usage example:
lines = extract_lines_with_sizes("content.pdf")

# Combine consecutive lines with the same size
combined_lines = []
i = 0
while i < len(lines):
    current = lines[i]
    combined_text = current['text']
    page = current['page']
    size = current['size']
    i += 1
    while i < len(lines) and abs(lines[i]['size'] - size) < 1e-3:
        combined_text += ' ' + lines[i]['text']
        i += 1
    combined_lines.append({'text': combined_text.strip(), 'page': page, 'size': size})

lines = combined_lines

toc = []
toc.append("| | |")
toc.append("|-----------|-------|")
for line in lines:
    if line['size'] > 30:
        # Main section
        toc.append(f"| **{line['text']}** | **{line['page']}** |")
    elif line['size'] > 20:
        # Sub section (indent with non-breaking space for clarity)
        toc.append(f"| {line['text']} | {line['page']} |")
    else:
        continue

print('\n'.join(toc))

# Empty the file first
with open("toc.md", "w", encoding="utf-8") as f:
    pass

# Now write the TOC
with open("toc.md", "w", encoding="utf-8") as f:
    f.write("## Inhaltsverzeichnis\n")
    f.write('\n'.join(toc))