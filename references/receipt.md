# Receipt and certificate

The ledger is the product of the loop, besides the artifact. If it is missing, the loop did not happen.

Write receipts where the work lives: in the reply if there is no repo, or in `PEAK.md` at the repo root if you are editing a project and the user has not forbidden extra files. Do not create `PEAK.md` for a one-line change in a repo that already has a place for notes. The reply is enough when the session is the record.

Never edit the ledger to make an old cycle look smarter.

## Cycle receipt

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

Rules:

- `N` starts at 0. Cycle 0 uses `defect: none — sharpen` when the only work was the contract, or `defect: D0 (high) — objective unfalsifiable` when it was not.
- `vX -> vY` is `v1 -> v1` when the text did not change. Say `accepted as given` in the defect line for that case.
- Evidence names a result. "Tests pass" is not evidence unless you name which test and what it asserts.
- `rejected` is how later cycles avoid repeating a bad idea. One line is enough.
- `residual` may include taste. It must not hide a ship-block behind soft language.

## Rejected attempt

If you edit and then revert inside the same cycle, still write the cycle. Surface stays what you attempted. Evidence says `reverted`. Defect line says `rejected`. The harness delta records the new check if the attempt revealed a blind spot. A rejected attempt counts toward the cap. It should. That is the point of the cap.

## Certificate

Emit once. Last message of the loop. No sentence after it.

```
PEAK
objective (final): vN — one sentence, plus assumptions still in force
cycles: N considered, R rejected, E artifact edits
closed: D1, D2
rejected on purpose: R1 test weakened to match the bug
still true: label copy; in-memory export assumed under a few thousand rows
why another cycle won't pay: the only named leftover is button copy, which the bar does not score
capped: false
```

`still true` is not a backlog you are volunteering to do next. If an item in `still true` would change a ship decision, the gate was wrong. Go back and close it.

`closed` lists defects the artifact or the contract actually no longer has, with evidence in some receipt. Do not list wishes.
