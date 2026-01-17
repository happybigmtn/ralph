#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") <dest_dir>"
  echo "  Copies the Ralph template into <dest_dir>."
  echo "  <dest_dir> must exist and be empty-ish (no ralph/ or AGENTS.md)."
}

if [ ${#@} -ne 1 ]; then
  usage
  exit 2
fi

DEST="$1"

if [ ! -d "$DEST" ]; then
  echo "Error: destination directory does not exist: $DEST" >&2
  exit 1
fi

if [ -e "$DEST/ralph" ] || [ -e "$DEST/AGENTS.md" ]; then
  echo "Error: destination already has ralph/ or AGENTS.md; refusing to overwrite" >&2
  exit 1
fi

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

cp -a "$SCRIPT_DIR/ralph" "$DEST/ralph"
cp -a "$SCRIPT_DIR/AGENTS.md" "$DEST/AGENTS.md"

chmod +x "$DEST/ralph/loop.sh" "$DEST/ralph/loopclaude.sh" || true

echo "Installed Ralph template into: $DEST"
