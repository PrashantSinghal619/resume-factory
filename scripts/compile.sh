#!/bin/bash
# compile.sh — Compile a LaTeX resume to PDF using latexmk.
#
# Usage:
#   ./scripts/compile.sh <path-to-tex-file>
#
# Example:
#   ./scripts/compile.sh output/tex/resume_google_swe.tex
#
# Output PDF will be placed in output/pdf/

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path-to-tex-file>"
  exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "Error: File not found: $FILE"
  exit 1
fi

# Ensure output directory exists
mkdir -p output/pdf

latexmk -pdf -interaction=nonstopmode -output-directory=output/pdf "$FILE"

echo "Done. PDF saved to output/pdf/"
