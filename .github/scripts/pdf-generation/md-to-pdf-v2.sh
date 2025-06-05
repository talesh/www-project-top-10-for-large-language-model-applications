#!/bin/bash

# Ensure UTF-8 encoding in the environment
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

md-to-pdf ./generated/body.md --stylesheet ./generated/styles.css
python headers.py
md-to-pdf ./generated/toc.md --stylesheet ./generated/styles.css
md-to-pdf ./generated/cover.md --stylesheet ./generated/styles.css


pdftk ./generated/cover.pdf background ./backgrounds/a4-cover.pdf output ./generated/bg-cover.pdf
pdftk ./generated/body.pdf background ./backgrounds/a4-draft.pdf output ./generated/bg-body.pdf

pdftk ./generated/toc.pdf cat 1 output ./generated/toc-page1.pdf
pdftk ./generated/toc.pdf cat 2-end output ./generated/toc-rest.pdf

pdftk ./generated/toc-page1.pdf background ./backgrounds/a4-toc.pdf output ./generated/bg-toc-page1.pdf
pdftk ./generated/toc-rest.pdf background ./backgrounds/a4-draft.pdf output ./generated/bg-toc-rest.pdf

pdftk ./generated/bg-cover.pdf ./generated/bg-toc-page1.pdf ./generated/bg-toc-rest.pdf ./generated/bg-body.pdf cat output ./generated/complete.pdf

find ./generated -type f -name "*.pdf" ! -name "complete.pdf" -delete
