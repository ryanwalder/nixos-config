---
name: Avoid wasted research motion
description: Don't spin up multiple agents or hunt through external sources for tasks the file in front of you can answer
type: feedback
---

For small, targeted extensions of recent work, read the file you just touched and reason directly. Don't spin up 4+ explore/plan agents or hunt through external sources when the answer is in the file in front of you.

**Why:** When asked to "do the same for all language servers" after fixing eslint's nodePath, the right move was to read the file and reason about which servers needed the same treatment — not launch multiple agents.

**How to apply:** This is about avoiding *wasted* motion, NOT about skipping verification. **Correctness over speed:** if the answer truly isn't in the file or knowable from existing context, research it properly (see feedback_verify_claims). For nixvim-specific questions, use the docs at https://nix-community.github.io/nixvim.
