# PEAK

**Skill version 1.2.0.** Install guide dated 2026-10-11.

Improve until you can't. One objective, a hostile critic, one defect per cycle, stop only when another cycle would not change a ship decision.

This is bounded recursive self-improvement. The loop is not allowed to weaken the bar to declare victory.

## If you were told to install this

You are in the right place. Install it globally, then stop. Do not edit the user's project. Do not ask which assistant they meant. The command covers the assistants that read a global skills folder.

```sh
curl -fsSL https://raw.githubusercontent.com/k3ss-official/peak-rsi/main/install.sh | sh
```

That clones this repo to `~/.agents/src/peak-rsi` and links `~/.agents/skills/peak-rsi` at the `peak-rsi/` folder inside the checkout, which is where `SKILL.md` sits. Other global skill directories get the same link. Re-running it fast-forwards the checkout. An older install that cloned the repo directly into `~/.agents/skills/peak-rsi` is moved to `~/.agents/src/peak-rsi` and linked. It will not overwrite any other real directory that is already in a skill slot.

Then tell the person to open a **new** session. Skills are read at session start.

Check: `~/.agents/skills/peak-rsi/SKILL.md` exists, and `head -5` shows `name: peak-rsi`.

Say: "Use peak. Improve until you can't."

## Zip

Release asset, folder name included so it unzips as `peak-rsi/`:

https://github.com/k3ss-official/peak-rsi/raw/main/dist/peak-rsi.zip

```sh
curl -fsSL -o /tmp/peak-rsi.zip https://github.com/k3ss-official/peak-rsi/raw/main/dist/peak-rsi.zip
unzip -o /tmp/peak-rsi.zip -d ~/.agents/skills
# then run install.sh from the clone, or symlink by hand using the table
```

Prefer the git install. The zip has no `.git`, so it will not update.

## Version

| Piece | Version | What it is |
| --- | --- | --- |
| Skill | 1.2.0 | `metadata.version` in `SKILL.md` frontmatter. The loop. |
| Install guide | 2026-10-11 | This file. Paths below were checked against vendor docs on that date. |
| Release | v1.0.1 | Git tag for this install layout. On 2026-10-11, `gh skill install` with no pin used `main` when the repo had a tag but no GitHub Release. The zip is `dist/peak-rsi.zip` on main. The loop in `SKILL.md` is version 1.2.0 on main; the v1.0.1 tag still carries loop 1.0.0. |

Paths move. If a directory in the table is empty on a newer build, install the canonical copy and symlink it to wherever that assistant's current docs say.

## Global paths

Canonical copy: `~/.agents/skills/peak-rsi`. Everything else is a symlink to it. `SKILL.md` must sit directly inside `peak-rsi/`, not in a nested `peak-rsi/peak-rsi/`.

Windows: the same folders under `%USERPROFILE%`. Use Git Bash or WSL for `install.sh`.

| Assistant | Global folder | How to invoke | Notes, as of 2026-10-11 |
| --- | --- | --- | --- |
| Codex | `~/.agents/skills/peak-rsi` | `$peak-rsi`, or describe the task | Official user scope. Also install `~/.codex/skills/peak-rsi` because `$skill-installer` and `$CODEX_HOME/skills` still default there. Restart Codex if it does not list. |
| Grok Build | `~/.grok/skills/peak-rsi` | `/peak-rsi`, or "use peak" | Also reads `~/.claude/skills`. Extra dirs go under `[skills] paths` in `~/.grok/config.toml`. New session. |
| Cursor | `~/.cursor/skills/peak-rsi` | `/peak-rsi` in Agent chat | Also reads `~/.agents/skills`, `~/.claude/skills`, and `~/.codex/skills`. Cloud Agents only sync `~/.cursor/skills` after Sync Skills is on. |
| Claude Code | `~/.claude/skills/peak-rsi` | `/peak-rsi` | Personal skills, every project on this machine. Not Claude.ai cloud. Confirm with `/skills`. New session. |
| Hermes | `~/.hermes/skills/peak-rsi` | `/peak-rsi` | Flat folder, not a category subfolder. Or `hermes skills install` on the raw `SKILL.md` URL; the clone is safer because it brings `references/`. New session, or `/reset`. |
| GitHub Copilot | `~/.copilot/skills/peak-rsi` | Agent picks it up from the description | Also reads `~/.agents/skills`. `gh` v2.90.0+ can install with `gh skill install k3ss-official/peak-rsi peak-rsi --agent github-copilot --scope user`. |
| Gemini CLI | `~/.gemini/skills/peak-rsi` | Description match | Project copies use `.agents/skills` or `.gemini/skills`. |
| OpenCode | `~/.config/opencode/skills/peak-rsi` | `skill` tool | Also reads `~/.claude/skills` and `~/.agents/skills`. |
| Windsurf | `~/.codeium/windsurf/skills/peak-rsi` | Description match | |
| Cline | `~/.agents/skills/peak-rsi` and `~/.cline/skills/peak-rsi` | Description match | Sources disagree on the folder. The installer writes both. |
| Continue | `~/.continue/skills/peak-rsi` | Description match | |
| Roo Code | `~/.roo/skills/peak-rsi` | Description match | |
| Kilo Code | `~/.kilocode/skills/peak-rsi` | Description match | |
| Goose | `~/.config/goose/skills/peak-rsi` | Description match | |
| Factory Droid | `~/.factory/skills/peak-rsi` | Description match | |
| OpenHands | `~/.openhands/skills/peak-rsi` | Description match | |
| Antigravity | `~/.gemini/antigravity/skills/peak-rsi` | Description match | |
| Kiro | `~/.kiro/skills/peak-rsi` | Description match | Kiro may also need the skill URI registered in its resource config. |
| Junie | `~/.junie/skills/peak-rsi` | Description match | |
| Amp | `~/.agents/skills/peak-rsi` | Description match | |
| Warp | `~/.agents/skills/peak-rsi` | Description match | |

`install.sh` writes the canonical clone and symlinks the first block through Roo. Goose through Junie are in the script too. Amp and Warp only need the canonical folder.

## One assistant only

Replace `TARGET` with the global folder from the table.

```sh
git clone --depth 1 https://github.com/k3ss-official/peak-rsi.git "$HOME/.agents/src/peak-rsi"
ln -sfn "$HOME/.agents/src/peak-rsi/peak-rsi" "$TARGET/peak-rsi"
```

Codex, if you only want the legacy path:

```sh
git clone --depth 1 https://github.com/k3ss-official/peak-rsi.git "$HOME/.agents/src/peak-rsi"
ln -sfn "$HOME/.agents/src/peak-rsi/peak-rsi" ~/.codex/skills/peak-rsi
```

Hermes, from inside Hermes, if you would rather not clone by hand:

```
hermes skills install https://raw.githubusercontent.com/k3ss-official/peak-rsi/main/peak-rsi/SKILL.md --name peak-rsi
```

The clone is the one that keeps `references/` and `templates/` next to `SKILL.md`. Use that.

GitHub CLI, user scope, one host:

```sh
gh skill install k3ss-official/peak-rsi peak-rsi --agent claude-code --scope user
gh skill install k3ss-official/peak-rsi peak-rsi --agent cursor --scope user
gh skill install k3ss-official/peak-rsi peak-rsi --agent codex --scope user
```

Needs `gh` v2.90.0 or newer. The skill name is `peak-rsi`. `gh skill` only discovers a skill under a directory (`peak-rsi/SKILL.md`), so that is where the law lives. Do not clone the repo root onto a skill path. That nests it as `peak-rsi/peak-rsi/SKILL.md` and the agent will not load it.

## This project only

Same folder name, under the project instead of `$HOME`. Commit it if the team should get it.

| Assistant | Project folder |
| --- | --- |
| Codex, Cline, Warp, Amp, Copilot | `.agents/skills/peak-rsi` |
| Claude Code, and Grok's compat reader | `.claude/skills/peak-rsi` |
| Cursor | `.cursor/skills/peak-rsi` |
| Grok Build | `.grok/skills/peak-rsi` |
| Hermes | `.hermes/skills/peak-rsi` or `skills/peak-rsi` |
| Copilot (native) | `.github/skills/peak-rsi` |
| Gemini CLI | `.gemini/skills/peak-rsi` |
| OpenCode | `.opencode/skills/peak-rsi` |
| Windsurf | `.windsurf/skills/peak-rsi` |

## What the agent will do once it is on

1. Cycle 0. Accept a sharp objective, or rewrite a vague one. No product edit yet.
2. Critic. A defect needs a location and a severity. Taste does not open a cycle.
3. One defect. Smallest fix that fully closes it.
4. Verify. A test edited so the bug passes is rejected.
5. Harness. Add a check when the same class of defect escapes. Remove a check that only makes noise.
6. Stop. Five conditions, all required. Then a PEAK certificate, and silence.

Hard cap is 8 cycles. It is a rail. Most tasks should peak in 3 to 5. The law is `SKILL.md`.

## Layout

```
peak-rsi/                  # this repository
  README.md                # this file, also copied in the skill folder
  install.sh
  peak-rsi/
    SKILL.md
    install.sh
    references/
    templates/cursor-rule.mdc
  dist/peak-rsi.zip        # unpacks as peak-rsi/
```

Cursor users who cannot load a skill folder: copy `templates/cursor-rule.mdc` to `~/.cursor/rules/peak-rsi.mdc` or the project's `.cursor/rules/`. The skill folder is the better install.
