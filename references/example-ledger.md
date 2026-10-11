# Worked stop

Imitate the grain, not the domain. This is a receipts page whose Export button was ignoring the active filter.

The ask, already fairly sharp:

> Stop the receipts export from ignoring the active filter. Download only the filtered rows as CSV, with a header row, ISO dates, and a visible error if the download fails. Do not add Excel. Do not redesign the page.

## Cycle 0

objective: v1 -> v1
surface: objective
defect: none — accepted as given
evidence: outcome is falsifiable (filtered rows, header, ISO dates, visible failure). Non-goals name Excel and visual redesign.
rejected: none
harness: unchanged (seed H1–H8)
residual: assumption A1 — an empty filter means all rows, not an empty file. Assumption A2 — a few thousand rows in memory is enough; no streaming work.

Gate: continue. The artifact has not been attacked yet.

## Cycle 1

objective: v1 -> v1
surface: artifact
defect: rejected — test edited so the unfiltered export matched the snapshot
evidence: reverted. `export.spec` was changed from "one row when name filter is set" to "matches current dump". That makes the bug pass. H4 forbids it.
rejected: R1 snapshot the buggy output
harness: added H9 — a verification edit that becomes easier when the bug remains is itself a ship-block
residual: D1 still open. Export calls `exportCsv(store.rows)` while the table renders `filtered`.

Gate: continue. Attempt counted. Artifact unchanged.

## Cycle 2

objective: v1 -> v1
surface: artifact
defect: D1 (ship-block) — export serializes the full store, not the filtered view
evidence: fixture with 4 receipts, filter text `ada`, file has the header plus 1 data row. Before the edit the same fixture wrote 4 data rows. Command: the export unit fixture in `export.spec`.
rejected: passing the filter predicate into the CSV writer instead of the rows (extra API, not required)
harness: unchanged
residual: D2 dates emit `Date.toString()` (`Mon Oct 11 2026 ... GMT`), which fails the ISO obligation already in v1

Gate: continue. One high defect remains.

## Cycle 3

objective: v1 -> v1
surface: artifact
defect: D2 (high) — date cells are locale strings, so a receipt cannot be reconciled
evidence: same fixture, the date cell is `2026-10-11`. The assertion is on the cell, not on "file is non-empty".
rejected: locale-formatted dates (easier to read, fails the bar); pulling in a date library (non-goal on dependencies)
harness: unchanged
residual: none at ship-block or high. Candidate for later: button label still says Export.

Gate: go to stop gate.

## Stop gate

1. Critic pass after cycle 3: no ship-block, no high. Tried an empty filter (all rows, header present — matches A1), a failed blob create (error text is shown, no false "downloaded"), duplicate ids in the filter (both rows kept, no corruption).
2. Next candidate: change the button label from Export to Download CSV. Class: taste. The bar specifies the file, not the label. Non-goal forbids a page redesign, and copy is design.
3. Objective text is byte-identical to v1. `export.spec` assertions got stricter, not looser.
4. Cycle 3 evidence is the ISO cell in the fixture output.
5. Second read: a reviewer shipping against v1 would not hold the label. They would hold a wrong row set or a non-ISO date. Both are closed.

## Certificate

```
PEAK
objective (final): v1 accepted as given. A1 empty filter exports all rows. A2 in-memory under a few thousand rows.
cycles: 4 considered, 1 rejected, 2 artifact edits
closed: D1 filtered rows, D2 ISO-8601 date cells
rejected on purpose: R1 test rewritten to match the unfiltered dump
still true: button label says Export; no Excel; no streaming export
why another cycle won't pay: the only named leftover is button copy, which v1 does not score and the non-goals keep off the page
capped: false
```

That is a stop. Adding the label, an Excel path, or a streaming writer after this certificate would be a forbidden cycle.
