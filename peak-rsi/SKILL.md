---
name: peak-rsi
description: >
  Recursive self-improvement loop for a single objective. Sharpen the
  objective, attack the deliverable with a hostile critic, close exactly one
  defect per cycle, and stop only when another cycle would not change a
  competent ship decision. Use when the user says peak or peak-rsi,
  recursive self-improvement (RSI), improve until you can't, peak version,
  or maximum version, or asks a coding assistant to recursively improve a
  task, project, or deliverable until it is at its best. Not for RSI the
  trading indicator, and not for peak in its everyday sense (peak hours,
  peak load).
metadata:
  version: "1.1.0"
---

# PEAK

Improve until you can't. Then stop.

You run a closed loop on **one** objective until a hostile critic cannot name a change that would alter a ship decision. You may improve three surfaces: the objective, the harness, and the artifact. You never weaken the objective, the tests, or the critic to earn a stop.

Do not announce the skill. Do not celebrate. Keep a ledger.

## What "peak" means

Peak is not the cleverest version you can imagine. Peak is the version where the next honest edit would not change whether a competent reviewer ships it against the current bar.

Taste, novelty, and extra features are not peak. A falsifiable bar is peak's floor.

## Three surfaces

Every cycle touches one of these. Name which.

1. **Objective** — the success contract. Make it stricter or more falsifiable. Never easier. If two competent reviewers could disagree about whether the artifact passes, the objective is still defective.
2. **Harness** — your checks. If the same defect class survives two cycles, the checklist was blind: add one check. If a check only creates churn and never catches a real defect, narrow or delete it.
3. **Artifact** — the code, doc, design, or other deliverable. Every accepted edit closes a named defect from the last critic pass. Nothing else.

A cycle that "improves" all three at once is unfocused. Select one defect.

## Cycle 0 — before any artifact edit

Read `references/cycle-zero.md` if the ask is vague. Otherwise:

- If the user already gave a falsifiable bar, the cycle 0 receipt says `objective: v1 -> v1` and `defect: none — accepted as given`. Do not rewrite it for sport.
- If they did not, rewrite it into: outcome (observable), bar (checkable), non-goals, evidence, assumptions.
- Assumptions are decisions. Log them. Ask a question only when a missing fact would fork the architecture and the wrong fork is expensive to reverse. One question. Then continue. Never a questionnaire.
- Vague words (`better`, `modern`, `robust`, `clean`, `polished`, `intuitive`, `seamless`) are defects in the objective, not permission to restyle.

Cycle 0's only legal artifact change is none.

## The loop

Hard cap: **8 cycles after cycle 0**. Cycle 0 does not count toward the cap. A rejected attempt does. The cap is a rail, not a target. Most work should peak in 3–5. If the gate after cycle 8 has not cleared, stop anyway and emit the certificate with `capped: true` and the single next defect you would have taken. If it has cleared, that is an ordinary stop: `capped: false`.

Each cycle, in this order. Do not skip.

### 1. State

One short block before you edit: objective version, what is frozen, open defects, assumptions still in force, and the pre-cycle rollback anchor (`git rev-parse --short HEAD` in a repo, or pre-edit snapshot). You must record this anchor before touching any file.

### 2. Critic

Separate posture from the author. You are trying to disconfirm, not to defend the last edit. Read `references/critic.md` when you are unsure what counts.

Output only:

- Defects, ranked. Each one: id, surface (`objective` | `harness` | `artifact`), severity (`ship-block` | `high` | `low` | `taste`), where it lives, the change that would close it, in-scope or not.
- What is already at the bar. Do not reopen it.
- Reward-hack check: did the last cycle raise the score by weakening a test, narrowing the objective, hiding a failure, or editing the rubric?

A defect without a location is not a defect. "Could be nicer" is taste. Taste does not open a cycle unless the bar named that quality.

If you cannot name a `ship-block` or `high` defect with evidence, go to the stop gate. Do not invent a nit to keep the loop alive.

### 3. Select

Take the single highest-leverage **in-scope** defect. One. Say why the others wait.

Priority: ship-block correctness, security, data loss, and a lying or broken primary path; then high defects that make the bar false; then objective defects that make the bar unfalsifiable; then harness blindness. Low and taste wait. Out-of-scope never gets a turn.

### 4. Edit

Smallest change that fully closes that defect.

- Objective defect: revise the objective so it is stricter or clearer, never looser. Diff it. If any sentence became easier to satisfy, revert — that is a reward hack. Do not also edit the artifact in this cycle unless the new bar shows the artifact already fails, in which case the objective revision is the reason and the artifact fix is the edit. That cycle's receipt says `surface: objective` and shows the version change on the `objective:` line.
- Harness defect: add, narrow, or delete one check. Leave the artifact frozen.
- Artifact defect: close it. No "while I'm here."

### 5. Verify

Re-check the closed defect with evidence: a command and its output, a traced input and result, a failing case that now fails the right way. If you cannot produce evidence, the cycle has not closed. Fix or revert. Narrative does not count.

Run cumulative regression checks (`H9`) on all previously closed defects (`D1..Dn-1`). Every cycle's verification must confirm that prior fixes remain intact.

On failure or rejected cycle, enforce an atomic rollback (`git checkout -- .` and `git clean -fd` in a repo, or pre-edit snapshot restore) back to the pre-cycle anchor, and verify `git status --porcelain` is clean. Zero partial edits may survive a failed or rejected cycle.

A test changed so the bug satisfies it is not verification. Revert it.

### 6. Harness delta

One line: `unchanged`, `added <id>: <check>`, or `removed <id>: <why>`. This line is mandatory even when the selected defect was not a harness defect.

### 7. Receipt

Append exactly this shape (see `references/receipt.md`):

```
## Cycle N
objective: vX -> vY
surface: objective | harness | artifact
defect: D-id (severity) — one sentence
evidence: what you ran or traced, and what it showed
rejected: what you considered and did not take, or none
harness: unchanged | added H-id: check | removed H-id: why
residual: what remains open, or none at ship-block/high
```

### 8. Stop gate

Stop only if **all** of these are true. Read `references/stop-gate.md` if you feel the urge to stop earlier or to continue past them.

1. Last critic pass has zero `ship-block` and zero `high`.
2. You can name the next candidate defect, and it is taste, out of scope, or not worth the cost. Name it.
3. This cycle did not weaken the objective, the tests, or the critic.
4. The last close has real verification, not a summary.
5. **Wraith zero-trust gate**: spawn a cold verifier sub-agent (given only the final Objective, active Harness, and final Artifact/diff with zero cycle history) or run a deterministic cold audit mapping every Bar requirement to raw output.

If any item fails, start the next cycle. If all pass, emit the certificate and stop talking.

## Peak certificate

The last thing you write. No preamble, no offer to keep going.

```
PEAK
objective (final): vN — one sentence, plus assumptions still in force
cycles: N considered, R rejected, E artifact edits
closed: defect ids, each verified in some receipt
rejected on purpose: rejected ids, one line each
still true: honest residuals, not a disguised todo you should have done
why another cycle won't pay: the declined candidate, and why
wraith: pass - [cold verification summary or sub-agent receipt]
capped: false
```

If you hit the cap without a clean gate, `capped: true`, `wraith: fail - capped`, and `still true` leads with the defect you would have taken next.

## Forbidden

Full list and the reward-hack patterns: `references/forbidden.md`.

- Declaring done because the diff looks tidy or you are tired.
- Features the objective did not ask for.
- Lowering tests, deleting assertions, narrowing types to silence a failure, special-casing the demo, or editing the bar so the current output passes.
- Cosmetic cycles (rename, reformat, comment, label) counted as improvement.
- Bundling several defects into one cycle so the ledger looks faster.
- Questionnaires. One question, only on an expensive architectural fork.
- Self-praise. The certificate is a ledger.
- Continuing after the certificate.

## Seed harness

Start from `references/harness.md`. Add and remove checks in the receipt. Do not silently replace the seed with a softer list.

## Worked shape

If you have not run this loop before in the session, skim one worked stop in `references/example-ledger.md` before cycle 1. Imitate the grain of the receipts, not the domain.
