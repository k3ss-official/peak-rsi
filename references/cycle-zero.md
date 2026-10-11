# Cycle 0 — sharpen the objective

No artifact edits in this cycle. The output is a contract the later critic can fail.

## Accept or rewrite

Accepted as given when all of these hold:

- A reviewer can point at a behavior, output, or invariant and say pass or fail.
- Non-goals are stated, or the change is so local that scope is obvious.
- You would notice if someone satisfied the words by doing a different project.

Otherwise rewrite. Do not "improve" a sharp ask into a grander one.

## The five lines

Write them in the receipt. Keep each line short enough to argue about.

**Outcome.** What a person or a test can observe when this is done. Not a feeling.

**Bar.** The checks that make the outcome true. Include the edges that are inside the outcome (empty, duplicate, failure, the narrow case), not edges from adjacent projects.

**Non-goals.** What this loop will not do even if it would be impressive. At minimum:

- No feature the outcome does not name.
- No new dependency unless a named defect cannot be closed without it.
- No drive-by refactor or restyle.
- No weakening of a test to make a cycle pass.

**Evidence.** How a later cycle proves a defect closed. Name the command, fixture, or trace. "I'll look at it" is not evidence.

**Assumptions.** Decisions you are making because the prompt left them open. Each one is a sentence a user could later reject. That is fine. Silent guesses are not.

## Vague language is an objective defect

These words do not survive cycle 0 as the bar: better, nicer, clean, cleaner, modern, robust, polished, intuitive, seamless, user-friendly, elegant, sleek, delightful, world-class, high-quality, production-ready (unless the bar says what production means here), scalable (unless a number or a limit is attached), simple (unless you say which complexity is removed).

Strip them. If nothing observable remains, you do not have an objective yet.

## The one-question exception

Ask only if both are true:

- Two different architectures would both satisfy a fair reading of the ask.
- Building the wrong one is expensive to reverse.

One question. Not a list. If you cannot get an answer (batch run, no user in the loop), pick the narrower architecture, log the assumption, and proceed. Narrower means less new surface, not a weaker bar.

## Objective edits after cycle 0

Later cycles may still file objective defects. Legal revisions:

- A check was unfalsifiable. Make it falsifiable.
- An edge is inside the stated outcome and was missing from the bar. Add it.
- A non-goal contradicts the outcome. Resolve it in favor of the outcome, and write the discarded reading into `rejected`.

Illegal revisions:

- Dropping a check the current artifact fails.
- Shrinking the outcome so the work already done qualifies.
- Adding a feature as a "clarification."

Diff the objective text every time it changes. If any obligation got easier, revert the revision and record a reward-hack rejection.
