#!/bin/bash

# Check if the directory path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory-path>"
    exit 1
fi

# Assign the directory to a variable
DIR=$1

# Check if the directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Create a 'latex' subdirectory if it does not exist
LATEX_DIR="$DIR/latex"
if [ ! -d "$LATEX_DIR" ]; then
    mkdir "$LATEX_DIR"
fi

# Convert each Markdown file in the directory to LaTeX
for file in "$DIR"/*.md; do
    # Check if there are any markdown files
    if [ ! -f "$file" ]; then
        echo "No Markdown files found in the directory."
        break
    fi
    # Extract filename without extension
    filename=$(basename -- "$file")
    filename="${filename%.*}"

    # Define output LaTeX file path
    output_file="$LATEX_DIR/$filename.tex"

    # Use Pandoc to convert
    pandoc "$file" -s -o "$output_file"
done

echo "Conversion completed."

