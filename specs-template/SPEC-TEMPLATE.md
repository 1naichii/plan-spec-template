# Spec: [Title]

## Status: [PENDING | IN_PROGRESS | COMPLETE]

## Context & User Story
> As a [stakeholder/user type]
> I want [specific improvement, feature, or action]
> So that [clear benefit or outcome]

**Priority:** [CRITICAL | HIGH | MEDIUM | LOW]

## Requirements
- [Requirement 1 - What needs to be built/fixed/improved]
- [Requirement 2 - Specific feature or capability]
- [Requirement 3 - Constraint or limitation]
- [Requirement 4 - Non-functional requirement (performance, accessibility, etc.)]

## Acceptance Criteria
- [ ] [Specific, testable criterion 1 - Must have]
- [ ] [Specific, testable criterion 2 - Must have]
- [ ] [Specific, testable criterion 3 - Should have]
- [ ] [Specific, testable criterion 4 - Should have]
- [ ] [Edge case 1 - Error handling, empty states, etc.]
- [ ] [Edge case 2 - Loading states, timeouts, etc.]

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `path/to/item1` [file | process | document | API endpoint | configuration | database table]
- `path/to/item2` [file | process | document | API endpoint | configuration | database table]
- `path/to/item3` [file | process | document | API endpoint | configuration | database table]

## Implementation Tasks
- [ ] [Step 1: Analysis/Setup]
- [ ] [Step 2: Core implementation]
- [ ] [Step 3: Testing/Validation]
- [ ] [Step 4: Documentation/Updates]
- [ ] [Step 5: Code review/QA handoff]

## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| [Scenario 1] | [Local/Staging/Prod] | [CRITICAL/HIGH/MEDIUM] | [ ] |
| [Scenario 2] | [Local/Staging/Prod] | [CRITICAL/HIGH/MEDIUM] | [ ] |
| [Scenario 3] | [Local/Staging/Prod] | [CRITICAL/HIGH/MEDIUM] | [ ] |

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
| [Metric 2] | [Value] | [Value] | [ ] |
| [Metric 3] | [Value] | [Value] | [ ] |

## Implementation Notes

### Pre-Implementation
[Document any prerequisites, dependencies, or setup required before starting]

### During Implementation
[Document decisions, approaches, technical details as work progresses]

### Post-Implementation
[Document results, metrics, lessons learned after completion]

### Known Issues & Limitations
[Document any known issues, edge cases, or limitations of the implementation]

### References
- [Documentation link 1]
- [Related issue/PR link 1]
- [Stakeholder discussions link 1]

---

## Template Usage Guide

### Universal Application
This template works for **any project type**:

**Software Development:**
- Frontend/Web Apps: UI components, pages, state management, API integration
- Backend/APIs: Endpoints, database operations, authentication, business logic
- Mobile Apps: Screens, features, device-specific implementations
- DevOps/Infrastructure: CI/CD pipelines, monitoring, deployment configurations

**Business Process:**
- Workflow improvements, process automation, documentation updates
- Training materials, SOP creation, operational procedures

**Marketing & Sales:**
- Campaign implementations, landing pages, tracking setup
- Analytics configuration, conversion optimization

**Product & Design:**
- Feature development, UX improvements, design system updates

**Team & Organization:**
- Documentation, communication workflows, onboarding processes

### Filling Out the Template

#### 1. Title
Use clear, descriptive titles:
- ✅ Good: `Implement User Authentication with OAuth`
- ✅ Good: `Fix Table Layout on Mobile Devices`
- ❌ Bad: `Auth Feature`
- ❌ Bad: `Table Fix`

#### 2. Status
- **PENDING**: Not yet started
- **IN_PROGRESS**: Currently being worked on
- **COMPLETE**: All acceptance criteria met, `<promise>DONE</promise>` output

#### 3. Context & User Story
Use the standard user story format:
```
> As a [stakeholder/user type]
> I want [specific improvement, feature, or action]
> So that [clear benefit or outcome]
```

**Examples:**

**Software/Frontend:**
```
> As a mobile user viewing data tables
> I want table rows to have adequate spacing and touch targets
> So that I can easily interact with the table without frustration
```

**Backend/API:**
```
> As a frontend developer consuming the API
> I want the endpoint to return consistent error responses
> So that I can display meaningful error messages to users
```

**DevOps:**
```
> As a developer working on features
> I want the CI pipeline to complete within 10 minutes
> So that I can get quick feedback on my changes
```

**Business Process:**
```
> As an employee following the approval process
> I want the workflow to be streamlined and automated
> So that I can complete approvals faster and with fewer errors
```

**Marketing:**
```
> As a marketing manager launching a campaign
> I want all tracking and analytics properly configured
> So that we can accurately measure campaign performance
```

#### 4. Priority Levels
- **CRITICAL**: Blocks operations, causes major issues, or violates compliance
  - Examples: Security vulnerability, production outage, data loss risk
- **HIGH**: Major impact on effectiveness, efficiency, or user experience
  - Examples: Broken features, slow performance, poor UX
- **MEDIUM**: Nice to have, improves results or polish
  - Examples: Better animations, improved error messages, minor optimizations
- **LOW**: Purely cosmetic, minor improvements, nice-to-have
  - Examples: Color adjustments, spacing tweaks, documentation updates

#### 5. Requirements
List what needs to be built, fixed, or improved. Each requirement should:
- Be clear and concise
- Focus on functionality/behavior (not implementation)
- Include both functional and non-functional requirements

**Examples:**

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

**DevOps:**
- Set up automated deployment pipeline
- Configure monitoring and alerting
- Implement backup and restore procedures
- Add SSL certificate management

**Business:**
- Streamline approval workflow
- Automate notification system
- Create training documentation
- Establish KPI tracking framework

#### 6. Acceptance Criteria
Acceptance criteria must be **specific, measurable, and testable**.

**Guidelines:**
- Each criterion is a checkbox `[ ]` that gets marked `[x]` when complete
- One criterion per checkbox
- Be specific with exact values, file names, function names
- Include edge cases (error handling, loading states, empty states)
- Define success criteria where applicable

**Good Examples:**

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

**Bad Examples:**
- [ ] Make it work
- [ ] Implement the feature
- [ ] Fix bugs
- [ ] Ensure good UX
- [ ] Optimize performance

#### 7. Items to Modify
List all items that will be created or modified. Include:
- Files (with relative paths)
- API endpoints (with HTTP methods and paths)
- Database tables/queries
- Configuration files
- Documentation
- Business processes

**Format:**
```
- `path/to/item` [file | process | document | API endpoint | configuration | database table]
```

**Examples:**

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

#### 8. Implementation Tasks
Break down the work into actionable steps. Each step should be:
- Specific and actionable
- Sequenced logically
- Estimated to be completable in 30-60 minutes

**Examples:**
- [ ] Analyze current implementation and identify changes needed
- [ ] Create/update component with new functionality
- [ ] Add error handling and loading states
- [ ] Write unit tests for new functionality
- [ ] Update documentation and comments
- [ ] Create PR for code review

#### 9. Testing & Validation

##### Test Scenarios
Define test scenarios across different environments:

**Frontend:**
| Scenario | Device/Browser | Priority | Status |
|----------|----------------|----------|--------|
| Table layout on mobile | iPhone SE (375px) | CRITICAL | [ ] |
| Table layout on tablet | iPad Mini (768px) | HIGH | [ ] |
| Table layout on desktop | Chrome (1440px) | MEDIUM | [ ] |
| Keyboard navigation | Firefox | HIGH | [ ] |
| Screen reader | NVDA | HIGH | [ ] |

**Backend:**
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|
| Successful request | Local development | CRITICAL | [ ] |
| Error handling | Staging | CRITICAL | [ ] |
| Performance test | Production | HIGH | [ ] |
| Load test (1000 req/s) | Staging | HIGH | [ ] |

##### Validation Methods
Check which validation methods apply:
- [ ] Manual testing (QA verification)
- [ ] Automated tests (unit/integration/e2e)
- [ ] Performance testing (load/stress)
- [ ] Accessibility testing (WCAG compliance)
- [ ] Security testing (vulnerability scan)
- [ ] User acceptance testing (stakeholder approval)

##### Success Metrics
Define measurable success metrics:

**Frontend:**
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Lighthouse Performance | 65/100 | 85/100 | [ ] |
| Bundle size | 250 KB | 200 KB | [ ] |
| First Contentful Paint | 1.8s | 1.2s | [ ] |

**Backend:**
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| API response time (p95) | 500ms | 200ms | [ ] |
| Error rate | 2% | 0.5% | [ ] |
| Throughput | 500 req/s | 1000 req/s | [ ] |

**Business:**
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Approval time | 5 days | 1 day | [ ] |
| Process error rate | 15% | 3% | [ ] |
| User satisfaction | 3.2/5 | 4.5/5 | [ ] |

#### 10. Implementation Notes
Document the implementation process in three phases:

**Pre-Implementation:**
- Prerequisites (dependencies, tools, permissions)
- Setup requirements
- Known risks or blockers

**During Implementation:**
- Technical decisions and rationale
- Approaches considered vs chosen
- Code patterns used
- Challenges encountered and solutions

**Post-Implementation:**
- Results and metrics
- Lessons learned
- Follow-up tasks or improvements
- Known issues and limitations

**References:**
- Links to relevant documentation
- Related issues or PRs
- Design documents or specs
- Stakeholder discussions

---

## Best Practices

### 1. Keep Specs Focused
- One major feature or improvement per spec
- Completable in 1-2 hours for developers
- If too large, break into multiple specs

### 2. Be Specific
- Use exact file names, function names, values
- Avoid vague language like "improve", "optimize", "fix"
- Specify exact requirements (e.g., "200ms response time", not "fast")

### 3. Make Criteria Testable
- Every acceptance criterion should be verifiable
- Include edge cases and error scenarios
- Define success metrics where applicable

### 4. Document Everything
- Include API endpoints with full paths
- Provide test commands (curl, scripts)
- Add examples and expected outputs
- Link to related specs or documentation

### 5. Update During Implementation
- Mark criteria as `[x]` when complete
- Update implementation notes with decisions
- Document any deviations from the plan
- Add lessons learned after completion

### 6. Use Existing Specs as Examples
- Follow patterns from completed specs in your project
- Adapt templates to match your domain/tech stack
- Consistency helps with readability and implementation

---

## Example: Complete Spec

### Software Project (Frontend)

```markdown
# Spec: Fix Table Layout on Mobile Devices

## Status: COMPLETE

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
- [x] Table rows have `min-h-[56px]` minimum height
- [x] Table cells have `py-4 sm:py-4` padding for touch targets
- [x] Horizontal scroll works smoothly on mobile (momentum-based)
- [x] Horizontal scroll container has visual scroll indicator
- [x] Table header is sticky on scroll
- [x] All tables tested on iPhone SE (375px) and iPad Mini (768px)

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `src/components/shared/data-table.tsx` [file]
- `app/(student)/subscription/history/page.tsx` [file]
- `styles/table.css` [file]

## Implementation Tasks
- [x] Analyze current table implementation
- [x] Add minimum height and padding to table rows
- [x] Implement smooth horizontal scroll with indicators
- [x] Add sticky header support
- [x] Test on iPhone SE and iPad Mini
- [x] Update documentation

## Testing & Validation

### Test Scenarios
| Scenario | Device | Priority | Status |
|----------|--------|----------|--------|
| Table layout on mobile | iPhone SE (375px) | CRITICAL | [x] |
| Table layout on tablet | iPad Mini (768px) | HIGH | [x] |
| Horizontal scroll | Mobile Safari | HIGH | [x] |
| Sticky header | All devices | MEDIUM | [x] |

### Validation Methods
- [x] Manual testing (QA verification)
- [ ] Automated tests (unit/integration/e2e)
- [ ] Accessibility testing (WCAG compliance)

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| Touch target size | 32px | 56px | 56px |
| User testing score | 3.5/5 | 4.5/5 | 4.2/5 |

## Implementation Notes

### Pre-Implementation
- Identified 12 tables across the application affected by this issue
- Consulted iOS Human Interface Guidelines for touch target recommendations

### During Implementation
- Used `min-h-[56px]` per Apple's HIG guidelines (minimum 44pt touch target)
- Added momentum-based scrolling for native feel on iOS
- Implemented custom scrollbar indicator for better UX on mobile

### Post-Implementation
- User testing shows 20% improvement in table interaction success rate
- No performance impact observed
- One edge case discovered: very wide tables need full-width horizontal scroll

### Known Issues & Limitations
- Tables with >10 columns still difficult on very small screens (<340px)
- Consider implementing horizontal swipe navigation for future enhancement

### References
- [Apple Human Interface Guidelines - Touch Targets](https://developer.apple.com/design/human-interface-guidelines/components/buttons-and-controls)
- [Related Issue: #1234](https://github.com/your-repo/issues/1234)

<promise>DONE</promise>
```

---

## Completion Signal

Every spec must end with the completion signal when all acceptance criteria are met:

```markdown
<promise>DONE</promise>
```

This signal is used by the Ralph Wiggum iterative bash loop to know when a spec is complete.

---

**Version:** 4.0 (Universal)
**Last Updated:** 2026-01-31
**Compatible With:** Any project type (software, business, marketing, operations, etc.)
