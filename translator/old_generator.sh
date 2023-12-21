#!/bin/bash

# Check if a directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Define directories and files
current_directory=$(pwd)
directory=$1
output_file="$directory/combined.md"
pdf_file="$directory/combined.pdf"
frontmatter="$current_directory/frontmatter.md"
stylesheet="$current_directory/styles/topten.css"

# Check if the provided argument is a directory
if [ ! -d "$directory" ]; then
    echo "Error: '$directory' is not a directory."
    exit 1
fi

# Delete the PDF if it already exists
if [ -f "$pdf_file" ]; then
    echo "Deleting existing PDF file: $pdf_file"
    rm "$pdf_file"
    echo "Deleting existing Markdown file: $output_file"
    rm "$output_file"
fi

# Check if the output file already exists, skip if it does
if [ -f "$output_file" ]; then
    echo "Skipping creation of combined markdown, $output_file already exists."
else
    # Start with a clean output file
    > "$output_file"

    # Add the frontmatter if it exists
    if [ -f "$frontmatter" ]; then
        cat "$frontmatter" >> "$output_file"
        echo "" >> "$output_file" # Adds a newline after the frontmatter
    fi

    # Sort markdown files alphabetically and concatenate them
    for file in $(find "$directory" -maxdepth 1 -name '*.md' | sort); do
        # Skip the frontmatter and output file
        if [[ "$file" != "$frontmatter" && "$file" != "$output_file" ]]; then
            cat "$file" >> "$output_file"
            echo "" >> "$output_file" # Adds a newline between files
        fi
    done

    echo "Combined markdown files into $output_file"
fi

# Convert the combined Markdown file to PDF only if the output file was just created
if [ -f "$output_file" ]; then
    md-to-pdf --basedir "$current_directory" --stylesheet "$stylesheet" "$output_file"
    echo "Converted $output_file to PDF"
else
    echo "Skipping PDF conversion, $output_file was not created."
fi