#!/usr/bin/env bash
# Ralph loop runner using Codex CLI
set -euo pipefail

# Configuration
PLAN_FILE="IMPLEMENTATION_PLAN.md"
LOG_DIR="logs"
MODEL="gpt-5.2"

# Determine prompt file based on mode
MODE="build"
WORK_SCOPE=""
PROMPT_FILE="PROMPT_build.md"
MAX_ITERATIONS=0  # 0 = unlimited

if [[ "${1:-}" == "plan" ]]; then
    MODE="plan"
    PROMPT_FILE="PROMPT_plan.md"
    MAX_ITERATIONS=${2:-0}
elif [[ "${1:-}" == "plan-work" ]]; then
    MODE="plan-work"
    PROMPT_FILE="PROMPT_plan_work.md"
    WORK_SCOPE="${2:-}"
    MAX_ITERATIONS=${3:-0}
    if [[ -z "$WORK_SCOPE" ]]; then
        echo "Error: plan-work requires a scope description"
        echo "Usage: ./loopcodex.sh plan-work \"description of work scope\""
        exit 1
    fi
elif [[ "${1:-}" =~ ^[0-9]+$ ]]; then
    MAX_ITERATIONS=$1
fi

mkdir -p "$LOG_DIR"

count_remaining() {
    grep -c '^- \[ \]' "$PLAN_FILE" 2>/dev/null || echo 0
}

count_completed() {
    grep -c '^- \[x\]' "$PLAN_FILE" 2>/dev/null || echo 0
}

count_blocked() {
    grep -c 'Blocked:' "$PLAN_FILE" 2>/dev/null || echo 0
}

# Verify files exist
if [[ ! -f "$PROMPT_FILE" ]]; then
    echo "Error: $PROMPT_FILE not found"
    exit 1
fi

if [[ ! -f "$PLAN_FILE" ]]; then
    echo "Error: $PLAN_FILE not found"
    exit 1
fi

# Header
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Ralph Loop (Codex)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Mode:   $MODE"
echo "  Model:  $MODEL"
echo "  Prompt: $PROMPT_FILE"
echo "  Plan:   $PLAN_FILE"
[[ "$MAX_ITERATIONS" -gt 0 ]] && echo "  Max:    $MAX_ITERATIONS iterations"
[[ "$MAX_ITERATIONS" -eq 0 ]] && echo "  Max:    unlimited"
[[ -n "$WORK_SCOPE" ]] && echo "  Scope:  $WORK_SCOPE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

iteration=0
while true; do
    iteration=$((iteration + 1))
    remaining=$(count_remaining)
    completed=$(count_completed)
    timestamp=$(date +%Y%m%d-%H%M%S)
    log_file="$LOG_DIR/codex-${iteration}-${timestamp}.log"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Iteration $iteration | Remaining: $remaining | Completed: $completed"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    if [[ "$remaining" -eq 0 ]]; then
        echo "All tasks complete!"
        break
    fi

    if [[ "$MAX_ITERATIONS" -gt 0 ]] && [[ "$iteration" -gt "$MAX_ITERATIONS" ]]; then
        echo "Max iterations ($MAX_ITERATIONS) reached. $remaining tasks remaining."
        exit 1
    fi

    # Build prompt with scope substitution for plan-work mode
    if [[ "$MODE" == "plan-work" ]]; then
        export WORK_SCOPE
        prompt_content=$(envsubst < "$PROMPT_FILE")
    else
        prompt_content=$(cat "$PROMPT_FILE")
    fi

    # Run Codex CLI
    echo "Running Codex CLI..."
    if codex exec --dangerously-bypass-approvals-and-sandbox -m "$MODEL" "$prompt_content" 2>&1 | tee "$log_file"; then
        echo "Codex completed successfully"
    else
        echo "Codex exited with error, checking if progress was made..."
    fi

    # Check progress
    new_remaining=$(count_remaining)
    if [[ "$new_remaining" -eq "$remaining" ]]; then
        echo "No progress made this iteration. Check $log_file"
        echo "Waiting 10s before retry..."
        sleep 10
    else
        echo "Progress: $remaining -> $new_remaining tasks"
    fi

    # Auto-commit if enabled
    if [[ "${RALPH_AUTOCOMMIT:-0}" == "1" ]] && [[ "$MODE" == "build" ]]; then
        if [[ -n "$(git status --porcelain)" ]]; then
            msg="ralph: iteration $iteration (codex)"
            echo "Committing: $msg"
            git add -A && git commit -m "$msg" || echo "Commit failed"
        fi
    fi

    sleep 2
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Total iterations: $iteration"
echo "  Tasks completed:  $(count_completed)"
echo "  Tasks blocked:    $(count_blocked)"
echo "  Logs:             $LOG_DIR/"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
