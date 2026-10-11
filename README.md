# PEAK

Improve until you can't.

A skill pack for coding agents. When it is on, the agent recursively improves **one** objective — the contract, its own checks, and the deliverable — and stops only when another cycle would not change a ship decision.

This is bounded recursive self-improvement. The evaluator stays hostile and explicit. The loop is not allowed to mark its own homework by weakening the bar.

## Install

Copy the `peak-rsi` folder. The folder name must stay `peak-rsi` so it matches the skill name.

### Hermes

```
~/.hermes/skills/peak-rsi/
```

Project-scoped, if you do not want it global:

```
<repo>/.hermes/skills/peak-rsi/
```

Trigger it in the task: "Use peak. Improve until you can't."

### Claude Code

```
<repo>/.claude/skills/peak-rsi/
```

or `~/.claude/skills/peak-rsi/` for every project.

### Cursor

Prefer the folder if your build picks up project skills. Otherwise install `templates/cursor-rule.mdc` as:

```
<repo>/.cursor/rules/peak-rsi.mdc
```

The rule points at `SKILL.md` and tells the agent to read the references before editing.

### Anyone else

Paste `SKILL.md` into the session, or point the agent at it. The file is the law. References are there when a cycle is ambiguous. A compiled brief from the PEAK console already contains a condensed copy of the loop, so a one-off session does not need the install.

## What the agent will do

1. **Cycle 0.** Accept a sharp objective or rewrite a vague one into an observable outcome, a checkable bar, non-goals, evidence, and logged assumptions. No product edit yet.
2. **Critic.** A hostile pass. Defects need a location and a severity. Taste does not open a cycle.
3. **One defect.** The highest-leverage in-scope item. Smallest fix that fully closes it.
4. **Verify.** A command, a trace, or a fixture. A test edited so the bug passes is rejected.
5. **Harness delta.** If the same class of defect keeps escaping, add a check. If a check only makes noise, remove it.
6. **Stop gate.** Five conditions, all required. Then a PEAK certificate, and silence.

Hard cap is 8 cycles. It is a rail. Most tasks should peak in 3 to 5.

## Files

| Path | Role |
| --- | --- |
| `SKILL.md` | The law. Self-contained enough to run. |
| `references/cycle-zero.md` | How to sharpen an objective without moving the goalposts. |
| `references/critic.md` | Defect schema, severities, reward-hack check. |
| `references/harness.md` | Seed checks and how the harness is allowed to evolve. |
| `references/stop-gate.md` | The can't test, including the second read. |
| `references/receipt.md` | Ledger shape and the certificate. |
| `references/forbidden.md` | Moves that look like progress and are not. |
| `references/example-ledger.md` | One worked stop. Imitate the grain. |
| `templates/activation.md` | Blank brief. The console fills this in. |
| `templates/cursor-rule.mdc` | Cursor install. |

## What this is not

Not an intelligence explosion, and not a license to rewrite the product until the context window ends. The agent improves the work in front of it. Weights, budget, and the decision to abandon the objective stay with you.
