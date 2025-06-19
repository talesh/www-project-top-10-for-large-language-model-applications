import os
import re

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TOC_MD = os.path.join(SCRIPT_DIR, 'generated', 'toc.md')
CORRECTION_MD = os.path.join(SCRIPT_DIR, 'correction.md')

# 1. Read corrections from correction.md
corrections = []
with open(CORRECTION_MD, encoding='utf-8') as f:
    lines = f.readlines()
    for line in lines:
        if line.startswith('|') and '|' in line[1:]:
            parts = [p.strip() for p in line.strip().split('|')[1:-1]]
            if (
                len(parts) == 2 and
                parts[0] and parts[1] and
                parts[0] != 'Corrupted Text' and
                parts[0] != parts[1]
            ):
                corrections.append((parts[0], parts[1]))

# 2. Read toc.md
with open(TOC_MD, encoding='utf-8') as f:
    toc_lines = f.readlines()

# 3. Replace corrupted text with corrected text (only once per line per correction)
new_toc_lines = []
replace_count = 0
for line in toc_lines:
    new_line = line
    for corrupted, corrected in corrections:
        if corrupted in new_line and corrected:
            # Replace only the first occurrence per line
            new_line = new_line.replace(corrupted, corrected, 1)
            replace_count += 1
    new_toc_lines.append(new_line)

# 4. Write back to toc.md
with open(TOC_MD, 'w', encoding='utf-8') as f:
    f.writelines(new_toc_lines)

print(f"All corrupted TOC entries replaced with correct text from correction.md. Total replacements: {replace_count}") 