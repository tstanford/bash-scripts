# PDF Booklet Conversion Script

This script converts a PDF into an A4 booklet with page numbers.  
If the input PDF is Letter size, it is automatically resized to A4 before processing.

## Requirements

Install the following tools:

- pdfinfo (from poppler-utils)
- pdfjam
- bash

Example installation on Debian/Ubuntu:

    sudo apt install poppler-utils pdfjam

## Usage

Run the script with a PDF file:

    ./booklet-withpagenumbers.sh input.pdf

The script will generate:

- a4-input.pdf (only if the original was Letter size)
- numbered-input.pdf (intermediate file with page numbers)
- booklet-input.pdf (final booklet)

## How It Works

### 1. Resize Letter → A4

If the PDF is detected as Letter size, it is resized:

    pdfjam "$1" --paper a4paper --scale 0.95 --outfile "a4-$1"

### 2. Add Page Numbers

Page numbers are added using LaTeX via pdfjam:

    pdfjam "$resizedFile" \
      --pagecommand '{}' \
      --preamble '\setlength{\footskip}{80pt}\pagestyle{plain}' \
      --outfile "numbered-$1"

### 3. Create Booklet

The numbered PDF is converted into a booklet:

    pdfjam "numbered-$1" \
      --booklet true \
      --paper a4paper \
      --landscape \
      --outfile "booklet-$1"

### 4. Cleanup

Temporary files are removed:

    rm -f "a4-$1"
    rm -f "numbered-$1"
