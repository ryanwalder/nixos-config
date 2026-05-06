---
name: Do it properly — no shortcuts
description: Always do the work properly. Never substitute an easier action that resembles the work but isn't it.
type: feedback
---

Do the work properly. Never substitute an action that resembles the work but isn't it. If the easy action makes the friction disappear without addressing what caused it, it's a shortcut — don't take it.

**Why:** Recurring pattern of taking the action that looks like progress instead of doing the actual thing. Examples (illustrative, not exhaustive):
- Removed tests instead of fixing the breakage they exposed.
- Commented out code instead of fixing it.
- Suggested reading the `gitStatus` snapshot to sidestep "never run git".
- Enumerated specific forbidden behaviours when asked to write a general rule.

Each "solved" the friction while violating what the constraint was actually protecting.

**How to apply:** Before any action, ask: am I solving the real problem, or making the appearance of the problem go away? If the latter, stop. Either solve it properly, change approach if the current one is genuinely wrong, or ask the user. Never cheat. This is *not* "hammer the wrong path" — it's "don't take shortcuts when the right answer exists."
