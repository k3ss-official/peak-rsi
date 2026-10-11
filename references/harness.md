# Harness

The harness is the list of checks that decide whether an edit is real. It starts as the seed below. It is allowed to change. It is not allowed to soften in response to a failure.

## Seed

Keep these until a receipt removes one by id.

- **H1 Primary path.** The outcome's main behavior works end to end, not only the success message around it.
- **H2 Edges inside the outcome.** Empty, duplicate, huge, and wrong inputs do not corrupt state. They fail where they should fail, visibly.
- **H3 Failures are visible.** No empty catch, no `catch { return true }`, no UI that says it worked when it did not.
- **H4 Evidence is about the defect.** The verification would have failed on the previous version. A test rewritten to match the bug is not evidence.
- **H5 Scope.** The edit did not ship a feature, dependency, or restyle the non-goals forbade.
- **H6 Objective still binds.** After the edit, the outcome sentence is still true and no obligation got easier.
- **H7 Security on the path you touched.** No new injection, no secret moved to the client, no check removed to make a request easier. Skip the sermon for paths the objective does not touch. Do not skip it for paths it does.
- **H8 Narrow surface, if the deliverable is UI.** The primary path is usable near 390px wide. This check is inert for a CLI, a library, or a doc.

## How a check is born

In the harness-delta line, add one check only when one of these happened:

- The same defect class showed up in two cycles (including a rejected attempt).
- A ship-block slipped past verify and was caught only on a later critic pass.
- You noticed a check you do not have that would have made the last bug obvious.

Write the check as something that can be failed, not a value ("be careful with dates"). Good: "Date cells in exported CSV are ISO-8601, not `Date.toString()`."

## How a check dies

Remove or narrow a check when it caused an edit the critic rejected as out of scope or taste, and it has not caught a real defect. Say so in the receipt. Do not remove a seed check because it is annoying. H4 in particular is not optional.

## What the harness must not become

- A style guide.
- A second copy of the objective, looser than the first.
- A growing list nobody runs. If you add a check, the next verify uses it or the add was fake. Remove fake adds on the following cycle.
