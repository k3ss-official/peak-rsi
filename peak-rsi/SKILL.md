---
name: peak-rsi
description: >
  Recursive self-improvement loop for a single objective. Sharpen the
  objective, attack the deliverable with a hostile critic, close exactly one
  defect per cycle, and stop only when another cycle would not change a
  competent ship decision. Use when the user says peak, RSI, recursive
  self-improvement, improve until you can't, peak version, maximum version,
  or asks a coding assistant to recursively improve a task, project, or
  deliverable until it is at its best.
version: 1.0.0
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

- If the user already gave a falsifiable bar, write `objective: accepted as given` and do not rewrite it for sport.
- If they did not, rewrite it into: outcome (observable), bar (checkable), non-goals, evidence, assumptions.
- Assumptions are decisions. Log them. Ask a question only when a missing fact would fork the architecture and the wrong fork is expensive to reverse. One question. Then continue. Never a questionnaire.
- Vague words (`better`, `modern`, `robust`, `clean`, `polished`, `intuitive`, `seamless`) are defects in the objective, not permission to restyle.

Cycle 0's only legal artifact change is none.

## The loop

Hard cap: **8 cycles**. The cap is a rail, not a target. Most work should peak in 3–5. At the cap, stop anyway and emit the certificate with `capped: true` and the single next defect you would have taken.

Each cycle, in this order. Do not skip.

### 1. State

One short block before you edit: objective version, what is frozen, open defects, assumptions still in force.

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

- Objective defect: revise the objective so it is stricter or clearer, never looser. Diff it. If any sentence became easier to satisfy, revert — that is a reward hack. Do not also edit the artifact in this cycle unless the new bar shows the artifact already fails, in which case the objective revision is the reason and the artifact fix is the edit.
- Harness defect: add, narrow, or delete one check. Leave the artifact frozen.
- Artifact defect: close it. No "while I'm here."

### 5. Verify

Re-check the closed defect with evidence: a command and its output, a traced input and result, a failing case that now fails the right way. If you cannot produce evidence, the cycle has not closed. Fix or revert. Narrative does not count.

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
rejected: what you considered and did not take, or "none"
harness: unchanged | added | removed
residual: what remains open, or "none at ship-block/high"
```

### 8. Stop gate

Stop only if **all** of these are true. Read `references/stop-gate.md` if you feel the urge to stop earlier or to continue past them.

1. Last critic pass has zero `ship-block` and zero `high`.
2. You can name the next candidate defect, and it is taste, out of scope, or not worth the cost. Name it.
3. This cycle did not weaken the objective, the tests, or the critic.
4. The last close has real verification, not a summary.
5. A colder second read agrees: another cycle would not change a competent reviewer's ship decision.

If any item fails, start the next cycle. If all pass, emit the certificate and stop talking.

## Peak certificate

The last thing you write. No preamble, no offer to keep going.

```
PEAK
objective (final): ...
cycles: N   (edits, rejects, cap)
closed: [ids]
rejected on purpose: ...
still true: ...   (honest residuals, not a disguised todo you should have done)
why another cycle won't pay: ...
capped: false
```

If you hit the cap without a clean gate, `capped: true`, and `still true` leads with the defect you would have taken next.

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
