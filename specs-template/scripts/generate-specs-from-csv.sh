#!/bin/bash

# Batch Spec Generator from CSV
# Generates multiple specs from a CSV file

if [ -z "$1" ]; then
  echo "Usage: ./generate-specs-from-csv.sh specs.csv"
  echo ""
  echo "CSV Format (no header):"
  echo "  title,priority,domain"
  echo ""
  echo "Example CSV:"
  echo "  Fix Table Layout,HIGH,software"
  echo "  Implement API Endpoint,CRITICAL,backend"
  echo "  Optimize Checkout Flow,HIGH,product"
  echo ""
  echo "Priority options: CRITICAL, HIGH, MEDIUM, LOW"
  echo "Domains: software, business, marketing, operations, product"
  exit 1
fi

CSV_FILE=$1

# Check if CSV exists
if [ ! -f "$CSV_FILE" ]; then
  echo "Error: CSV file not found: $CSV_FILE"
  exit 1
fi

echo "📝 Generating specs from: $CSV_FILE"
echo ""

# Read CSV and generate specs
while IFS=',' read -r title priority domain; do
  # Skip empty lines
  [ -z "$title" ] && continue

  # Skip comments
  [[ "$title" == \#* ]] && continue

  # Create filename
  FILENAME=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  FILENAME="specs/${FILENAME}.md"

  # Check if already exists
  if [ -f "$FILENAME" ]; then
    echo "⚠️  Skipping: $FILENAME (already exists)"
    continue
  fi

  # Create spec
  cat > "$FILENAME" << 'EOF'
# Spec: TITLE

## Status: PENDING

## Context & User Story
> As a [stakeholder/user type]
> I want [specific improvement, feature, or action]
> So that [clear benefit or outcome]

**Priority:** PRIORITY

## Requirements
- [Requirement 1 - What needs to be built/fixed/improved]
- [Requirement 2 - Specific feature or capability]

## Acceptance Criteria
- [ ] [Specific, testable criterion 1 - Must have]
- [ ] [Specific, testable criterion 2 - Must have]
- [ ] [Specific, testable criterion 3 - Should have]

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `path/to/item1` [file | process | document | API endpoint | configuration | database table]
- `path/to/item2` [file | process | document | API endpoint | configuration | database table]

## Implementation Tasks
- [ ] [Step 1: Analysis/Setup]
- [ ] [Step 2: Core implementation]
- [ ] [Step 3: Testing/Validation]
- [ ] [Step 4: Documentation/Updates]

## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| [Scenario 1] | [Local/Staging/Prod] | [CRITICAL/HIGH/MEDIUM] | [ ] |

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| [Metric 1] | [Value] | [Value] | [ ] |

## Implementation Notes

### Pre-Implementation
[Document any prerequisites, dependencies, or setup required]

### During Implementation
[Document decisions, approaches, technical details]

### Post-Implementation
[Document results, metrics, and lessons learned]
EOF

  # Replace placeholders
  sed -i "s/TITLE/$title/" "$FILENAME"
  sed -i "s/PRIORITY/$priority/" "$FILENAME"

  echo "✅ Created: $FILENAME"

done < "$CSV_FILE"

echo ""
echo "✅ Batch generation complete!"
echo ""
echo "Next steps:"
echo "1. Review each generated spec and fill in details"
echo "2. Run ./scripts/validate-specs.sh to check for errors"
echo "3. Update SPECS-OVERVIEW.md if needed"
