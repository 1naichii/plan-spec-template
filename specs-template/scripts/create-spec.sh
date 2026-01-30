#!/bin/bash

# Spec Creator
# Creates a new spec from the universal template

if [ -z "$1" ]; then
  echo "Usage: ./create-spec.sh \"Spec Title\" \"HIGH\""
  echo ""
  echo "Example:"
  echo "  ./create-spec.sh \"Fix Table Layout\" \"HIGH\""
  echo ""
  echo "Priority options: CRITICAL, HIGH, MEDIUM, LOW"
  exit 1
fi

TITLE=$1
PRIORITY=${2:-"MEDIUM"}

# Validate priority
if [[ ! "CRITICAL HIGH MEDIUM LOW" =~ $PRIORITY ]]; then
  echo "Error: Invalid priority '$PRIORITY'"
  echo "Valid priorities: CRITICAL, HIGH, MEDIUM, LOW"
  exit 1
fi

# Create filename from title (lowercase, spaces to hyphens)
FILENAME=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
FILENAME="specs/${FILENAME}.md"

# Check if file already exists
if [ -f "$FILENAME" ]; then
  echo "Error: File already exists: $FILENAME"
  exit 1
fi

# Create spec from template
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
- [Requirement 3 - Constraint or limitation]

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
| [Scenario 2] | [Local/Staging/Prod] | [CRITICAL/HIGH/MEDIUM] | [ ] |

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
sed -i "s/TITLE/$TITLE/" "$FILENAME"
sed -i "s/PRIORITY/$PRIORITY/" "$FILENAME"

echo "✅ Created: $FILENAME"
echo ""
echo "Next steps:"
echo "1. Fill in user story, requirements, and acceptance criteria"
echo "2. Update items to modify with your specific files/processes"
echo "3. Add test scenarios and success metrics"
echo "4. Start implementation"
