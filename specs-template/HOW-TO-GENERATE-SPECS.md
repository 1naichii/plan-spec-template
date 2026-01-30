# How to Generate Specs

This comprehensive guide explains how to create and structure specifications for **any project type** using a systematic, phase-based approach. The methodology works for software development, business process improvement, marketing campaigns, operations optimization, and more.

## Table of Contents
1. [Quick Start](#quick-start)
2. [Understanding the Spec Template](#understanding-the-spec-template)
3. [Writing Effective Specs](#writing-effective-specs)
4. [Universal Application by Project Type](#universal-application-by-project-type)
5. [Step-by-Step Spec Creation](#step-by-step-spec-creation)
6. [Batch Spec Creation](#batch-spec-creation)
7. [Quality Validation](#quality-validation)
8. [Examples by Project Type](#examples-by-project-type)
9. [Tools and Automation](#tools-and-automation)
10. [Best Practices](#best-practices)

---

## Quick Start

### What is a Spec?

A **Spec** (specification) is a detailed, actionable document that defines what needs to be built, fixed, improved, or changed. It provides:

- **Clear requirements** - What needs to be done
- **Acceptance criteria** - Specific, testable requirements
- **Implementation tasks** - Step-by-step action items
- **Testing scenarios** - How to verify the work
- **Success metrics** - How to measure success

### Why Use Specs?

1. **Clarity** - Everyone understands what needs to be done
2. **Testability** - Clear criteria for completion
3. **Tracking** - Progress can be measured
4. **Reusability** - Patterns and templates for future work
5. **Documentation** - Permanent record of decisions and implementation

### 3-Minute Setup

```bash
# 1. Copy the spec template
cp specs/SPEC-TEMPLATE.md specs/my-new-spec.md

# 2. Open the file and fill in the placeholders
# - [Title] → Clear, descriptive title
# - Status → PENDING (default)
# - [User Story] → As a [who], I want [what], so that [why]
# - Requirements → List of what needs to be done
# - Acceptance Criteria → Specific, testable checkboxes
# - Items to Modify → Files, processes, APIs, etc.

# 3. Start implementation!
```

---

## Understanding the Spec Template

The spec template (`SPEC-TEMPLATE.md`) contains 10 key sections:

### 1. Header & Status
```markdown
# Spec: [Title]

## Status: [PENDING | IN_PROGRESS | COMPLETE]
```

**Purpose:** Identify the spec and track its progress.

### 2. Context & User Story
```markdown
> As a [stakeholder/user type]
> I want [specific improvement, feature, or action]
> So that [clear benefit or outcome]

**Priority:** [CRITICAL | HIGH | MEDIUM | LOW]
```

**Purpose:** Provide context and explain **why** the work is needed.

### 3. Requirements
```markdown
## Requirements
- [Requirement 1 - What needs to be built/fixed/improved]
- [Requirement 2 - Specific feature or capability]
- [Requirement 3 - Constraint or limitation]
- [Requirement 4 - Non-functional requirement]
```

**Purpose:** List **what** needs to be done (not **how**).

### 4. Acceptance Criteria
```markdown
## Acceptance Criteria
- [ ] [Specific, testable criterion 1 - Must have]
- [ ] [Specific, testable criterion 2 - Must have]
- [ ] [Specific, testable criterion 3 - Should have]
- [ ] [Specific, testable criterion 4 - Should have]
- [ ] [Edge case 1 - Error handling, empty states, etc.]
- [ ] [Edge case 2 - Loading states, timeouts, etc.]

**Output when complete:** `<promise>DONE</promise>`
```

**Purpose:** Define **when** the work is complete (testable criteria).

### 5. Items to Modify
```markdown
## Items to Modify
- `path/to/item1` [file | process | document | API endpoint | configuration | database table]
- `path/to/item2` [file | process | document | API endpoint | configuration | database table]
```

**Purpose:** Identify **which** items are affected.

### 6. Implementation Tasks
```markdown
## Implementation Tasks
- [ ] [Step 1: Analysis/Setup]
- [ ] [Step 2: Core implementation]
- [ ] [Step 3: Testing/Validation]
- [ ] [Step 4: Documentation/Updates]
```

**Purpose:** Break down the work into **how** to do it.

### 7. Testing & Validation
```markdown
## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| [Scenario 1] | [Local/Staging/Prod] | [CRITICAL/HIGH/MEDIUM] | [ ] |

### Validation Methods
- [ ] Manual testing (QA verification)
- [ ] Automated tests (unit/integration/e2e)
- [ ] Performance testing (load/stress)
- [ ] Accessibility testing (WCAG compliance)
- [ ] Security testing (vulnerability scan)
- [ ] User acceptance testing (stakeholder approval)

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| [Metric 1] | [Value] | [Value] | [ ] |
```

**Purpose:** Define **how to verify** the work is complete.

### 8. Implementation Notes
```markdown
## Implementation Notes

### Pre-Implementation
[Document any prerequisites, dependencies, or setup required]

### During Implementation
[Document decisions, approaches, technical details]

### Post-Implementation
[Document results, metrics, lessons learned]

### Known Issues & Limitations
[Document any known issues, edge cases, or limitations]

### References
- [Documentation link 1]
- [Related issue/PR link 1]
```

**Purpose:** Document **what happened** during implementation.

---

## Writing Effective Specs

### 1. Requirements

Requirements describe **what** needs to be built, fixed, or improved. Each requirement should be:

- **Clear and concise** - Easy to understand
- **Action-oriented** - Describes an action or capability
- **Independent of implementation** - Doesn't specify how
- **Focused** - One thing per requirement

#### Good Examples:

**Frontend:**
- Ensure table rows are easily tappable on mobile devices
- Add proper scroll indicators for horizontal scrolling tables
- Implement loading skeletons while data fetches
- Support light/dark mode toggle

**Backend:**
- Fetch user profile data from database
- Implement rate limiting for API endpoints
- Add request validation middleware
- Support pagination for large datasets

**Business Process:**
- Streamline approval workflow
- Automate notification system
- Create training documentation
- Establish KPI tracking framework

**DevOps:**
- Set up automated deployment pipeline
- Configure monitoring and alerting
- Implement backup and restore procedures
- Add SSL certificate management

#### Bad Examples:
- Use `fetchAdminDashboardStats(dateRange)` function in `app/admin/dashboard/page.tsx` (too specific)
- Add `useState` hook to manage state (implementation detail)
- Call API on component mount (implementation detail)
- Make it work (too vague)
- Improve the feature (too vague)

### 2. Acceptance Criteria

Acceptance criteria must be **specific, measurable, and testable**.

#### Guidelines:

1. **Be specific** - Use exact values, file names, function names
2. **Make it testable** - Can be verified by testing or inspection
3. **One criterion per checkbox**
4. **Include edge cases** - Error states, loading states, empty states
5. **Define success criteria** - Quantifiable metrics where applicable

#### Good Examples:

**Frontend:**
- [ ] Table rows have `min-h-[56px]` minimum height
- [ ] Table cells have `py-4 sm:py-4` padding for touch targets
- [ ] Horizontal scroll works smoothly on mobile (momentum-based)
- [ ] Loading skeleton displays while fetching data (2s delay max)
- [ ] Error boundary catches and displays user-friendly error message
- [ ] All tables tested on iPhone SE (375px) and iPad Mini (768px)

**Backend:**
- [ ] `GET /api/users/{id}` returns 200 with user data
- [ ] Missing user returns 404 with error message: "User not found"
- [ ] Invalid ID format returns 400 with validation errors
- [ ] Response time (p95) under 200ms for cached requests
- [ ] Rate limit of 100 requests per minute enforced
- [ ] Request validation rejects malformed JSON with 400 status

**DevOps:**
- [ ] CI pipeline completes in under 10 minutes for typical changes
- [ ] Automated tests run on every push
- [ ] Deployment to staging is automatic on merge to main
- [ ] Production deployment requires manual approval
- [ ] Rollback procedure restores previous version in under 5 minutes

**Business:**
- [ ] Approval process completes within 1 business day
- [ ] Notification email sent within 5 minutes of approval
- [ ] Training materials include step-by-step screenshots
- [ ] KPI dashboard updates automatically within 15 minutes

#### Bad Examples:
- [ ] Make it work
- [ ] Implement the feature
- [ ] Fix bugs
- [ ] Ensure good UX
- [ ] Optimize performance
- [ ] Improve the process

### 3. Items to Modify

List all items that will be created or modified. Use relative paths and specify the item type.

#### Format:
```markdown
- `path/to/item` [file | process | document | API endpoint | configuration | database table]
```

#### Examples:

**Frontend:**
- `src/components/shared/data-table.tsx` [file]
- `app/(student)/dashboard/page.tsx` [file]
- `src/components/admin/user-growth-chart.tsx` [file]
- `styles/table.css` [file]

**Backend:**
- `src/api/users.ts` [file]
- `src/middleware/auth.ts` [file]
- `GET /api/users/{id}` [API endpoint]
- `POST /api/users` [API endpoint]
- `users` [database table]

**DevOps:**
- `.github/workflows/ci.yml` [file]
- `docker-compose.yml` [file]
- `k8s/deployment.yaml` [file]
- `terraform/main.tf` [file]

**Business:**
- `docs/approval-process.md` [document]
- `templates/email-notification.html` [file]
- `scripts/deploy.sh` [file]
- `Employee Onboarding` [process]

### 4. Implementation Tasks

Break down the work into actionable steps. Each step should be:
- **Specific and actionable** - Clear what needs to be done
- **Sequenced logically** - In the order they should be completed
- **Estimated** - Completable in 30-60 minutes each

#### Examples:
- [ ] Analyze current implementation and identify changes needed
- [ ] Create/update component with new functionality
- [ ] Add error handling and loading states
- [ ] Write unit tests for new functionality
- [ ] Update documentation and comments
- [ ] Create PR for code review

### 5. Testing Scenarios

Define test scenarios across different environments and contexts.

#### Frontend Example:
| Scenario | Device/Browser | Priority | Status |
|----------|----------------|----------|--------|
| Table layout on mobile | iPhone SE (375px) | CRITICAL | [ ] |
| Table layout on tablet | iPad Mini (768px) | HIGH | [ ] |
| Table layout on desktop | Chrome (1440px) | MEDIUM | [ ] |
| Keyboard navigation | Firefox | HIGH | [ ] |
| Screen reader | NVDA | HIGH | [ ] |

#### Backend Example:
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| Successful request | Local development | CRITICAL | [ ] |
| Error handling | Staging | CRITICAL | [ ] |
| Performance test | Production | HIGH | [ ] |
| Load test (1000 req/s) | Staging | HIGH | [ ] |

### 6. Success Metrics

Define measurable success metrics. Establish baselines and set targets.

#### Frontend Example:
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Lighthouse Performance | 65/100 | 85/100 | [ ] |
| Bundle size | 250 KB | 200 KB | [ ] |
| First Contentful Paint | 1.8s | 1.2s | [ ] |

#### Backend Example:
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| API response time (p95) | 500ms | 200ms | [ ] |
| Error rate | 2% | 0.5% | [ ] |
| Throughput | 500 req/s | 1000 req/s | [ ] |

#### Business Example:
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Approval time | 5 days | 1 day | [ ] |
| Process error rate | 15% | 3% | [ ] |
| User satisfaction | 3.2/5 | 4.5/5 | [ ] |

---

## Universal Application by Project Type

### Software Development

#### Frontend/Web Apps
- UI components, pages, state management
- Responsive design, accessibility
- Performance optimization
- API integration

#### Backend/APIs
- Endpoints, database operations
- Authentication, authorization
- Business logic implementation
- Rate limiting, caching

#### Mobile Apps
- Screens, features, device-specific implementations
- Push notifications, offline support
- Performance optimization

#### DevOps/Infrastructure
- CI/CD pipelines, monitoring
- Deployment configurations
- Infrastructure as code

### Business Process
- Workflow improvements
- Process automation
- Documentation updates
- Training materials, SOPs

### Marketing & Sales
- Campaign implementations
- Landing pages
- Tracking setup, analytics
- Conversion optimization

### Product & Design
- Feature development
- UX improvements
- Design system updates
- User research implementation

### Team & Organization
- Documentation
- Communication workflows
- Onboarding processes
- Productivity improvements

---

## Step-by-Step Spec Creation

### Step 1: Identify the Need

Start by understanding **why** the work is needed:

- What problem are we solving?
- Who is affected by this problem?
- What would success look like?

**Example:**
- Problem: Mobile users can't interact with data tables on small screens
- Affected users: Mobile users on iPhone SE (375px) and similar devices
- Success: Tables are usable on all mobile devices

### Step 2: Write the User Story

Use the standard format:

```
> As a [stakeholder/user type]
> I want [specific improvement, feature, or action]
> So that [clear benefit or outcome]
```

**Example:**
```
> As a mobile user viewing data tables on my phone
> I want table rows to have adequate spacing and touch targets
> So that I can easily interact with the table without frustration
```

### Step 3: Define Requirements

List what needs to be built, fixed, or improved:

**Example:**
- Ensure table rows are easily tappable on mobile devices
- Add proper scroll indicators for horizontal scrolling tables
- Make table navigation intuitive and frustration-free
- Support iPhone SE (375px) and iPad Mini (768px)

### Step 4: Write Acceptance Criteria

Define specific, testable criteria:

**Example:**
- [ ] Table rows have `min-h-[56px]` minimum height
- [ ] Table cells have `py-4 sm:py-4` padding for touch targets
- [ ] Horizontal scroll works smoothly on mobile (momentum-based)
- [ ] Horizontal scroll container has visual scroll indicator
- [ ] Table header is sticky on scroll
- [ ] All tables tested on iPhone SE (375px) and iPad Mini (768px)

### Step 5: Identify Items to Modify

List files, APIs, processes, etc. that will be affected:

**Example:**
- `src/components/shared/data-table.tsx` [file]
- `app/(student)/subscription/history/page.tsx` [file]
- `styles/table.css` [file]

### Step 6: Break Down into Tasks

Create a step-by-step implementation plan:

**Example:**
- [ ] Analyze current table implementation
- [ ] Add minimum height and padding to table rows
- [ ] Implement smooth horizontal scroll with indicators
- [ ] Add sticky header support
- [ ] Test on iPhone SE and iPad Mini
- [ ] Update documentation

### Step 7: Define Testing and Validation

Specify how to verify the work:

**Example:**
| Scenario | Device | Priority | Status |
|----------|--------|----------|--------|
| Table layout on mobile | iPhone SE (375px) | CRITICAL | [ ] |
| Table layout on tablet | iPad Mini (768px) | HIGH | [ ] |

### Step 8: Set Success Metrics

Define measurable goals:

**Example:**
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Touch target size | 32px | 56px | [ ] |
| User testing score | 3.5/5 | 4.5/5 | [ ] |

### Step 9: Create the Spec File

```bash
cp specs/SPEC-TEMPLATE.md specs/my-new-spec.md
```

Fill in all sections using the information gathered.

### Step 10: Validate the Spec

Run validation checks:

```bash
# Check all required sections are present
grep -q "## Status:" specs/my-new-spec.md || echo "Missing Status"
grep -q "## Requirements" specs/my-new-spec.md || echo "Missing Requirements"
grep -q "## Acceptance Criteria" specs/my-new-spec.md || echo "Missing Acceptance Criteria"
grep -q "## Items to Modify" specs/my-new-spec.md || echo "Missing Items to Modify"
grep -q "<promise>DONE</promise>" specs/my-new-spec.md || echo "Missing DONE promise"

# Count acceptance criteria
count=$(grep -c '\[ \]' specs/my-new-spec.md)
echo "Acceptance criteria: $count (minimum: 3)"
```

---

## Batch Spec Creation

When creating multiple specs at once, use a systematic approach:

### Step 1: Gather Requirements

Start with a list of user stories, features, or requirements:

```
User Stories:
- US-1.1: Make table rows tap-friendly on mobile
- US-1.2: Add tablet breakpoints (768px, 1024px)
- US-1.3: Make modals responsive on all devices
- US-1.4: Scale components properly on different screens
```

### Step 2: Group Related Stories

Map stories to spec files based on scope:

```
Spec 1: phase-1-table-touch-targets.md
  - US-1.1 (table rows tap-friendly)
  - US-1.11 (table navigation intuitive)

Spec 2: phase-1-tablet-breakpoints.md
  - US-1.2 (tablet breakpoints)
  - US-1.10 (responsive layout adjustments)

Spec 3: phase-1-modal-responsive.md
  - US-1.3 (modal responsiveness)
```

**Key principles:**
- One spec should be completable in 1-2 hours
- Related work goes together
- Keep specs focused on one major feature
- Avoid creating specs that are too broad

### Step 3: Create Spec Files

Use automation scripts to generate spec files from a requirements file.

See `README.md` in the specs directory for detailed batch creation instructions.

---

## Quality Validation

### Pre-Creation Checklist

Before creating a spec, ensure you have:

- [ ] Clear understanding of the problem being solved
- [ ] Identified stakeholders who will use/approve the work
- [ ] Defined success criteria
- [ ] Known any dependencies or blockers
- [ ] Set priority level (CRITICAL/HIGH/MEDIUM/LOW)

### Post-Creation Checklist

After creating a spec, validate:

- [ ] Title is clear and descriptive
- [ ] User story follows the correct format
- [ ] Requirements are clear and action-oriented
- [ ] All requirements are covered by acceptance criteria
- [ ] Acceptance criteria are specific and testable
- [ ] At least 3 acceptance criteria (more for complex specs)
- [ ] Items to modify are listed with types
- [ ] Implementation tasks are broken down into 30-60 min steps
- [ ] Test scenarios are defined
- [ ] Success metrics have baselines and targets
- [ ] `<promise>DONE</promise>` completion signal is present

### Validation Script

```bash
#!/bin/bash

# Validate all specs in a directory
for file in specs/*.md; do
  if [[ "$file" == *"TEMPLATE"* ]]; then
    continue
  fi

  echo "Validating $file..."

  errors=0

  # Check required sections
  for section in "## Status" "## Requirements" "## Acceptance Criteria" "## Items to Modify"; do
    if ! grep -q "$section" "$file"; then
      echo "  ❌ Missing: $section"
      errors=$((errors + 1))
    fi
  done

  # Check completion signal
  if ! grep -q '<promise>DONE</promise>' "$file"; then
    echo "  ❌ Missing: <promise>DONE</promise>"
    errors=$((errors + 1))
  fi

  # Count acceptance criteria
  criteria=$(grep -c '\[ \]' "$file" || echo 0)
  if [ "$criteria" -lt 3 ]; then
    echo "  ⚠️  Only $criteria criteria (minimum: 3)"
  fi

  # Check for empty implementation notes
  if grep -q "## Implementation Notes" "$file"; then
    notes=$(sed -n '/## Implementation Notes/,/^## /p' "$file" | grep -v "^##" | grep -v "^$" | wc -l)
    if [ "$notes" -lt 2 ]; then
      echo "  ℹ️  Implementation notes section is empty (optional)"
    fi
  fi

  if [ $errors -eq 0 ]; then
    echo "  ✅ Valid"
  else
    echo "  ❌ Found $errors errors"
  fi
done
```

---

## Examples by Project Type

### Example 1: Frontend/Web App Spec

```markdown
# Spec: Fix Table Layout on Mobile Devices

## Status: PENDING

## Context & User Story
> As a mobile user viewing data tables on my phone
> I want table rows to have adequate spacing and touch targets
> So that I can easily interact with the table without frustration

**Priority:** HIGH

## Requirements
- Ensure table rows are easily tappable on mobile devices
- Add proper scroll indicators for horizontal scrolling tables
- Make table navigation intuitive and frustration-free
- Support iPhone SE (375px) and iPad Mini (768px)

## Acceptance Criteria
- [ ] Table rows have `min-h-[56px]` minimum height
- [ ] Table cells have `py-4 sm:py-4` padding for touch targets
- [ ] Horizontal scroll works smoothly on mobile (momentum-based)
- [ ] Horizontal scroll container has visual scroll indicator
- [ ] Table header is sticky on scroll
- [ ] All tables tested on iPhone SE (375px) and iPad Mini (768px)

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `src/components/shared/data-table.tsx` [file]
- `app/(student)/subscription/history/page.tsx` [file]
- `styles/table.css` [file]

## Implementation Tasks
- [ ] Analyze current table implementation
- [ ] Add minimum height and padding to table rows
- [ ] Implement smooth horizontal scroll with indicators
- [ ] Add sticky header support
- [ ] Test on iPhone SE and iPad Mini
- [ ] Update documentation

## Testing & Validation

### Test Scenarios
| Scenario | Device | Priority | Status |
|----------|--------|----------|--------|
| Table layout on mobile | iPhone SE (375px) | CRITICAL | [ ] |
| Table layout on tablet | iPad Mini (768px) | HIGH | [ ] |
| Horizontal scroll | Mobile Safari | HIGH | [ ] |
| Sticky header | All devices | MEDIUM | [ ] |

### Validation Methods
- [ ] Manual testing (QA verification)
- [ ] Automated tests (unit/integration/e2e)
- [ ] Accessibility testing (WCAG compliance)

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Touch target size | 32px | 56px | [ ] |
| User testing score | 3.5/5 | 4.5/5 | [ ] |

## Implementation Notes

### Pre-Implementation
- Identified 12 tables across the application affected by this issue
- Consulted iOS Human Interface Guidelines for touch target recommendations

### During Implementation
- Document decisions and technical details here

### Post-Implementation
- Document results, metrics, and lessons learned here
```

### Example 2: Backend/API Spec

```markdown
# Spec: Implement User Profile API Endpoint

## Status: PENDING

## Context & User Story
> As a frontend developer consuming the API
> I want a reliable endpoint to fetch user profile data
> So that I can display user information in the application

**Priority:** CRITICAL

## Requirements
- Fetch user profile data from database
- Implement request validation
- Add rate limiting to prevent abuse
- Support caching for better performance

## Acceptance Criteria
- [ ] `GET /api/users/{id}` returns 200 with user data in correct format
- [ ] Missing user returns 404 with error message: "User not found"
- [ ] Invalid ID format returns 400 with validation errors
- [ ] Rate limit of 100 requests per minute enforced
- [ ] Response time (p95) under 200ms for cached requests
- [ ] Response includes all required fields (id, name, email, role)

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `src/api/users.ts` [file]
- `src/middleware/rate-limit.ts` [file]
- `src/middleware/validation.ts` [file]
- `GET /api/users/{id}` [API endpoint]
- `users` [database table]

## Implementation Tasks
- [ ] Create user profile endpoint handler
- [ ] Add input validation middleware
- [ ] Implement rate limiting
- [ ] Add caching layer (Redis)
- [ ] Write unit tests for endpoint
- [ ] Update API documentation

## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| Successful request | Local | CRITICAL | [ ] |
| Missing user | Staging | CRITICAL | [ ] |
| Invalid ID format | Staging | HIGH | [ ] |
| Rate limit test | Production | HIGH | [ ] |
| Performance test | Production | HIGH | [ ] |

### Validation Methods
- [ ] Manual testing (curl/Postman)
- [ ] Automated tests (unit/integration)
- [ ] Load testing (1000 req/s)
- [ ] API documentation verification

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Response time (p95) | N/A | 200ms | [ ] |
| Error rate | N/A | <1% | [ ] |
| Throughput | N/A | 1000 req/s | [ ] |

## Implementation Notes

### Pre-Implementation
- Database schema already exists with required fields
- Redis cache server is available in all environments
- JWT authentication already implemented

### During Implementation
- Document decisions and technical details here

### Post-Implementation
- Document results, metrics, and lessons learned here
```

### Example 3: Business Process Spec

```markdown
# Spec: Streamline Employee Approval Workflow

## Status: PENDING

## Context & User Story
> As an employee waiting for approval
> I want the approval workflow to be automated and fast
> So that I can proceed with my work without delays

**Priority:** HIGH

## Requirements
- Automate approval notification system
- Reduce approval time from 5 days to 1 day
- Implement real-time status tracking
- Add approval history and audit trail

## Acceptance Criteria
- [ ] Approval process completes within 1 business day
- [ ] Notification email sent within 5 minutes of approval/rejection
- [ ] Real-time status updates in approval dashboard
- [ ] Approval history shows all actions with timestamps
- [ ] Audit trail compliant with ISO 27001 standards
- [ ] Workflow handles edge cases (approval on leave, delegation)

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `workflows/approval-process.bpmn` [process]
- `src/approval/notification-service.ts` [file]
- `src/approval/status-tracker.ts` [file]
- `docs/approval-process-sop.md` [document]
- `templates/approval-notification.html` [file]

## Implementation Tasks
- [ ] Analyze current approval workflow
- [ ] Design automated notification system
- [ ] Implement real-time status tracking
- [ ] Create approval history and audit trail
- [ ] Update SOP documentation
- [ ] Train staff on new workflow

## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| End-to-end approval flow | Staging | CRITICAL | [ ] |
| Notification delivery | Production | CRITICAL | [ ] |
| Approval on leave (delegation) | Staging | HIGH | [ ] |
| Audit trail verification | Production | HIGH | [ ] |

### Validation Methods
- [ ] Manual testing (QA verification)
- [ ] User acceptance testing (UAT)
- [ ] Compliance review (ISO 27001)
- [ ] Performance testing (1000 concurrent approvals)

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Approval time | 5 days | 1 day | [ ] |
| Notification time | N/A | <5 min | [ ] |
| User satisfaction | 3.2/5 | 4.5/5 | [ ] |
| Process error rate | 15% | 3% | [ ] |

## Implementation Notes

### Pre-Implementation
- Current process uses manual email and spreadsheets
- Approval managers identified: 15 approvers across departments
- Delegation rules already defined in HR policy

### During Implementation
- Document decisions and technical details here

### Post-Implementation
- Document results, metrics, and lessons learned here
```

### Example 4: DevOps/Infrastructure Spec

```markdown
# Spec: Implement CI/CD Pipeline with Automated Testing

## Status: PENDING

## Context & User Story
> As a developer working on features
> I want the CI pipeline to run automatically on every push
> So that I can get quick feedback and catch issues early

**Priority:** CRITICAL

## Requirements
- Set up automated CI pipeline
- Run tests on every push and pull request
- Deploy to staging automatically on merge to main
- Implement manual approval for production deployment
- Add pipeline metrics and notifications

## Acceptance Criteria
- [ ] CI pipeline triggers on every push to feature branches
- [ ] Pipeline completes in under 10 minutes for typical changes
- [ ] All tests (unit, integration, e2e) run in pipeline
- [ ] Deployment to staging is automatic on merge to main
- [ ] Production deployment requires manual approval
- [ ] Rollback procedure restores previous version in under 5 minutes
- [ ] Pipeline failures send Slack notifications to team

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `.github/workflows/ci.yml` [file]
- `.github/workflows/deploy-staging.yml` [file]
- `.github/workflows/deploy-production.yml` [file]
- `docker-compose.yml` [file]
- `scripts/rollback.sh` [file]

## Implementation Tasks
- [ ] Configure CI workflow with test execution
- [ ] Set up automatic deployment to staging
- [ ] Configure manual approval for production
- [ ] Implement rollback script
- [ ] Add Slack notifications for pipeline status
- [ ] Document pipeline usage and troubleshooting

## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| Successful CI run | Test repo | CRITICAL | [ ] |
| Failed test detection | Test repo | CRITICAL | [ ] |
| Staging deployment | Staging | HIGH | [ ] |
| Production rollback | Production | HIGH | [ ] |
| Rollback time | Production | HIGH | [ ] |

### Validation Methods
- [ ] Manual testing (push to test repo)
- [ ] Load testing (100 concurrent pipeline runs)
- [ ] Security testing (GitHub Actions security)
- [ ] Performance testing (pipeline duration)

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Pipeline duration | N/A | <10 min | [ ] |
| Test coverage | 60% | 85% | [ ] |
| Deployment frequency | Weekly | Daily | [ ] |
| Rollback time | N/A | <5 min | [ ] |

## Implementation Notes

### Pre-Implementation
- GitHub Actions already configured for basic workflow
- Test suite exists with 200+ tests
- Staging and production environments already set up

### During Implementation
- Document decisions and technical details here

### Post-Implementation
- Document results, metrics, and lessons learned here
```

---

## Tools and Automation

### 1. Spec Generator Script

Create a script to generate spec files from a template:

```bash
#!/bin/bash

# Usage: ./create-spec.sh "Spec Title" "HIGH"

TITLE=$1
PRIORITY=$2
FILENAME="specs/$(echo $TITLE | tr '[:upper:]' '[:lower:]' | tr ' ' '-').md"

cp specs/SPEC-TEMPLATE.md "$FILENAME"

sed -i "s/\[Title\]/$TITLE/" "$FILENAME"
sed -i "s/\[PENDING\]/PENDING/" "$FILENAME"
sed -i "s/\[CRITICAL | HIGH | MEDIUM | LOW\]/$PRIORITY/" "$FILENAME"

echo "Created: $FILENAME"
```

### 2. Spec Validator Script

```bash
#!/bin/bash

# Validate all specs
for file in specs/*.md; do
  if [[ "$file" == *"TEMPLATE"* ]]; then
    continue
  fi

  echo "Checking $file..."

  if ! grep -q "## Status:" "$file"; then
    echo "  ❌ Missing Status"
  fi

  if ! grep -q "## Requirements" "$file"; then
    echo "  ❌ Missing Requirements"
  fi

  if ! grep -q "## Acceptance Criteria" "$file"; then
    echo "  ❌ Missing Acceptance Criteria"
  fi

  if ! grep -q '<promise>DONE</promise>' "$file"; then
    echo "  ❌ Missing DONE promise"
  fi

  CRITERIA=$(grep -c '\[ \]' "$file")
  if [ "$CRITERIA" -lt 3 ]; then
    echo "  ⚠️  Only $CRITERIA criteria (minimum: 3)"
  fi
done
```

### 3. Progress Tracker Script

```bash
#!/bin/bash

# Track spec progress
PENDING=$(grep -l "Status: PENDING" specs/*.md | wc -l)
IN_PROGRESS=$(grep -l "Status: IN_PROGRESS" specs/*.md | wc -l)
COMPLETE=$(grep -l "Status: COMPLETE" specs/*.md | wc -l)

echo "Spec Progress:"
echo "  PENDING: $PENDING"
echo "  IN_PROGRESS: $IN_PROGRESS"
echo "  COMPLETE: $COMPLETE"
echo "  TOTAL: $((PENDING + IN_PROGRESS + COMPLETE))"
```

---

## Best Practices

### 1. Start High-Level, Then Detail

1. **First pass**: Create spec files with basic structure
2. **Second pass**: Add detailed requirements
3. **Third pass**: Flesh out acceptance criteria
4. **Fourth pass**: Identify files to modify
5. **Fifth pass**: Add implementation notes during work

### 2. Use Consistent Naming

```
Good:
- phase-1-table-touch-targets.md
- phase-5-10-admin-dashboard-apis.md
- fix-table-layout-mobile.md
- implement-user-authentication.md

Bad:
- touch-targets.md
- admin.md
- memoization.md
```

### 3. Track Progress

Use the status field to track progress:

```bash
# Count specs by status
echo "PENDING: $(grep -l "Status: PENDING" specs/*.md | wc -l)"
echo "IN_PROGRESS: $(grep -l "Status: IN_PROGRESS" specs/*.md | wc -l)"
echo "COMPLETE: $(grep -l "Status: COMPLETE" specs/*.md | wc -l)"
```

### 4. Validate Before Starting

```bash
# Ensure all specs have at least 3 acceptance criteria
for file in specs/*.md; do
  count=$(grep -c '\[ \]' "$file" || echo 0)
  if [ "$count" -lt 3 ]; then
    echo "WARNING: $file has only $count criteria (minimum: 3)"
  fi
done
```

### 5. Group by Complexity

Organize specs by complexity and skill required:

```
Beginner Specs (1-2 hours each):
- UI fixes (colors, spacing, text)
- Component structure
- Basic API integration

Intermediate Specs (2-4 hours each):
- Complex API patterns
- State management
- Error handling

Advanced Specs (4+ hours each):
- Performance optimization
- Complex data transformations
- Backend integration
```

### 6. Update During Implementation

- Mark criteria as `[x]` when complete
- Update status from PENDING → IN_PROGRESS → COMPLETE
- Document decisions in Implementation Notes
- Add lessons learned after completion

### 7. Link Related Specs

If specs are related, add cross-references:

```markdown
## References
- Related Spec: phase-1-table-touch-targets.md
- Blocked By: phase-2-aria-labels.md
- Blocks: phase-3-memoize-components.md
```

---

## Running Specs with Ralph Wiggum Loop

Once specs are created, start building:

```bash
# Start building specs in order
./scripts/ralph-loop.sh

# Plan mode to see what's coming
./scripts/ralph-loop.sh plan
```

The loop will process specs sequentially, marking each as COMPLETE when all acceptance criteria are met.

---

## Completion Signal

Every spec must end with the completion signal when all acceptance criteria are met:

```markdown
<promise>DONE</promise>
```

This signal is used by the Ralph Wiggum iterative bash loop to know when a spec is complete.

---

## Summary

This universal spec generation system works for:

- ✅ **Software Development** (Frontend, Backend, APIs, Mobile)
- ✅ **Business Process** (Workflows, Automation, Documentation)
- ✅ **Marketing & Sales** (Campaigns, Landing Pages, Analytics)
- ✅ **Product & Design** (Features, UX, Design Systems)
- ✅ **Team & Organization** (Documentation, Workflows)
- ✅ **DevOps & Infrastructure** (CI/CD, Monitoring, Deployments)
- ✅ **Any other project** that benefits from structured planning

The key principles are:
1. **Clear user stories** - As a [who], I want [what], so that [why]
2. **Specific acceptance criteria** - Testable, measurable, verifiable
3. **Comprehensive testing** - Scenarios, validation methods, success metrics
4. **Implementation tracking** - Tasks, notes, references
5. **Completion signal** - `<promise>DONE</promise>` when all criteria met

---

**Version:** 4.0 (Universal)
**Last Updated:** 2026-01-31
**Compatible With:** Any project type (software, business, marketing, operations, etc.)
