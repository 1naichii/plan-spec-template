# Ralph Build Mode - New Spec Template (v4.0 Universal)

Based on Geoffrey Huntley's Ralph Wiggum methodology.

---

## Phase 0: Orient

Read `.specify/memory/constitution.md` to understand project principles and constraints.

---

## Phase 1: Discover Work Items

Search for incomplete work from these sources (in order):

1. **.spec/phase-2-data-layer folder** — Look for `.md` files with `## Status: PENDING` or `## Status: IN_PROGRESS`
2. **IMPLEMENTATION_PLAN.md** — If exists, find unchecked `- [ ]` tasks
3. **GitHub Issues** — Check for open issues (if this is a GitHub repo)
4. **Any task tracker** — Jira, Linear, etc. if configured

**IMPORTANT: Specs use the new v4.0 Universal template format.**
Spec files will have these sections:
- `## Status: [PENDING | IN_PROGRESS | COMPLETE]`
- `## Context & User Story` with user story format
- `## Requirements` - What needs to be done
- `## Acceptance Criteria` - Checkbox list of testable criteria
- `## Items to Modify` - Files/processes/APIs affected
- `## Implementation Tasks` - Step-by-step actions
- `## Testing & Validation` - Test scenarios and success metrics

Pick the **HIGHEST PRIORITY** incomplete item:
- Priority order: CRITICAL > HIGH > MEDIUM > LOW
- Numeric prefixes (001 before 010)
- Bugs/blockers before features

Before implementing, search the codebase to verify it's not already done.

---

## Phase 1b: Re-Verification Mode (No Incomplete Work Found)

**If ALL specs appear complete**, don't just exit — do a quality check:

1. **Randomly pick** one completed spec from `.spec/phase-2-data-layer`
2. **Strictly re-verify** ALL its acceptance criteria:
   - Run the actual tests mentioned in the spec
   - Manually verify each criterion is truly met
   - Check edge cases
   - Look for regressions
3. **If any criterion fails**: Update spec status to `## Status: IN_PROGRESS` and fix it
4. **If all pass**: Output `<promise>DONE</promise>` to confirm quality

This ensures the codebase stays healthy even when "nothing to do."

---

## Phase 1c: Phase Filter (If Enabled)

**IMPORTANT PHASE FILTER IS ACTIVE:** You are working in a specific phase directory.

Phase directory: `.spec/phase-2-data-layer`

**Rules:**
- Only process specs located in: `.spec/phase-2-data-layer/`
- All `.md` files in this directory are part of this phase (regardless of filename)
- Specs outside this directory should be ignored
- If no specs found in this directory, output `<promise>DONE</promise>` to confirm phase is complete

**In Phase 1b (re-verification):** Only randomly pick from specs in `.spec/phase-2-data-layer/`

---

## Phase 2: Implement

Implement the selected spec/task completely:
- Follow the spec's requirements exactly
- Write clean, maintainable code
- Add tests as needed
- Update implementation notes as you work

---

## Phase 3: Validate

Run the project's test suite and verify:
- All tests pass
- No lint errors
- The spec's acceptance criteria are 100% met
- Mark each completed criterion with [x] in the spec

---

## Phase 4: Commit & Update (NO PUSH)

1. **Update the spec**:
   - Mark all completed acceptance criteria as [x]
   - Change status to `## Status: COMPLETE`
   - Add `<promise>DONE</promise>` at the end of the spec

2. **Commit changes**:
   - `git add -A`
   - `git commit` with a descriptive message following:
     `feat|fix|chore|docs|test|refactor: [brief description]`
     Example: `feat: implement user authentication with OAuth`

3. **IMPORTANT: Do NOT push** - This version commits only

---

## Spec Status Management

When working on a spec:
- Start: `## Status: PENDING`
- In progress: `## Status: IN_PROGRESS`
- Complete: `## Status: COMPLETE` + `<promise>DONE</promise>`

Mark acceptance criteria as you go:
- [ ] - Not started
- [x] - Completed

---

## Completion Signal

**CRITICAL:** Only output the magic phrase when the work is 100% complete.

Check:
- [ ] Implementation matches all requirements
- [ ] All tests pass
- [ ] All acceptance criteria verified and marked [x]
- [ ] Changes committed
- [ ] Spec marked as `## Status: COMPLETE`
- [ ] `<promise>DONE</promise>` added to end of spec

**If ALL checks pass, output:** `<promise>DONE</promise>`

**If ANY check fails:** Fix the issue and try again. Do NOT output the magic phrase.
