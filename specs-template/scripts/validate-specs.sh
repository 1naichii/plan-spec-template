#!/bin/bash

# Spec Validator
# Validates all spec files against template requirements

echo "🔍 Validating spec files..."
echo ""

ERRORS=0
WARNINGS=0

# Get all spec files
SPEC_FILES=$(find specs -name "*.md" -not -path "*/examples/*" -not -path "*/SPEC-TEMPLATE.md" -not -path "*/HOW-TO-GENERATE-SPECS.md" -not -path "*/README.md" -not -path "*/SPECS-OVERVIEW.md" -not -name "example-*.md")

for file in $SPEC_FILES; do
  echo "Checking: $(basename $file)"

  # Check required sections
  for section in "## Status" "## Requirements" "## Acceptance Criteria" "## Items to Modify"; do
    if ! grep -q "$section" "$file"; then
      echo "  ❌ Missing: $section"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Check completion signal
  if ! grep -q '<promise>DONE</promise>' "$file"; then
    echo "  ❌ Missing: <promise>DONE</promise>"
    ERRORS=$((ERRORS + 1))
  fi

  # Count acceptance criteria
  CRITERIA=$(grep -c '\[ \]' "$file" || echo 0)
  if [ "$CRITERIA" -lt 3 ]; then
    echo "  ⚠️  Only $CRITERIA criteria (minimum: 3)"
    WARNINGS=$((WARNINGS + 1))
  fi

  # Check for empty implementation notes (in completed specs)
  if grep -q "Status: COMPLETE" "$file" && grep -q "## Implementation Notes" "$file"; then
    NOTES=$(sed -n '/## Implementation Notes/,/^## /p' "$file" | grep -v "^##" | grep -v "^$" | wc -l)
    if [ "$NOTES" -lt 5 ]; then
      echo "  ℹ️  Implementation notes section is empty or minimal (recommended for completed specs)"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi

  # Check status value
  STATUS=$(grep "## Status:" -A 1 "$file" | tail -1 | xargs)
  if [[ ! "PENDING IN_PROGRESS COMPLETE" =~ $STATUS ]]; then
    echo "  ❌ Invalid status: $STATUS (must be PENDING, IN_PROGRESS, or COMPLETE)"
    ERRORS=$((ERRORS + 1))
  fi

  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Summary
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo "✅ All specs are valid!"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo "⚠️  Found $WARNINGS warning(s), but no errors"
  echo "   Specs are valid, but consider addressing warnings"
  exit 0
else
  echo "❌ Found $ERRORS error(s) and $WARNINGS warning(s)"
  echo "   Please fix errors before continuing"
  exit 1
fi
