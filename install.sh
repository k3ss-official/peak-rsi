#!/bin/sh
# PEAK global install. Re-runnable. POSIX sh.
# Repo checkout: ~/.agents/src/peak-rsi
# Skill slot:    ~/.agents/skills/peak-rsi  ->  <checkout>/peak-rsi
# gh skill discovers peak-rsi/SKILL.md. Cloning the repo onto a skill
# path would nest that folder one level too deep, so the slot is a link.
set -eu

REPO="https://github.com/k3ss-official/peak-rsi.git"
NAME="peak-rsi"
SRC="${HOME}/.agents/src/${NAME}"
CANON="${HOME}/.agents/skills/${NAME}"

if ! command -v git >/dev/null 2>&1; then
  echo "git is required" >&2
  exit 1
fi

mkdir -p "${HOME}/.agents/src" "${HOME}/.agents/skills"

# Installs from before the skill lived in peak-rsi/ cloned the repo
# straight into the skill slot. Move that checkout out of the slot.
if [ -d "${CANON}/.git" ] && [ ! -L "${CANON}" ] && [ ! -d "${SRC}/.git" ]; then
  mv "${CANON}" "${SRC}"
fi

if [ -d "${SRC}/.git" ]; then
  git -C "${SRC}" pull --ff-only
elif [ -e "${SRC}" ]; then
  echo "Refusing to replace existing ${SRC} (not a git checkout of this skill)." >&2
  exit 1
else
  git clone --depth 1 "${REPO}" "${SRC}"
fi

if [ ! -f "${SRC}/peak-rsi/SKILL.md" ]; then
  echo "Checkout has no ${SRC}/peak-rsi/SKILL.md" >&2
  exit 1
fi

link_slot() {
  dir=$1
  mkdir -p "$dir"
  target="${dir}/${NAME}"
  if [ -L "$target" ] || [ ! -e "$target" ]; then
    ln -sfn "${SRC}/peak-rsi" "$target"
    echo "linked ${target}"
  else
    echo "skip ${target} (real directory already there)"
  fi
}

link_slot "${HOME}/.agents/skills"
link_slot "${HOME}/.claude/skills"
link_slot "${HOME}/.cursor/skills"
link_slot "${HOME}/.codex/skills"
link_slot "${HOME}/.grok/skills"
link_slot "${HOME}/.hermes/skills"
link_slot "${HOME}/.copilot/skills"
link_slot "${HOME}/.gemini/skills"
link_slot "${HOME}/.config/opencode/skills"
link_slot "${HOME}/.codeium/windsurf/skills"
link_slot "${HOME}/.continue/skills"
link_slot "${HOME}/.cline/skills"
link_slot "${HOME}/.roo/skills"
link_slot "${HOME}/.kilocode/skills"
link_slot "${HOME}/.config/goose/skills"
link_slot "${HOME}/.factory/skills"
link_slot "${HOME}/.openhands/skills"
link_slot "${HOME}/.gemini/antigravity/skills"
link_slot "${HOME}/.kiro/skills"
link_slot "${HOME}/.junie/skills"

if [ ! -f "${CANON}/SKILL.md" ]; then
  echo "Skill slot ${CANON}/SKILL.md is missing after link" >&2
  exit 1
fi

echo "PEAK ${NAME} is at ${CANON}"
echo "Open a new session. Say: Use peak. Improve until you can't."
