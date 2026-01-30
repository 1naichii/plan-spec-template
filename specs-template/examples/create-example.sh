#!/bin/bash

# Example Spec Generator
# Creates a new example spec based on template

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: ./create-example.sh \"Example Name\" \"domain\""
  echo "Domains: software, business, marketing, operations, product"
  echo ""
  echo "Example:"
  echo "  ./create-example.sh \"Email Campaign\" marketing"
  exit 1
fi

TITLE=$1
DOMAIN=$2
FILENAME="examples/${DOMAIN}/example-${TITLE,,}.md"

# Validate domain
if [[ ! "software business marketing operations product" =~ $DOMAIN ]]; then
  echo "Error: Invalid domain '$DOMAIN'"
  echo "Valid domains: software, business, marketing, operations, product"
  exit 1
fi

# Check if file exists
if [ -f "$FILENAME" ]; then
  echo "Error: File already exists: $FILENAME"
  exit 1
fi

# Create example from template
cat > "$FILENAME" << 'EOF'
# Spec: [Example Title]

## Status: PENDING

## Context & User Story
> As a [stakeholder/user type]
> I want [specific improvement, feature, or action]
> So that [clear benefit or outcome]

**Priority:** [CRITICAL | HIGH | MEDIUM | LOW]

## Requirements
- [Requirement 1 - What needs to be done]
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
| [Metric 2] | [Value] | [Value] | [ ] |

## Implementation Notes

### Pre-Implementation
[Document any prerequisites, dependencies, or setup required]

### During Implementation
[Document decisions and technical details as work progresses]

### Post-Implementation
[Document results, metrics, and lessons learned]
EOF

# Replace placeholders
sed -i "s/\[Example Title\]/$TITLE/" "$FILENAME"

echo "Created: $FILENAME"
echo ""
echo "Next steps:"
echo "1. Fill in the user story, requirements, and acceptance criteria"
echo "2. Update items to modify with your specific files/processes"
echo "3. Add test scenarios and success metrics"
echo "4. Update examples/README.md to reference your example"
