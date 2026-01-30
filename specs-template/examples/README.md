# Spec Examples by Project Type

This directory contains **15+ example specs** organized by project type to help you understand how to write effective specs for different domains.

## 📁 Directory Structure

```
examples/
├── software/              # Software Development Examples (3 specs)
│   ├── example-frontend-table-fix.md
│   ├── example-backend-api-endpoint.md
│   └── example-devops-ci-cd-pipeline.md
│
├── business/              # Business Process Examples (3 specs)
│   ├── example-workflow-automation.md
│   ├── example-training-program.md
│   └── example-kpi-tracking.md
│
├── marketing/             # Marketing & Sales Examples (3 specs)
│   ├── example-campaign-setup.md
│   ├── example-landing-page-optimization.md
│   └── example-analytics-configuration.md
│
├── operations/            # Operations & Infrastructure Examples (3 specs)
│   ├── example-process-improvement.md
│   ├── example-monitoring-setup.md
│   └── example-incident-response.md
│
└── product/              # Product & Design Examples (3 specs)
    ├── example-feature-development.md
    ├── example-ux-improvement.md
    └── example-design-system.md
```

## 🎯 Quick Reference

### Software Development

| Example | Focus | Complexity |
|---------|--------|------------|
| `example-frontend-table-fix.md` | UI component fix (table layout) | Beginner |
| `example-backend-api-endpoint.md` | API endpoint implementation | Intermediate |
| `example-devops-ci-cd-pipeline.md` | CI/CD pipeline setup | Advanced |

**When to use:** Building web apps, APIs, mobile apps, DevOps infrastructure

### Business Process

| Example | Focus | Complexity |
|---------|--------|------------|
| `example-workflow-automation.md` | Approval workflow automation | Intermediate |
| `example-training-program.md` | Onboarding program creation | Beginner |
| `example-kpi-tracking.md` | Performance dashboard setup | Intermediate |

**When to use:** Improving business processes, documentation, training, KPIs

### Marketing & Sales

| Example | Focus | Complexity |
|---------|--------|------------|
| `example-campaign-setup.md` | Marketing campaign launch | Intermediate |
| `example-landing-page-optimization.md` | Conversion rate optimization | Beginner |
| `example-analytics-configuration.md` | Analytics tracking setup | Advanced |

**When to use:** Campaigns, landing pages, analytics, marketing automation

### Operations & Infrastructure

| Example | Focus | Complexity |
|---------|--------|------------|
| `example-process-improvement.md` | Support ticket workflow | Intermediate |
| `example-monitoring-setup.md` | Application monitoring | Advanced |
| `example-incident-response.md` | Incident response procedures | Advanced |

**When to use:** Process improvement, monitoring, incident response, operations

### Product & Design

| Example | Focus | Complexity |
|---------|--------|------------|
| `example-feature-development.md` | Search feature implementation | Intermediate |
| `example-ux-improvement.md` | Checkout flow optimization | Intermediate |
| `example-design-system.md` | Component library creation | Advanced |

**When to use:** Feature development, UX improvements, design systems

## 📖 How to Use These Examples

### 1. Find an Example Matching Your Project

Use the table above to find an example similar to what you're working on.

### 2. Review the Example Structure

Each example includes:
- **Context & User Story** - Why this work matters
- **Requirements** - What needs to be done
- **Acceptance Criteria** - Specific, testable checkboxes
- **Items to Modify** - Files, processes, APIs, etc.
- **Implementation Tasks** - Step-by-step actions
- **Testing & Validation** - How to test
- **Success Metrics** - How to measure success

### 3. Adapt the Example to Your Needs

Copy the example spec and modify it:
- Change the title and user story
- Update requirements for your specific situation
- Modify acceptance criteria to match your goals
- Replace items to modify with your files/processes
- Adjust success metrics to your baselines and targets

### 4. Use the Universal Template

If no example matches perfectly, start with the universal template:
- `../SPEC-TEMPLATE.md`

## 🔍 Example Analysis

### Spec Anatomy Breakdown

Every example follows the same structure:

```markdown
# Spec: [Clear, Descriptive Title]

## Status: PENDING

## Context & User Story
> As a [who]
> I want [what]
> So that [why]

**Priority:** [CRITICAL/HIGH/MEDIUM/LOW]

## Requirements
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

## Acceptance Criteria
- [ ] [Specific criterion 1]
- [ ] [Specific criterion 2]
- [ ] [Specific criterion 3]

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `path/to/item` [file | process | API endpoint]

## Implementation Tasks
- [ ] [Step 1]
- [ ] [Step 2]

## Testing & Validation

### Test Scenarios
| Scenario | Environment | Priority | Status |
|----------|-------------|----------|--------|

### Success Metrics
| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|

## Implementation Notes
[Document what happens during implementation]
```

## 💡 Key Patterns by Domain

### Software Development Patterns

**Frontend:**
- Focus on UI components, responsive design, accessibility
- Test on multiple devices and browsers
- Metrics: load time, conversion, user satisfaction

**Backend:**
- Focus on API endpoints, data validation, performance
- Test with various input scenarios
- Metrics: response time, error rate, throughput

**DevOps:**
- Focus on pipelines, monitoring, automation
- Test with real deployments
- Metrics: pipeline duration, uptime, recovery time

### Business Process Patterns

**Workflow:**
- Focus on automation, speed, error reduction
- Test with real workflows
- Metrics: process time, satisfaction, error rate

**Training:**
- Focus on comprehensiveness, engagement, effectiveness
- Test with real users
- Metrics: completion rate, satisfaction, time to productivity

**KPIs:**
- Focus on data accuracy, real-time updates, insights
- Test with real data
- Metrics: update frequency, accuracy, adoption

### Marketing Patterns

**Campaigns:**
- Focus on reach, engagement, conversion
- Test with real campaigns
- Metrics: open rate, CTR, conversion, ROI

**Landing Pages:**
- Focus on clarity, conversion, speed
- Test with A/B tests
- Metrics: conversion rate, bounce rate, load time

**Analytics:**
- Focus on tracking accuracy, completeness
- Test with real events
- Metrics: tracking accuracy, data freshness

### Operations Patterns

**Processes:**
- Focus on efficiency, automation, quality
- Test with real tickets/tasks
- Metrics: resolution time, satisfaction, efficiency

**Monitoring:**
- Focus on detection, alerting, visibility
- Test with real incidents
- Metrics: detection time, MTTR, availability

**Incident Response:**
- Focus on speed, communication, recovery
- Test with drills
- Metrics: response time, resolution time, communication quality

### Product Patterns

**Features:**
- Focus on functionality, usability, performance
- Test with real users
- Metrics: adoption, satisfaction, conversion

**UX:**
- Focus on simplicity, clarity, completion
- Test with user testing
- Metrics: completion rate, satisfaction, time to complete

**Design Systems:**
- Focus on consistency, reusability, documentation
- Test across components
- Metrics: adoption, development speed, consistency

## 🚀 Getting Started

### Choose Your Starting Point

**I'm new to specs:**
1. Read `../SPEC-TEMPLATE.md` to understand the structure
2. Review one example matching your project type
3. Create your first spec using the template

**I have some experience:**
1. Browse examples for patterns matching your work
2. Copy and adapt relevant examples
3. Combine patterns from multiple examples if needed

**I'm experienced:**
1. Use examples as reference for structure and best practices
2. Focus on specific patterns for your domain
3. Create your own examples for your team

## 📚 Additional Resources

- **Universal Template:** `../SPEC-TEMPLATE.md`
- **Comprehensive Guide:** `../HOW-TO-GENERATE-SPECS.md`
- **Master Tracker:** `../SPECS-OVERVIEW.md`
- **Directory Guide:** `../README.md`

## 🤝 Contributing Examples

To add your own examples:

1. Create a new file in the appropriate directory
2. Follow the example structure and quality standards
3. Include realistic scenarios and metrics
4. Update this README to reference your example
5. Share with your team for feedback

**Example naming convention:**
```
examples/[domain]/example-[topic].md
```

---

**Version:** 1.0
**Last Updated:** 2026-01-31
**Total Examples:** 15 specs across 5 domains
