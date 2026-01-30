#!/bin/bash
#
# Ralph Loop for Claude Code - Commit-Only Version
#
# Based on Geoffrey Huntley's Ralph Wiggum methodology:
# https://github.com/ghuntley/how-to-ralph-wiggum
#
# Modified for new spec template format (v4.0 Universal)
# COMMIT ONLY - No automatic pushing
#
# Key principles:
# - Each iteration picks ONE task/spec to work on
# - Agent works until acceptance criteria are met
# - Only outputs <promise>DONE</promise> when truly complete
# - Bash loop checks for magic phrase before continuing
# - Fresh context window each iteration
# - Commits changes automatically (no push)
#
# Work sources (in priority order):
# 1. IMPLEMENTATION_PLAN.md (if exists) - pick highest priority task
# 2. specs/ folder - pick highest priority incomplete spec (new template format)
#
# Usage:
#   .ralph/scripts/ralph-loop.sh            # Build mode (unlimited)
#   .ralph/scripts/ralph-loop.sh 20         # Build mode (max 20 iterations)
#   .ralph/scripts/ralph-loop.sh plan       # Planning mode (creates IMPLEMENTATION_PLAN.md)
#

set -e
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RALPH_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(dirname "$RALPH_DIR")"
LOG_DIR="$RALPH_DIR/logs"
CONSTITUTION="$PROJECT_DIR/.specify/memory/constitution.md"
RLM_DIR="$RALPH_DIR/rlm"
RLM_TRACE_DIR="$RLM_DIR/trace"
RLM_QUERIES_DIR="$RLM_DIR/queries"
RLM_ANSWERS_DIR="$RLM_DIR/answers"
RLM_INDEX="$RLM_DIR/index.tsv"

# Configuration
MAX_ITERATIONS="${RALPH_MAX_ITERATIONS:-0}"  # 0 = unlimited
MODE="build"
CLAUDE_CMD="${CLAUDE_CMD:-claude}"
YOLO_FLAG="--dangerously-skip-permissions"
RLM_CONTEXT_FILE="${RALPH_RLM_CONTEXT:-}"
ENV_FILE=""
PHASE_FILTER=""
# SPECS_DIR will be set after loading .env file
BASE_SPECS_DIR=""
SPECS_DIR=""
PLAN_FILE="${RALPH_PLAN_FILE:-IMPLEMENTATION_PLAN.md}"
TAIL_LINES=5
TAIL_RENDERED_LINES=0
ROLLING_OUTPUT_LINES=5
ROLLING_OUTPUT_INTERVAL=10
ROLLING_RENDERED_LINES=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m'

mkdir -p "$LOG_DIR"

# Check constitution for YOLO setting
YOLO_ENABLED=true
if [[ -f "$CONSTITUTION" ]]; then
    if grep -q "YOLO Mode.*DISABLED" "$CONSTITUTION" 2>/dev/null; then
        YOLO_ENABLED=false
    fi
fi

show_specs_ui() {
    local specs_dir="$1"
    echo ""
    echo -e "${CYAN}════════════════════ LOADING SPECS ════════════════════${NC}"
    echo -e "${BLUE}Reading specs from:${NC} $specs_dir"
    echo ""
    
    if [ ! -d "$specs_dir" ]; then
        echo -e "${RED}✗ Specs directory not found: $specs_dir${NC}"
        echo -e "${CYAN}════════════════════ SPECS LOADED ════════════════════${NC}"
        echo ""
        return
    fi
    
    local spec_files=$(find "$specs_dir" -maxdepth 2 -name "*.md" -type f 2>/dev/null | sort)
    local spec_count=0
    
    if [ -n "$spec_files" ]; then
        spec_count=$(echo "$spec_files" | grep -c .md 2>/dev/null || true)
    fi
    
    if [ "$spec_count" -eq 0 ] || [ -z "$spec_files" ]; then
        echo -e "${YELLOW}  No .md files found in $specs_dir${NC}"
    else
        echo -e "${GREEN}Found $spec_count spec file(s):${NC}"
        echo ""
        
        local index=1
        echo "$spec_files" | while read -r spec_file; do
            if [ -z "$spec_file" ]; then continue; fi
            
            local basename=$(basename "$spec_file")
            local rel_path="${spec_file#$specs_dir/}"
            
            # Extract status if available
            local status=$(grep -E "^## Status:" "$spec_file" 2>/dev/null | head -1 | sed 's/## Status: //' || echo "UNKNOWN")
            local status_color
            
            case "$status" in
                "PENDING")
                    status_color="${YELLOW}"
                    ;;
                "IN_PROGRESS")
                    status_color="${BLUE}"
                    ;;
                "COMPLETE")
                    status_color="${GREEN}"
                    ;;
                *)
                    status_color="${GRAY}"
                    ;;
            esac
            
            # Extract title
            local title=$(grep -E "^# Spec:" "$spec_file" 2>/dev/null | head -1 | sed 's/^# Spec: //' || echo "$basename")
            
            printf "  ${CYAN}%2d)${NC} ${status_color}[%-11s]${NC} %s\n" "$index" "$status" "$rel_path"
            if [ "$title" != "$basename" ]; then
                printf "      ${GRAY}%s${NC}\n" "$title"
            fi
            echo ""
            
            index=$((index + 1))
        done
    fi
    
    echo -e "${CYAN}════════════════════ SPECS LOADED ════════════════════${NC}"
    echo ""
}

show_help() {
    cat <<EOF
Ralph Loop for Claude Code - Commit-Only Version

Based on Geoffrey Huntley's Ralph Wiggum methodology + New Spec Template (v4.0).
https://github.com/ghuntley/how-to-ralph-wiggum

Modified to commit changes WITHOUT pushing to remote.

Usage:
  .ralph/scripts/ralph-loop.sh            # Build mode, unlimited iterations
  .ralph/scripts/ralph-loop.sh 20         # Build mode, max 20 iterations
  .ralph/scripts/ralph-loop.sh plan       # Planning mode (optional)
  .ralph/scripts/ralph-loop.sh --env .env.custom  # Load custom env file
  .ralph/scripts/ralph-loop.sh --phase phase-1  # Filter specs by phase prefix
  .ralph/scripts/ralph-loop.sh --rlm-context ./rlm/context.txt
  .ralph/scripts/ralph-loop.sh --rlm ./rlm/context.txt

Modes:
  build (default)  Pick spec/task and implement
  plan             Create IMPLEMENTATION_PLAN.md from specs (OPTIONAL)

Environment Options:
  --env <file>     Load environment variables from file (default: .env)
  --phase <name>   Filter specs by phase directory (e.g., 1 matches phase-1-*/)
  RALPH_SPECS_DIR  Env variable for specs directory (default: specs)

Work Sources (checked in order):
  1. IMPLEMENTATION_PLAN.md - If exists, pick highest priority task
  2. SPECS_DIR - Otherwise, pick highest priority incomplete spec (new format)

The plan mode is OPTIONAL. Most projects can work directly from specs.

RLM Mode (optional):
  --rlm-context <file>  Treat a large context file as external environment.
                        The agent should read slices instead of loading it all.
  --rlm [file]          Shortcut for --rlm-context (defaults to rlm/context.txt)

Phase Filtering (optional):
  --phase <name>        Only process specs in a directory matching phase-<name>-*.
                        Example: --phase 1 will search for a directory like:
                          phase-1-foundation/
                          phase-1-auth/
                        And process all .md files inside that directory,
                        regardless of filename (e.g., task-1-1-init.md, auth.md, etc.)

Key Difference: This version COMMITS changes but does NOT PUSH to remote.

How it works:
  1. Each iteration feeds PROMPT.md to Claude via stdin
  2. Claude picks the HIGHEST PRIORITY incomplete spec/task
  3. Claude implements, tests, and verifies acceptance criteria
  4. Claude outputs <promise>DONE</promise> ONLY if criteria are met
  5. Bash loop checks for the magic phrase
  6. If found, loop commits changes and continues to next iteration (fresh context)
  7. If not found, loop retries

RLM workspace (when enabled):
  - rlm/trace/     Prompt snapshots + outputs per iteration
  - rlm/index.tsv  Index of all iterations (timestamp, prompt, log, status)
  - rlm/queries/ and rlm/answers/  For optional recursive sub-queries

EOF
}

load_env_file() {
    local env_file="$1"
    if [[ -f "$env_file" ]]; then
        echo -e "${BLUE}Loading environment from: $env_file${NC}"
        while IFS='=' read -r key value; do
            # Skip comments and empty lines
            [[ "$key" =~ ^#.*$ ]] && continue
            [[ -z "$key" ]] && continue
            # Remove surrounding quotes and whitespace
            value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/^["\x27]\(.*\)["\x27]$/\1/')
            # Export the variable
            export "$key=$value"
        done < <(grep -v '^[[:space:]]*$' "$env_file")
        # Update SPECS_DIR if set in env file
        if [[ -n "${RALPH_SPECS_DIR:-}" ]]; then
            SPECS_DIR="$RALPH_SPECS_DIR"
        fi
        echo -e "${GREEN}✓ Environment loaded${NC}"
    else
        echo -e "${YELLOW}Warning: .env file not found: $env_file${NC}"
    fi
}

print_latest_output() {
    local log_file="$1"
    local label="${2:-Claude}"
    local target="/dev/tty"

    [ -f "$log_file" ] || return 0

    if [ ! -w "$target" ]; then
        target="/dev/stdout"
    fi

    if [ "$target" = "/dev/tty" ] && [ "$TAIL_RENDERED_LINES" -gt 0 ]; then
        printf "\033[%dA\033[J" "$TAIL_RENDERED_LINES" > "$target"
    fi

    {
        echo "Latest ${label} output (last ${TAIL_LINES} lines):"
        tail -n "$TAIL_LINES" "$log_file"
    } > "$target"

    if [ "$target" = "/dev/tty" ]; then
        TAIL_RENDERED_LINES=$((TAIL_LINES + 1))
    fi
}

watch_latest_output() {
    local log_file="$1"
    local label="${2:-Claude}"
    local target="/dev/tty"
    local use_tty=false
    local use_tput=false

    [ -f "$log_file" ] || return 0

    if [ ! -w "$target" ]; then
        target="/dev/stdout"
    else
        use_tty=true
        if command -v tput &>/dev/null; then
            use_tput=true
        fi
    fi

    if [ "$use_tty" = true ]; then
        if [ "$use_tput" = true ]; then
            tput cr > "$target"
            tput sc > "$target"
        else
            printf "\r\0337" > "$target"
        fi
    fi

    while true; do
        local timestamp
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')

        if [ "$use_tty" = true ]; then
            if [ "$use_tput" = true ]; then
                tput rc > "$target"
                tput ed > "$target"
                tput cr > "$target"
            else
                printf "\0338\033[J\r" > "$target"
            fi
        fi

        {
            echo -e "${CYAN}[$timestamp] Latest ${label} output (last ${ROLLING_OUTPUT_LINES} lines):${NC}"
            if [ ! -s "$log_file" ]; then
                echo "(no output yet)"
            else
                tail -n "$ROLLING_OUTPUT_LINES" "$log_file" 2>/dev/null || true
            fi
            echo ""
        } > "$target"

        sleep "$ROLLING_OUTPUT_INTERVAL"
    done
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        plan)
            MODE="plan"
            if [[ "${2:-}" =~ ^[0-9]+$ ]]; then
                MAX_ITERATIONS="$2"
                shift 2
            else
                MAX_ITERATIONS=1
                shift
            fi
            ;;
        --env)
            if [[ -n "${2:-}" && "${2:0:1}" != "-" ]]; then
                ENV_FILE="$2"
                shift 2
            else
                ENV_FILE=".env"
                shift
            fi
            ;;
        --phase)
            if [[ -n "${2:-}" && "${2:0:1}" != "-" ]]; then
                PHASE_FILTER="$2"
                shift 2
            else
                echo -e "${RED}Error: --phase requires a value${NC}"
                show_help
                exit 1
            fi
            ;;
        --rlm-context)
            RLM_CONTEXT_FILE="${2:-}"
            shift 2
            ;;
        --rlm)
            if [[ -n "${2:-}" && "${2:0:1}" != "-" ]]; then
                RLM_CONTEXT_FILE="$2"
                shift 2
            else
                RLM_CONTEXT_FILE="rlm/context.txt"
                shift
            fi
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        [0-9]*)
            MODE="build"
            MAX_ITERATIONS="$1"
            shift
            ;;
        *)
            echo -e "${RED}Unknown argument: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

cd "$PROJECT_DIR"

# Load .env file if specified
if [ -n "$ENV_FILE" ]; then
    load_env_file "$ENV_FILE"
elif [ -f "$RALPH_DIR/.env" ]; then
    echo -e "${BLUE}Auto-loading .ralph/.env file${NC}"
    load_env_file "$RALPH_DIR/.env"
elif [ -f ".env" ]; then
    echo -e "${BLUE}Auto-loading .env file${NC}"
    load_env_file ".env"
fi

# Set SPECS_DIR after .env file is loaded
BASE_SPECS_DIR="${RALPH_SPECS_DIR:-specs}"
SPECS_DIR="${BASE_SPECS_DIR}"

# Apply phase filter to determine SPECS_DIR
if [ -n "$PHASE_FILTER" ]; then
    if [ ! -d "$BASE_SPECS_DIR" ]; then
        echo -e "${RED}Error: Base specs directory not found: $BASE_SPECS_DIR${NC}"
        exit 1
    fi

    # Find directory matching phase-* pattern
    PHASE_DIR=$(find "$BASE_SPECS_DIR" -maxdepth 1 -type d -name "phase-${PHASE_FILTER}-*" | head -n 1)

    if [ -z "$PHASE_DIR" ]; then
        echo -e "${RED}Error: No directory matching 'phase-${PHASE_FILTER}-*' found in $BASE_SPECS_DIR${NC}"
        echo -e "${YELLOW}Available directories:${NC}"
        find "$BASE_SPECS_DIR" -maxdepth 1 -type d -name "phase-*" | sed 's|^.*/||' | while read dir; do
            echo -e "  - $dir"
        done
        exit 1
    fi

    SPECS_DIR="$PHASE_DIR"
    echo -e "${GREEN}✓ Phase filter active: using $SPECS_DIR${NC}"
fi

# Validate RLM context file (if provided)
if [ -n "$RLM_CONTEXT_FILE" ] && [ ! -f "$RLM_CONTEXT_FILE" ]; then
    echo -e "${RED}Error: RLM context file not found: $RLM_CONTEXT_FILE${NC}"
    echo "Create it first (example):"
    echo "  mkdir -p rlm && printf \"%s\" \"<your long context>\" > $RLM_CONTEXT_FILE"
    exit 1
fi

# Initialize RLM workspace (optional)
if [ -n "$RLM_CONTEXT_FILE" ]; then
    mkdir -p "$RLM_TRACE_DIR" "$RLM_QUERIES_DIR" "$RLM_ANSWERS_DIR"
    if [ ! -f "$RLM_INDEX" ]; then
        echo -e "timestamp\tmode\titeration\tprompt\tlog\toutput\tstatus" > "$RLM_INDEX"
    fi
fi

# Session log (captures ALL output)
SESSION_LOG="$LOG_DIR/ralph_${MODE}_session_$(date '+%Y%m%d_%H%M%S').log"
exec > >(tee -a "$SESSION_LOG") 2>&1

# Check if Claude CLI is available
if ! command -v "$CLAUDE_CMD" &> /dev/null; then
    echo -e "${RED}Error: Claude CLI not found${NC}"
    echo ""
    echo "Install Claude Code CLI and authenticate first."
    echo "https://claude.ai/code"
    exit 1
fi

# Determine which prompt to use based on mode and available files
if [ "$MODE" = "plan" ]; then
    PROMPT_FILE="$RALPH_DIR/PROMPT_plan.md"
else
    PROMPT_FILE="$RALPH_DIR/PROMPT_build.md"
fi

# Create the build prompt if it doesn't exist
if [ ! -f "$RALPH_DIR/PROMPT_build.md" ]; then
    cat > "$RALPH_DIR/PROMPT_build.md" << 'BUILDEOF'
# Ralph Build Mode - New Spec Template (v4.0 Universal)

Based on Geoffrey Huntley's Ralph Wiggum methodology.

---

## Phase 0: Orient

Read `.specify/memory/constitution.md` to understand project principles and constraints.

---
BUILDEOF

# Optional RLM context block
if [ -n "$RLM_CONTEXT_FILE" ]; then
cat >> "$RALPH_DIR/PROMPT_build.md" << EOF

## Phase 0d: RLM Context (Optional)

You have access to a large context file at:
**$RLM_CONTEXT_FILE**

Treat this file as an external environment. Do NOT paste the whole file into the prompt.
Instead, inspect it programmatically and recursively:

- Use small slices:
  \`\`\`bash
  sed -n 'START,ENDp' "$RLM_CONTEXT_FILE"
  \`\`\`
- Or Python snippets:
  \`\`\`bash
  python - <<'PY'
  from pathlib import Path
  p = Path("$RLM_CONTEXT_FILE")
  print(p.read_text().splitlines()[START:END])
  PY
  \`\`\`
- Use search:
  \`\`\`bash
  rg -n "pattern" "$RLM_CONTEXT_FILE"
  \`\`\`

Goal: decompose the task into smaller sub-queries and only load the pieces you need.
This mirrors the Recursive Language Model approach from https://arxiv.org/html/2512.24601v1

## RLM Workspace (Optional)

Past loop outputs are preserved on disk:
- Iteration logs: \`logs/\`
- Prompt/output snapshots: \`rlm/trace/\`
- Iteration index: \`rlm/index.tsv\`

Use these as an external memory store (search/slice as needed).
If you need a recursive sub-query, write a focused prompt in \`rlm/queries/\`,
run:
  \`./scripts/rlm-subcall.sh --query rlm/queries/<file>.md\`
and store the result in \`rlm/answers/\`.
EOF
fi

cat >> "$RALPH_DIR/PROMPT_build.md" << BUILDEOF

## Phase 1: Discover Work Items

Search for incomplete work from these sources (in order):

1. **$SPECS_DIR folder** — Look for \`.md\` files with \`## Status: PENDING\` or \`## Status: IN_PROGRESS\`
2. **$PLAN_FILE** — If exists, find unchecked \`- [ ]\` tasks
3. **GitHub Issues** — Check for open issues (if this is a GitHub repo)
4. **Any task tracker** — Jira, Linear, etc. if configured

**IMPORTANT: Specs use the new v4.0 Universal template format.**
Spec files will have these sections:
- \`## Status: [PENDING | IN_PROGRESS | COMPLETE]\`
- \`## Context & User Story\` with user story format
- \`## Requirements\` - What needs to be done
- \`## Acceptance Criteria\` - Checkbox list of testable criteria
- \`## Items to Modify\` - Files/processes/APIs affected
- \`## Implementation Tasks\` - Step-by-step actions
- \`## Testing & Validation\` - Test scenarios and success metrics

Pick the **HIGHEST PRIORITY** incomplete item:
- Priority order: CRITICAL > HIGH > MEDIUM > LOW
- Numeric prefixes (001 before 010)
- Bugs/blockers before features

Before implementing, search the codebase to verify it's not already done.

---

## Phase 1b: Re-Verification Mode (No Incomplete Work Found)

**If ALL specs appear complete**, don't just exit — do a quality check:

1. **Randomly pick** one completed spec from \`$SPECS_DIR\`
2. **Strictly re-verify** ALL its acceptance criteria:
   - Run the actual tests mentioned in the spec
   - Manually verify each criterion is truly met
   - Check edge cases
   - Look for regressions
3. **If any criterion fails**: Update spec status to \`## Status: IN_PROGRESS\` and fix it
4. **If all pass**: Output \`<promise>DONE</promise>\` to confirm quality

This ensures the codebase stays healthy even when "nothing to do."

---

## Phase 1c: Phase Filter (If Enabled)

**IMPORTANT PHASE FILTER IS ACTIVE:** You are working in a specific phase directory.

Phase directory: \`$SPECS_DIR\`

**Rules:**
- Only process specs located in: \`$SPECS_DIR/\`
- All \`.md\` files in this directory are part of this phase (regardless of filename)
- Specs outside this directory should be ignored
- If no specs found in this directory, output \`<promise>DONE</promise>\` to confirm phase is complete

**In Phase 1b (re-verification):** Only randomly pick from specs in \`$SPECS_DIR/\`

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
   - Change status to \`## Status: COMPLETE\`
   - Add \`<promise>DONE</promise>\` at the end of the spec

2. **Commit changes**:
   - \`git add -A\`
   - \`git commit\` with a descriptive message following:
     \`feat|fix|chore|docs|test|refactor: [brief description]\`
     Example: \`feat: implement user authentication with OAuth\`

3. **IMPORTANT: Do NOT push** - This version commits only

---

## Spec Status Management

When working on a spec:
- Start: \`## Status: PENDING\`
- In progress: \`## Status: IN_PROGRESS\`
- Complete: \`## Status: COMPLETE\` + \`<promise>DONE</promise>\`

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
- [ ] Spec marked as \`## Status: COMPLETE\`
- [ ] \`<promise>DONE</promise>\` added to end of spec

**If ALL checks pass, output:** \`<promise>DONE</promise>\`

**If ANY check fails:** Fix the issue and try again. Do NOT output the magic phrase.
BUILDEOF
fi

# Create planning prompt (only used if plan mode is explicitly requested)
if [ ! -f "$RALPH_DIR/PROMPT_plan.md" ]; then
    cat > "$RALPH_DIR/PROMPT_plan.md" << PLANEOF
# Ralph Planning Mode (OPTIONAL)

This mode is OPTIONAL. Most projects work fine directly from specs.

Only use this when you want a detailed breakdown of specs into smaller tasks.

---

## Phase 0: Orient

0a. Read \`.specify/memory/constitution.md\` for project principles.

0b. Study \`$SPECS_DIR\` to learn all feature specifications (new v4.0 format).
PLANEOF

# Optional RLM context block for planning
if [ -n "$RLM_CONTEXT_FILE" ]; then
cat >> "$RALPH_DIR/PROMPT_plan.md" << EOF

## Phase 0c: RLM Context (Optional)

You have access to a large context file at:
**$RLM_CONTEXT_FILE**

Treat this file as an external environment. Do NOT paste the whole file into the prompt.
Inspect only the slices you need using shell tools or Python.
This mirrors the Recursive Language Model approach from https://arxiv.org/html/2512.24601v1

## RLM Workspace (Optional)

Past loop outputs are preserved on disk:
- Iteration logs: \`logs/\`
- Prompt/output snapshots: \`rlm/trace/\`
- Iteration index: \`rlm/index.tsv\`

Use these as an external memory store (search/slice as needed).
For recursive sub-queries, use:
  \`./scripts/rlm-subcall.sh --query rlm/queries/<file>.md\`
EOF
fi

cat >> "$RALPH_DIR/PROMPT_plan.md" << PLANEOF

## Phase 2: Create Plan

Create \`$PLAN_FILE\` with a prioritized task list:

\`\`\`markdown
# Implementation Plan

Auto-generated breakdown of specs into tasks.
Delete this file to return to working directly from specs.

## Priority Tasks

- [ ] [CRITICAL] Task description - from spec NNN
- [ ] [HIGH] Task description - from spec NNN
- [ ] [MEDIUM] Task description
- [ ] [LOW] Task description

## Completed

- [x] Completed task
\`\`\`

Prioritize by:
1. Dependencies (do prerequisites first)
2. Impact (high-value features first)
3. Complexity (mix easy wins with harder tasks)

---

## Completion Signal

When the plan is complete and saved:

\`<promise>DONE</promise>\`
PLANEOF
fi

# Check prompt file exists
if [ ! -f "$PROMPT_FILE" ]; then
    echo -e "${RED}Error: $PROMPT_FILE not found${NC}"
    exit 1
fi

# Build Claude flags
CLAUDE_FLAGS="-p"
if [ "$YOLO_ENABLED" = true ]; then
    CLAUDE_FLAGS="$CLAUDE_FLAGS $YOLO_FLAG"
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

# Check for work sources - count .md files in SPECS_DIR
HAS_PLAN=false
HAS_SPECS=false
SPEC_COUNT=0
[ -f "$PLAN_FILE" ] && HAS_PLAN=true
if [ -d "$SPECS_DIR" ]; then
    SPEC_COUNT=$(find "$SPECS_DIR" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
    [ "$SPEC_COUNT" -gt 0 ] && HAS_SPECS=true
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}         RALPH LOOP (Claude Code) - COMMIT ONLY               ${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Mode:${NC}     $MODE"
echo -e "${BLUE}Prompt:${NC}   $PROMPT_FILE"
echo -e "${BLUE}Branch:${NC}   $CURRENT_BRANCH"
echo -e "${BLUE}Specs Dir:${NC} $SPECS_DIR"
[ -n "$PHASE_FILTER" ] && echo -e "${BLUE}Phase:${NC}     $PHASE_FILTER (filtered to directory: $(basename "$SPECS_DIR"))"
echo -e "${YELLOW}YOLO:${NC}     $([ "$YOLO_ENABLED" = true ] && echo "ENABLED" || echo "DISABLED")"
echo -e "${YELLOW}Push:${NC}     DISABLED (commit only)"
[ -n "$RLM_CONTEXT_FILE" ] && echo -e "${BLUE}RLM:${NC}      $RLM_CONTEXT_FILE"
[ -n "$ENV_FILE" ] && echo -e "${BLUE}Env:${NC}      $ENV_FILE"
[ -n "$SESSION_LOG" ] && echo -e "${BLUE}Log:${NC}      $SESSION_LOG"
[ $MAX_ITERATIONS -gt 0 ] && echo -e "${BLUE}Max:${NC}      $MAX_ITERATIONS iterations"
echo ""
echo -e "${BLUE}Work source:${NC}"
if [ "$HAS_PLAN" = true ]; then
    echo -e "  ${GREEN}[✓]${NC} $PLAN_FILE will use this"
else
    echo -e "  ${YELLOW}[ ]${NC} $PLAN_FILE not found - that is OK"
fi
if [ "$HAS_SPECS" = true ]; then
    echo -e "  ${GREEN}[✓]${NC} $SPECS_DIR folder with $SPEC_COUNT specs"
else
    echo -e "  ${RED}[✗]${NC} $SPECS_DIR folder - no .md files found"
fi
echo ""

# Show specs UI (always show, even if empty)
show_specs_ui "$SPECS_DIR"

echo -e "${CYAN}The loop checks for <promise>DONE</promise> in each iteration.${NC}"
echo -e "${CYAN}Agent must verify acceptance criteria before outputting it.${NC}"
echo -e "${YELLOW}Changes will be committed but NOT pushed to remote.${NC}"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop the loop${NC}"
echo ""

ITERATION=0
CONSECUTIVE_FAILURES=0
MAX_CONSECUTIVE_FAILURES=3

while true; do
    # Check max iterations
    if [ $MAX_ITERATIONS -gt 0 ] && [ $ITERATION -ge $MAX_ITERATIONS ]; then
        echo -e "${GREEN}Reached max iterations: $MAX_ITERATIONS${NC}"
        break
    fi

    ITERATION=$((ITERATION + 1))
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    echo ""
    echo -e "${PURPLE}════════════════════ LOOP $ITERATION ════════════════════${NC}"
    echo -e "${BLUE}[$TIMESTAMP]${NC} Starting iteration $ITERATION"
    echo ""

    # Find and update highest priority PENDING spec to IN_PROGRESS
    CURRENT_SPEC=""
    if [ -d "$SPECS_DIR" ]; then
        while IFS= read -r spec; do
            status=$(grep -E "^## Status:" "$spec" 2>/dev/null | head -1 | sed 's/## Status: //' || echo "")
            if [ "$status" = "PENDING" ]; then
                CURRENT_SPEC="$spec"
                break
            fi
        done < <(find "$SPECS_DIR" -maxdepth 2 -name "*.md" -type f 2>/dev/null | sort)
    fi

    if [ -n "$CURRENT_SPEC" ]; then
        SPEC_NAME=$(basename "$CURRENT_SPEC")
        echo -e "${YELLOW}Updating status: ${SPEC_NAME} PENDING → IN_PROGRESS${NC}"
        sed -i 's/^## Status: PENDING$/## Status: IN_PROGRESS/' "$CURRENT_SPEC"
        echo -e "${GREEN}✓ Status updated${NC}"
        echo ""
    fi

    # Log file for this iteration
    LOG_FILE="$LOG_DIR/ralph_${MODE}_iter_${ITERATION}_$(date '+%Y%m%d_%H%M%S').log"
    : > "$LOG_FILE"
    WATCH_PID=""

    if [ "$ROLLING_OUTPUT_INTERVAL" -gt 0 ] && [ "$ROLLING_OUTPUT_LINES" -gt 0 ] && [ -t 1 ] && [ -w /dev/tty ]; then
        watch_latest_output "$LOG_FILE" "Claude" &
        WATCH_PID=$!
    fi
    RLM_STATUS="unknown"

    # Snapshot prompt (optional RLM workspace)
    if [ -n "$RLM_CONTEXT_FILE" ]; then
        RLM_PROMPT_SNAPSHOT="$RLM_TRACE_DIR/iter_${ITERATION}_prompt.md"
        cp "$PROMPT_FILE" "$RLM_PROMPT_SNAPSHOT"
    fi

    # Run Claude with prompt via stdin, capture output
    CLAUDE_OUTPUT=""
    if CLAUDE_OUTPUT=$(cat "$PROMPT_FILE" | "$CLAUDE_CMD" $CLAUDE_FLAGS 2>&1 | tee "$LOG_FILE"); then
        if [ -n "$WATCH_PID" ]; then
            kill "$WATCH_PID" 2>/dev/null || true
            wait "$WATCH_PID" 2>/dev/null || true
        fi
        echo ""
        echo -e "${GREEN}✓ Claude execution completed${NC}"
        
        # Check if DONE promise was output (accept both DONE and ALL_DONE variants)
        if echo "$CLAUDE_OUTPUT" | grep -qE "<promise>(ALL_)?DONE</promise>"; then
            DETECTED_SIGNAL=$(echo "$CLAUDE_OUTPUT" | grep -oE "<promise>(ALL_)?DONE</promise>" | tail -1)
            echo -e "${GREEN}✓ Completion signal detected: ${DETECTED_SIGNAL}${NC}"
            echo -e "${GREEN}✓ Task completed and committed!${NC}"
            CONSECUTIVE_FAILURES=0
            RLM_STATUS="done"
            
            # For planning mode, stop after one successful plan
            if [ "$MODE" = "plan" ]; then
                echo ""
                echo -e "${GREEN}Planning complete!${NC}"
                echo -e "${CYAN}Run .ralph/scripts/ralph-loop.sh to start building.${NC}"
                echo -e "${CYAN}Or delete $PLAN_FILE to work directly from specs.${NC}"
                break
            fi
        else
            echo -e "${YELLOW}⚠ No completion signal found${NC}"
            echo -e "${YELLOW}  Agent did not output <promise>DONE</promise> or <promise>ALL_DONE</promise>${NC}"
            echo -e "${YELLOW}  This means acceptance criteria were not met.${NC}"
            echo -e "${YELLOW}  Retrying in next iteration...${NC}"

            # Revert status to PENDING since task wasn't completed
            if [ -n "$CURRENT_SPEC" ]; then
                SPEC_NAME=$(basename "$CURRENT_SPEC")
                echo -e "${YELLOW}Reverting status: ${SPEC_NAME} IN_PROGRESS → PENDING${NC}"
                sed -i 's/^## Status: IN_PROGRESS$/## Status: PENDING/' "$CURRENT_SPEC"
                echo -e "${YELLOW}✓ Status reverted (will retry in next iteration)${NC}"
            fi

            CONSECUTIVE_FAILURES=$((CONSECUTIVE_FAILURES + 1))
            RLM_STATUS="incomplete"
            print_latest_output "$LOG_FILE" "Claude"

            if [ $CONSECUTIVE_FAILURES -ge $MAX_CONSECUTIVE_FAILURES ]; then
                echo ""
                echo -e "${RED}⚠ $MAX_CONSECUTIVE_FAILURES consecutive iterations without completion.${NC}"
                echo -e "${RED}  The agent may be stuck. Consider:${NC}"
                echo -e "${RED}  - Checking the logs in $LOG_DIR${NC}"
                echo -e "${RED}  - Simplifying the current spec${NC}"
                echo -e "${RED}  - Manually fixing blocking issues${NC}"
                echo ""
                CONSECUTIVE_FAILURES=0
            fi
        fi
    else
        if [ -n "$WATCH_PID" ]; then
            kill "$WATCH_PID" 2>/dev/null || true
            wait "$WATCH_PID" 2>/dev/null || true
        fi
        echo -e "${RED}✗ Claude execution failed${NC}"
        echo -e "${YELLOW}Check log: $LOG_FILE${NC}"

        # Revert status to PENDING on error
        if [ -n "$CURRENT_SPEC" ]; then
            SPEC_NAME=$(basename "$CURRENT_SPEC")
            echo -e "${YELLOW}Reverting status: ${SPEC_NAME} IN_PROGRESS → PENDING${NC}"
            sed -i 's/^## Status: IN_PROGRESS$/## Status: PENDING/' "$CURRENT_SPEC"
            echo -e "${YELLOW}✓ Status reverted (will retry in next iteration)${NC}"
        fi

        CONSECUTIVE_FAILURES=$((CONSECUTIVE_FAILURES + 1))
        RLM_STATUS="error"
        print_latest_output "$LOG_FILE" "Claude"
    fi

    # Record iteration in RLM index (optional)
    if [ -n "$RLM_CONTEXT_FILE" ]; then
        RLM_PROMPT_PATH="${RLM_PROMPT_SNAPSHOT:-}"
        RLM_OUTPUT_SNAPSHOT="$RLM_TRACE_DIR/iter_${ITERATION}_output.log"
        cp "$LOG_FILE" "$RLM_OUTPUT_SNAPSHOT"
        echo -e "${TIMESTAMP}\t${MODE}\t${ITERATION}\t${RLM_PROMPT_PATH}\t${LOG_FILE}\t${RLM_OUTPUT_SNAPSHOT}\t${RLM_STATUS}" >> "$RLM_INDEX"
    fi

    # Brief pause between iterations
    echo ""
    echo -e "${BLUE}Waiting 2s before next iteration...${NC}"
    sleep 2
done

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}       RALPH LOOP FINISHED ($ITERATION iterations)                ${NC}"
echo -e "${GREEN}       All changes committed locally (no push)                   ${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
