# Worked stop

Imitate the grain, not the domain. This is a receipts page whose Export button was ignoring the active filter.

The initial ask (v0, unsharpened):

> Make the receipts export work properly and clean up the file download so it's ready to ship. Don't add Excel or redesign the page.

## Cycle 0

objective: v0 -> v1
surface: objective
lens: n/a
defect: D0 (high) — objective unfalsifiable: "work properly" and "clean up" are vague
evidence: rewritten into falsifiable contract:
- Outcome: download only filtered rows as CSV, header row present, ISO-8601 date cells, visible error on failure.
- Bar: checkable against unit fixtures and simulated download failure.
- Non-goals: no Excel export, no visual redesign of the page.
- Assumptions: A1 empty filter means all rows, not an empty file. A2 in-memory export under 10,000 rows.
rejected: none
harness: unchanged (seed H1–H10)
residual: artifact unverified against v1 bar; anchor 7b1e2a0 recorded before any edit

Gate: continue. The artifact has not been attacked against the v1 bar yet.

## Cycle 1

objective: v1 -> v1
surface: artifact
lens: reality
defect: D1 (ship-block) — export serializes the full in-memory store instead of active filtered dataset
evidence: unit fixture in `export.spec.ts` with 4 receipts, filter text `ada`, file has header plus 1 data row. Before edit, fixture wrote 4 data rows. H9 regression check: pass (no prior closed defect to regress).
rejected: passing filter predicate directly into CSV writer (pollutes serializer API with UI concerns)
harness: unchanged
residual: D2 dates emit `Date.toString()` (`Mon Oct 11 2026 ... GMT`), failing ISO-8601 requirement in v1

Gate: continue. One high defect remains.

## Cycle 2

objective: v1 -> v1
surface: artifact
lens: verdict
defect: rejected — loosened test assertion regex in export.spec.ts to match locale date dump instead of fixing serializer
evidence: reverted to a4f91c2 (clean tree verified). Tree was clean at the anchor (`stash: none`), so a full-tree restore was legal. Loosening assertion regex allowed `Mon Oct 11 2026` to pass without fixing the date serializer, violating H4 and H6. Atomic rollback executed (`git reset --hard HEAD && git clean -fd`). `git status --porcelain` verified clean.
rejected: R1 snapshot or accept the buggy output
harness: added H11: Test edits must never widen assertions to match buggy output
residual: D2 still open: date serializer emits locale strings

Gate: continue. Attempt counted toward cap. Tree restored cleanly to anchor a4f91c2.

## Cycle 3

objective: v1 -> v1
surface: artifact
lens: attacker
defect: D2 (high) — date cells are locale strings, so a receipt cannot be reconciled
evidence: `export.spec.ts` fixture confirms date cell outputs `2026-10-11`; H9 regression lock: pass — re-ran D1 fixture confirming 1 filtered row + header output remains intact. This cycle's critic pass was run by a cold sub-agent.
rejected: locale-formatted dates (easier to read, fails bar); importing external date library (violates non-goal on dependencies)
harness: unchanged
residual: none at ship-block or high. Candidate for later: button label still says Export.

Gate: go to stop gate.

## Stop gate

1. **Nothing sharp left:** Critic pass after cycle 3, lens `verdict`: zero ship-block, zero high. The filtered-rows fixture and the ISO-date assertion both fail against the cycle-0 code, so they can reject a wrong export; neither asserts anything the page cannot do. Tested empty filter (all rows + header — matches A1), failed blob create (visible error text shown, no false success banner), duplicate IDs in filter (both rows preserved, no state corruption).
2. **Next candidate named and declined:** Change button label from "Export" to "Download CSV". Class: taste. The bar specifies the CSV contents, not the button copy. Non-goals forbid page redesign.
3. **The bar did not move down:** Objective text is byte-identical to v1. Harness enforces H1–H11.
4. **The last close was verified with H9 cumulative verification:** Cycle 3 verified ISO cell in fixture output; H9 cumulative regression confirmed D1 filtered dataset serialization remains passing.
5. **Wraith zero-trust gate:** Cold verifier sub-agent spawned with zero cycle history (given only final Objective v1, active Harness H1-H11, and final diff). Cold audit mapped all Bar requirements (filtered rows, header, ISO dates, error banner) to raw test outputs, verified all passed, and confirmed that another cycle would not change a competent ship decision.

## Certificate

```
PEAK
objective (final): v1 — receipts export downloads only filtered rows as CSV with header row, ISO-8601 dates, visible error toast; A1 empty filter exports all rows; A2 in-memory under 10k rows
cycles: 3 considered, 1 rejected, 2 artifact edits
closed: D1 filtered rows export, D2 ISO-8601 date formatting
rejected on purpose: R1 test assertion loosened to match locale date dump
still true: button label says Export; no Excel export; in-memory export under 10k rows
why another cycle won't pay: the only named leftover is button copy, which v1 does not score and non-goals keep off the page
wraith: pass - cold audit verified Bar items and H1-H11 against final diff
critic: author x2, cold x2 (cycle 3, gate)
capped: false
```

That is a stop. Adding the label, an Excel path, or a streaming writer after this certificate would be a forbidden cycle.
