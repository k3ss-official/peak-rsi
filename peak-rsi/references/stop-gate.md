# Stop gate

The loop stops when you can't, not when you won't.

"Can't" means: you can see a further edit, and you can say why it would not change a competent reviewer's decision to ship against the current bar.

## All five, or you loop

1. **Nothing sharp left.** The latest critic pass listed no `ship-block` and no `high`. If the critic "found nothing" but did not actually try to break the primary path and the edges in the bar, this item fails. Run the critic again for real.
2. **The next edit is named and declined.** Write the candidate in one sentence. Classify it `taste`, `out-of-scope`, or `not worth the cost`. "I can't think of anything" is not a classification. If you cannot name a candidate, the critic has not tried hard enough. Run it again against the primary path and the edges in the bar, then name what it found, even if that is taste.
3. **The bar did not move down.** Compare the objective text to the previous cycle. Compare the tests to the previous cycle. Any obligation that got easier fails the gate, even if the artifact is genuinely better.
4. **The last close was verified with H9 cumulative verification.** Point at the evidence in that cycle's receipt, including `H9` cumulative regression checks confirming that all previously closed defects (`D1..Dn-1`) remain passing. If the last cycle was cycle 0 (no artifact defect existed), verification is "the bar is falsifiable," and you still needed a critic pass against the artifact.
5. **Wraith zero-trust gate.** Require cold verification stripped of author context, cycle history, and cognitive bias. Spawn a cold verifier sub-agent (given only the final Objective, active Harness, and final Artifact/diff with zero cycle history) or run a deterministic cold audit directly mapping every Bar requirement to raw output. The cold verifier must independently confirm that the artifact satisfies the bar and that another cycle would not change a ship decision. Record `wraith: pass - [proof]` on the certificate. If the cold verifier uncovers a defect, the gate fails: return to select.

## Feelings that are not a gate

- The code looks clean.
- The user will probably like it.
- You have already done several cycles.
- A new idea is exciting.
- The diff is large, so it must be enough.
- The diff is small, so there is nothing left. Small and wrong is still wrong.

## Stopping too late

These are also gate failures, in the other direction:

- A cycle whose selected defect is taste.
- A cycle that adds a feature because the critic ran out of bugs.
- A rewrite of working code onto a preferred architecture, with no named defect.

If you catch yourself here, revert, record `rejected`, and run the gate honestly.

## The cap

After the receipt for cycle 8, stop even if the gate is not clean. Cycle 0 does not count toward the cap. A rejected attempt does. If the gate after cycle 8 is clean, the stop is ordinary and `capped: false`.

Certificate fields when the gate is not clean:

- `wraith: fail - capped`
- `capped: true`
- `still true:` starts with the ship-block or high defect you would have taken on cycle 9.
- Do not pretend the gate passed.

The cap exists so "until you can't" cannot be gamed into an infinite polish loop. It is a failure mode when it binds. Do not aim for it.
