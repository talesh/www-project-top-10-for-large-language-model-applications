# Install: pip install pdfplumber
import pdfplumber

headings = []
with pdfplumber.open('content.pdf') as pdf:
    for page_num, page in enumerate(pdf.pages, start=1):
        text = page.extract_text()
        # Adjust logic to match your heading patterns (e.g., "## Section")
        for line in text.split('\n'):
            if line.startswith('#'):
                headings.append((line.strip(), page_num))

print(headings)

