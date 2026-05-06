---
name: Confirm explicit success criteria directly
description: When success has an explicit observable criterion, confirm it directly — never infer from an adjacent signal
type: feedback
---

When a verification step has an explicit success criterion (a dialog appearing, a specific log line, a UI element rendering, an audible/visible event, etc.), confirm *that* directly. Don't substitute an adjacent signal (process exit, network 200, "no error in the log") and call it done.

**Why:** Pattern of declaring success based on a signal that's *correlated with* the criterion but doesn't actually verify it. Adjacent signals can succeed for unrelated reasons (cached state, fallback paths, silent failures), so they don't prove the criterion was met.

**How to apply:** When the success criterion is something the user can observe (a UI event, a dialog, a specific output), ask them directly: "Did X appear/happen?" before declaring the task complete. An adjacent signal is at most weak evidence — never proof.
