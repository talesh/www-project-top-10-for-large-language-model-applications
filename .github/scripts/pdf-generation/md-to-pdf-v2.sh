#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Ensure UTF-8 encoding in the environment
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEN_DIR="$SCRIPT_DIR/../../generated"
BG_DIR="$SCRIPT_DIR/../../backgrounds"

# Helper to check command existence
require_cmd() {
	command -v "$1" >/dev/null 2>&1 || { echo "Error: '$1' not found in PATH." >&2; exit 1; }
}

require_cmd md-to-pdf
require_cmd python
require_cmd pdftk
require_cmd find

cd "$GEN_DIR"

# Generate PDFs from markdown
md-to-pdf body.md --stylesheet styles.css
python "$SCRIPT_DIR/headers.py"
md-to-pdf toc.md --stylesheet styles.css
md-to-pdf cover.md --stylesheet styles.css

# Add backgrounds
pdftk cover.pdf background "$BG_DIR/a4-cover.pdf" output bg-cover.pdf
pdftk body.pdf background "$BG_DIR/a4-draft.pdf" output bg-body.pdf

# Split TOC
pdftk toc.pdf cat 1 output toc-page1.pdf
pdftk toc.pdf cat 2-end output toc-rest.pdf

# Add backgrounds to TOC
pdftk toc-page1.pdf background "$BG_DIR/a4-toc.pdf" output bg-toc-page1.pdf
pdftk toc-rest.pdf background "$BG_DIR/a4-draft.pdf" output bg-toc-rest.pdf

# Merge all PDFs
pdftk bg-cover.pdf bg-toc-page1.pdf bg-toc-rest.pdf bg-body.pdf cat output complete.pdf

# Clean up intermediate PDFs except complete.pdf
find . -type f -name "*.pdf" ! -name "complete.pdf" -delete
