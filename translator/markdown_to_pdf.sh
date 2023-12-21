#!/bin/bash

# Check if a directory is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Define directories and files
current_directory=$(pwd)
directory=$1
dir_name=$(basename "$directory")
generated_folder="$current_directory/generated"
output_file="$generated_folder/${dir_name}.md"
pdf_file="$generated_folder/${dir_name}.pdf"
frontmatter="$current_directory/frontmatter.md"
stylesheet="$current_directory/styles/topten.css"

# Create the 'generated' directory if it doesn't exist
if [ ! -d "$generated_folder" ]; then
    mkdir "$generated_folder"
fi

# Check if the provided argument is a directory
if [ ! -d "$directory" ]; then
    echo "Error: '$directory' is not a directory."
    exit 1
fi

# Delete the PDF and Markdown file if they already exist
if [ -f "$pdf_file" ]; then
    echo "Deleting existing PDF file: $pdf_file"
    rm "$pdf_file"
fi
if [ -f "$output_file" ]; then
    echo "Deleting existing Markdown file: $output_file"
    rm "$output_file"
fi

# Start with a clean output file
> "$output_file"

# Add the frontmatter if it exists
if [ -f "$frontmatter" ]; then
    cat "$frontmatter" >> "$output_file"
    echo "" >> "$output_file" # Adds a newline after the frontmatter
fi

# Sort markdown files alphabetically and concatenate them
for file in $(find "$directory" -maxdepth 1 -name '*.md' | sort); do
    # Skip the frontmatter
    if [[ "$file" != "$frontmatter" ]]; then
        cat "$file" >> "$output_file"
        echo "" >> "$output_file" # Adds a newline between files
    fi
done

echo "Combined markdown files into $output_file"

# Convert the combined Markdown file to PDF
md-to-pdf --basedir "$current_directory" --stylesheet "$stylesheet" "$output_file"
echo "Converted $output_file to PDF"
