#!/bin/bash
# Verification script for RST to Markdown conversion

cd /home/runner/work/pymastery-vp/pymastery-vp

echo "=== Conversion Verification ==="
echo ""

# Count source files
src_count=$(find src/ -name "*.rst" -o -name "*.txt" 2>/dev/null | wc -l)
echo "Source .rst/.txt files: $src_count"

# Count target files
md_count=$(find content/en/ -name "*.md" 2>/dev/null | wc -l)
echo "Target .md files: $md_count"

# File count should match
echo ""
if [ "$src_count" -eq "$md_count" ]; then
  echo "✓ File count matches"
else
  echo "✗ File count mismatch!"
fi

# Check for common conversion issues
echo ""
echo "=== Checking for conversion issues ==="
echo ""

# Check for unconverted reST syntax
unconverted_rst=$(grep -r "^\.\. " content/en/ 2>/dev/null | wc -l)
if [ "$unconverted_rst" -eq "0" ]; then
  echo "✓ No unconverted reST directives found"
else
  echo "✗ Found $unconverted_rst unconverted reST directives"
  grep -r "^\.\. " content/en/ 2>/dev/null | head -5
fi

# Check for broken links (basic check)
echo ""
unconverted_doc=$(grep -r ":doc:" content/en/ 2>/dev/null | wc -l)
if [ "$unconverted_doc" -eq "0" ]; then
  echo "✓ No unconverted :doc: links found"
else
  echo "✗ Found $unconverted_doc unconverted :doc: links"
  grep -r ":doc:" content/en/ 2>/dev/null | head -5
fi

# Check for Material admonitions
echo ""
admonition_count=$(grep -r "^!!! " content/en/ 2>/dev/null | wc -l)
echo "✓ Found $admonition_count Material-style admonitions"

# Check for standard code blocks
echo ""
code_block_count=$(grep -r "^``" content/en/ 2>/dev/null | wc -l)
echo "✓ Found $code_block_count Markdown code blocks"

# Verify src/ directory is unchanged
echo ""
echo "=== Verifying src/ directory ==="
src_modified=$(git status --porcelain src/ 2>/dev/null | wc -l)
if [ "$src_modified" -eq "0" ]; then
  echo "✓ src/ directory unchanged"
else
  echo "✗ src/ directory has been modified!"
  git status --porcelain src/
fi

echo ""
echo "=== Verification complete ==="
