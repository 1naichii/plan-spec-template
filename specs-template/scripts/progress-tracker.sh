#!/bin/bash

# Progress Tracker
# Tracks spec completion status across all phases

echo "📊 Spec Progress Report"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get all spec files
SPEC_FILES=$(find specs -name "*.md" -not -path "*/examples/*" -not -path "*/SPEC-TEMPLATE.md" -not -path "*/HOW-TO-GENERATE-SPECS.md" -not -path "*/README.md" -not -path "*/SPECS-OVERVIEW.md" -not -name "example-*.md")

# Count by status
PENDING=0
IN_PROGRESS=0
COMPLETE=0
TOTAL=0

for file in $SPEC_FILES; do
  TOTAL=$((TOTAL + 1))

  # Get status
  STATUS=$(grep "## Status:" -A 1 "$file" | tail -1 | xargs)

  case $STATUS in
    "PENDING")
      PENDING=$((PENDING + 1))
      ;;
    "IN_PROGRESS")
      IN_PROGRESS=$((IN_PROGRESS + 1))
      ;;
    "COMPLETE")
      COMPLETE=$((COMPLETE + 1))
      ;;
  esac
done

# Calculate percentages
if [ $TOTAL -gt 0 ]; then
  PENDING_PCT=$((PENDING * 100 / TOTAL))
  IN_PROGRESS_PCT=$((IN_PROGRESS * 100 / TOTAL))
  COMPLETE_PCT=$((COMPLETE * 100 / TOTAL))
else
  PENDING_PCT=0
  IN_PROGRESS_PCT=0
  COMPLETE_PCT=0
fi

# Display overall progress
echo "Overall Progress:"
echo "  Total Specs: $TOTAL"
echo ""
echo "  ✅ Complete:    $COMPLETE ($COMPLETE_PCT%)"
echo "  🔄 In Progress: $IN_PROGRESS ($IN_PROGRESS_PCT%)"
echo "  ⏳ Pending:    $PENDING ($PENDING_PCT%)"
echo ""

# Progress bar
BAR_LENGTH=50
COMPLETED_BARS=$((COMPLETE * BAR_LENGTH / TOTAL))
IN_PROGRESS_BARS=$((IN_PROGRESS * BAR_LENGTH / TOTAL))

echo -n "Progress: ["
for ((i=0; i<COMPLETED_BARS; i++)); do echo -n "="; done
for ((i=0; i<IN_PROGRESS_BARS; i++)); do echo -n "▓"; done
for ((i=$((COMPLETED_BARS + IN_PROGRESS_BARS)); i<BAR_LENGTH; i++)); do echo -n " "; done
echo "] $COMPLETE_PCT%"
echo ""

# Count by phase
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Progress by Phase:"
echo ""

for phase in phase-1-responsive-fixes phase-2-accessibility phase-3-performance phase-4-polish phase-5-api-integration; do
  PHASE_DIR="specs/$phase"

  if [ ! -d "$PHASE_DIR" ]; then
    continue
  fi

  # Get files in phase
  PHASE_FILES=$(find "$PHASE_DIR" -name "*.md")

  if [ -z "$PHASE_FILES" ]; then
    continue
  fi

  PHASE_TOTAL=0
  PHASE_PENDING=0
  PHASE_IN_PROGRESS=0
  PHASE_COMPLETE=0

  for file in $PHASE_FILES; do
    PHASE_TOTAL=$((PHASE_TOTAL + 1))

    STATUS=$(grep "## Status:" -A 1 "$file" | tail -1 | xargs)

    case $STATUS in
      "PENDING")
        PHASE_PENDING=$((PHASE_PENDING + 1))
        ;;
      "IN_PROGRESS")
        PHASE_IN_PROGRESS=$((PHASE_IN_PROGRESS + 1))
        ;;
      "COMPLETE")
        PHASE_COMPLETE=$((PHASE_COMPLETE + 1))
        ;;
    esac
  done

  # Calculate percentage
  if [ $PHASE_TOTAL -gt 0 ]; then
    PHASE_PCT=$((PHASE_COMPLETE * 100 / PHASE_TOTAL))
  else
    PHASE_PCT=0
  fi

  # Display phase progress
  PHASE_NAME=$(echo "$phase" | sed 's/phase-//' | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
  echo "  $PHASE_NAME:"
  echo "    $PHASE_COMPLETE/$PHASE_TOTAL complete ($PHASE_PCT%)"

  # Progress bar
  COMPLETED_BARS=$((PHASE_COMPLETE * 20 / PHASE_TOTAL))
  IN_PROGRESS_BARS=$((PHASE_IN_PROGRESS * 20 / PHASE_TOTAL))

  echo -n "    ["
  for ((i=0; i<COMPLETED_BARS; i++)); do echo -n "="; done
  for ((i=0; i<IN_PROGRESS_BARS; i++)); do echo -n "▓"; done
  for ((i=$((COMPLETED_BARS + IN_PROGRESS_BARS)); i<20; i++)); do echo -n " "; done
  echo "]"
  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Show IN_PROGRESS specs if any
if [ $IN_PROGRESS -gt 0 ]; then
  echo "🔄 Currently In Progress:"
  echo ""
  for file in $SPEC_FILES; do
    STATUS=$(grep "## Status:" -A 1 "$file" | tail -1 | xargs)
    if [ "$STATUS" = "IN_PROGRESS" ]; then
      echo "  - $(basename $file)"
    fi
  done
  echo ""
fi

# Show COMPLETE specs summary
if [ $COMPLETE -gt 0 ]; then
  echo "✅ Recently Completed:"
  echo ""
  # Show last 5 completed specs (by modification time)
  find specs -name "*.md" -not -path "*/examples/*" -type f -printf "%T@ %p\n" | \
    while read -r timestamp file; do
      STATUS=$(grep "## Status:" -A 1 "$file" | tail -1 | xargs)
      if [ "$STATUS" = "COMPLETE" ]; then
        echo "  - $(basename $file) ($(date -d @$timestamp '+%Y-%m-%d'))"
      fi
    done | sort -rn | head -5
  echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
