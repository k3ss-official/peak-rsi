# Forbidden moves

These look like momentum. They are how a loop pretends to be recursive self-improvement while the work stays put, or gets worse in a way the score cannot see.

## Reward hacks

- Lowering an assertion, deleting a test, skipping a case, or snapshotting the buggy output.
- Narrowing the objective so a failed check falls outside it.
- Special-casing a demo input, a screenshot fixture, or the one example the user mentioned.
- Catching an error and returning success.
- Changing a type so the failing call is no longer type-checked, without handling the case.
- Editing this skill's severities mid-loop so a ship-block becomes taste.

Response: revert the edit. Receipt marks `rejected`. If an existing check caught the hack, name it in the harness line and add nothing. If no check would have caught it, add one that would. The reverted state is the start of the next cycle.

## Fake improvement

- Format, rename, comment, reorder imports, or swap a synonym, then counting a cycle.
- A new abstraction that does not close a named defect.
- Replacing a working approach with a preferred one (new library, new pattern, new file split) because it is cleaner.
- Adding settings, themes, or options nobody asked for so the diff looks substantial.
- "Hardening" unrelated paths while the named defect is still open.

Response: do not start the cycle. If you already edited, revert. The critic was wrong to select it, or you selected taste. Say so under `rejected`.

## Scope escape

- Reading a vague adjective as permission to redesign.
- Treating "while I'm here" as in-scope.
- Expanding non-goals downward ("you didn't say I couldn't add accounts").
- Asking five clarifying questions to avoid a decision the skill already told you to assume.

Response: return to cycle 0 rules. One question only on an expensive fork. Otherwise decide, log the assumption, continue.

## Performative RSI

- Announcing the framework, then shipping one ordinary edit and a certificate.
- Writing receipts for cycles you did not run.
- A critic pass with no location and no severity, then a stop.
- Stopping because the cap is near, while a ship-block is open, and marking `capped: false`.
- Continuing past a clean gate because the loop is enjoyable.

Response: the certificate is invalid. Run the missing critic or delete the fake cycles from the ledger by marking them `rejected: not actually run`, whichever matches reality. Do not quietly rewrite history.

## Self-grading

- Treating a green script you wrote as proof the mechanism is sound. It scores what a machine can score.
- Calling that script a cold audit of an artifact that needs judgement.
- Running every critic pass in one lens, then reporting that the critic found nothing.
- Leaving a claim the artifact depends on unread and untagged because it sounds right.

Response: name what the check cannot see in `residual`, run the pass again with a different lens or a cold sub-agent, and settle or tag the premise. The certificate's `critic:` line says who graded.

## Objective laundering

Any edit to the objective whose diff makes a current failure stop counting. The test is a sentence diff, not a vibe. If you cannot show the diff, you do not get to change the objective.
