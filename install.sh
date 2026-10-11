#!/bin/sh
# PEAK 1.0.0 — global install. Re-runnable. POSIX sh.
# Canonical copy: ~/.agents/skills/peak-rsi
# Other assistants get a symlink to that copy.
set -eu

REPO="https://github.com/k3ss-official/peak-rsi.git"
NAME="peak-rsi"
CANON="${HOME}/.agents/skills/${NAME}"

if ! command -v git >/dev/null 2>&1; then
  echo "git is required" >&2
  exit 1
fi

mkdir -p "${HOME}/.agents/skills"

if [ -d "${CANON}/.git" ]; then
  git -C "${CANON}" pull --ff-only
elif [ -e "${CANON}" ]; then
  echo "Refusing to replace existing ${CANON} (not a git checkout of this skill)." >&2
  exit 1
else
  git clone --depth 1 "${REPO}" "${CANON}"
fi

if [ ! -f "${CANON}/SKILL.md" ]; then
  echo "Clone did not produce ${CANON}/SKILL.md" >&2
  exit 1
fi

# One path per line. Canonical is skipped.
PATHS="
${HOME}/.claude/skills
${HOME}/.cursor/skills
${HOME}/.codex/skills
${HOME}/.grok/skills
${HOME}/.hermes/skills
${HOME}/.copilot/skills
${HOME}/.gemini/skills
${HOME}/.config/opencode/skills
${HOME}/.codeium/windsurf/skills
${HOME}/.continue/skills
${HOME}/.cline/skills
${HOME}/.roo/skills
${HOME}/.kilocode/skills
${HOME}/.config/goose/skills
${HOME}/.factory/skills
${HOME}/.openhands/skills
${HOME}/.gemini/antigravity/skills
${HOME}/.kiro/skills
${HOME}/.junie/skills
"

echo "$PATHS" | while IFS= read -r dir; do
  [ -n "$dir" ] || continue
  target="${dir}/${NAME}"
  if [ "$target" = "$CANON" ]; then
    continue
  fi
  mkdir -p "$dir"
  if [ -L "$target" ] || [ ! -e "$target" ]; then
    ln -sfn "$CANON" "$target"
    echo "linked ${target}"
  else
    echo "skip ${target} (real directory already there)"
  fi
done

echo "PEAK ${NAME} is at ${CANON}"
echo "Open a new session. Say: Use peak. Improve until you can't."
