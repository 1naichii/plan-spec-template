# Ralph Loop - MySaham App

Autonomous iterative development system based on Geoffrey Huntley's Ralph Wiggum methodology.

https://github.com/ghuntley/how-to-ralph-wiggum

## Key Differences from Original Version

1. **Commit Only**: This version commits changes automatically but does NOT push to remote
2. **New Spec Template**: Supports the v4.0 Universal spec template format
3. **Improved Prompt**: Enhanced prompts for working with the new spec format

## Directory Structure

```
.ralph/
├── scripts/
│   └── ralph-loop.sh        # Main loop script
├── logs/                    # Session and iteration logs
├── rlm/                     # Optional RLM workspace
│   ├── trace/              # Prompt/output snapshots
│   ├── queries/            # Recursive sub-queries
│   ├── answers/            # Sub-query results
│   └── index.tsv           # Iteration index
├── PROMPT_build.md          # Build mode prompt template
├── PROMPT_plan.md           # Planning mode prompt template
├── .env                     # Configuration file (auto-loaded)
└── README.md               # This file
```

## Quick Start

### Start the Loop

```bash
# From project root
./ralph.sh              # Unlimited iterations
./ralph.sh 20           # Max 20 iterations
./ralph.sh plan         # Create implementation plan (optional)
./ralph.sh --env .env.custom  # Load custom .env file
```

### Check Spec Status

```bash
./ralph.sh status       # Show pending/in-progress/complete specs
```

### Direct Script Access

```bash
.ralph/scripts/ralph-loop.sh --help    # Show full help
```

### Custom Specs Directory

You can specify a custom specs directory using the `RALPH_SPECS_DIR` environment variable:

```bash
# In .env file
RALPH_SPECS_DIR=my-specs

# Or via command line (after loading .env)
export RALPH_SPECS_DIR=my-specs
./ralph.sh
```

## How It Works

1. **Discover**: Find highest priority incomplete spec in `specs/` folder
2. **Implement**: Work on the spec until all acceptance criteria are met
3. **Verify**: Run tests and validate against spec
4. **Commit**: Mark spec as complete and commit changes
5. **Repeat**: Start fresh context window for next iteration

## Spec Format

Uses the v4.0 Universal spec template:

```markdown
# Spec: [Title]

## Status: PENDING | IN_PROGRESS | COMPLETE

## Context & User Story
> As a [stakeholder]
> I want [feature]
> So that [benefit]

**Priority:** CRITICAL | HIGH | MEDIUM | LOW

## Requirements
- [Requirement 1]
- [Requirement 2]

## Acceptance Criteria
- [ ] [Testable criterion 1]
- [ ] [Testable criterion 2]

**Output when complete:** `<promise>DONE</promise>`

## Items to Modify
- `path/to/file` [file | process | API endpoint]

## Implementation Tasks
- [ ] Step 1
- [ ] Step 2

## Testing & Validation
[Test scenarios and validation methods]

## Implementation Notes
[Pre/Post/During implementation notes]

<promise>DONE</promise>
```

## Completion Signal

The loop looks for `<promise>DONE</promise>` to confirm a spec is complete:
- All acceptance criteria marked `[x]`
- Status changed to `COMPLETE`
- Changes committed to git
- `<promise>DONE</promise>` output at end

## Important Notes

- **No Push**: Changes are committed locally only. Push manually when ready.
- **Fresh Context**: Each iteration starts with a fresh Claude context window
- **Quality Check**: If all specs are complete, the loop re-verifies random specs
- **Consecutive Failures**: Warns after 3 consecutive incomplete iterations

## Work Sources (Priority Order)

1. `IMPLEMENTATION_PLAN.md` (if exists) - Pick highest priority task
2. `specs/` folder - Pick highest priority incomplete spec
3. GitHub Issues - Open issues (if repo)
4. Other task trackers - Jira, Linear, etc.

## RLM Mode (Optional)

For large context files, use RLM mode:

```bash
.ralph/scripts/ralph-loop.sh --rlm ./rlm/context.txt
.ralph/scripts/ralph-loop.sh --rlm-context /path/to/context.txt
```

This treats large context as external environment and uses recursive queries.

## Logs

All sessions are logged:

- Session log: `logs/ralph_{mode}_session_YYYYMMDD_HHMMSS.log`
- Iteration logs: `logs/ralph_{mode}_iter_{N}_YYYYMMDD_HHMMSS.log`

## Troubleshooting

### Loop Gets Stuck

After 3 consecutive incomplete iterations, you'll see warnings:

1. Check logs in `logs/`
2. Simplify the current spec
3. Manually fix blocking issues

### No Specs Found

Ensure `specs/` directory exists with `.md` files:
- Specs should have `## Status: PENDING` or `## Status: IN_PROGRESS`
- New specs default to `PENDING`

### Claude CLI Not Found

Install and authenticate:
```bash
# Visit https://claude.ai/code
# Then:
npm install -g @anthropic-ai/claude-code
```

## Configuration

The loop includes a `.env` file at `.ralph/.env` with default configuration:

```bash
# Specs directory location (default: specs)
RALPH_SPECS_DIR=specs

# Claude CLI command override (default: claude)
# CLAUDE_CMD=claude

# Maximum iterations (unlimited by default)
# RALPH_MAX_ITERATIONS=0

# Custom implementation plan file (default: IMPLEMENTATION_PLAN.md)
# RALPH_PLAN_FILE=IMPLEMENTATION_PLAN.md

# RLM (Recursive Language Model) context file for large contexts
# RALPH_RLM_CONTEXT=rlm/context.txt
```

### Loading Environment Variables

The loop auto-loads `.ralph/.env` if it exists. You can also specify a custom `.env` file:

```bash
# Load .env file in current directory
.ralph/scripts/ralph-loop.sh --env .env

# Load custom .env file
.ralph/scripts/ralph-loop.sh --env .env.staging

# Auto-loads .ralph/.env if it exists (no flag needed)
.ralph/scripts/ralph-loop.sh
```

This is useful for:
- Setting custom `RALPH_SPECS_DIR`
- Configuring API keys for AI services
- Setting max iterations for CI/CD
- Other project-specific environment variables

### Phase Filtering

You can filter specs by phase to work on a specific set of tasks:

```bash
# Work on phase 1 (searches for directory like phase-1-*)
.ralph/scripts/ralph-loop.sh --phase 1

# Work on phase 2
.ralph/scripts/ralph-loop.sh --phase 2

# Combined with other options
.ralph/scripts/ralph-loop.sh --phase 1 --env .env.staging 20
```

**How it works:**
- `--phase <name>` searches for a directory matching `phase-<name>-*` in the specs folder
- All `.md` files in that directory are processed (regardless of filename)
- Example structure:
  ```
  specs/
  ├── phase-1-foundation/
  │   ├── task-1-1-init-typescript-project.md
  │   ├── task-1-2-setup-mongodb.md
  │   └── auth.md
  ├── phase-2-features/
  │   ├── user-management.md
  │   └── api-endpoints.md
  ```

**Examples:**
- `.ralph/scripts/ralph-loop.sh --phase 1` → Works in `phase-1-foundation/` folder
- `.ralph/scripts/ralph-loop.sh --phase 2` → Works in `phase-2-features/` folder
- `.ralph/scripts/ralph-loop.sh` → Works in entire `specs/` folder (all phases)

## Related Resources

- [Geoffrey Huntley's Ralph Wiggum](https://github.com/ghuntley/how-to-ralph-wiggum)
- [Spec Template v4.0](../../jump4it/aiepal/.template/specs-template/SPEC-TEMPLATE.md)
- [Spec README](../../jump4it/aiepal/.template/specs-template/README.md)

---

**Version**: 2.0 (Commit-Only + v4.0 Spec Support)
**Last Updated**: 2026-01-31
