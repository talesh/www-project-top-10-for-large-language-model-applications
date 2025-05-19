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
for line in lines:
    if line['size'] > 17:
        #print(f"Page {line['page']}: {line['text']} (Avg Size: {line['size']:.1f}pt)")
        #print(f"{line['text']}{'.' * (80 - len(line['text']) - len(str(line['page'])))}{line['page']}")
