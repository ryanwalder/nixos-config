---
name: User runs git/build/switch commands
description: Never run git, just, nixos-rebuild, or sudo nixos-rebuild unless explicitly told to — the user runs all of these themselves
type: feedback
---

Never run `git` (any subcommand — status, diff, add, commit, push, log, anything), `just`, `nixos-rebuild`, or `sudo nixos-rebuild` **unless the user explicitly tells me to in this turn**. The user runs all builds, switches, and git operations themselves.

**Why:** User wants full control over when builds, system changes, and git history modifications happen. Stated as a hard rule, but with an explicit override for the rare case the user delegates a specific command.

**How to apply:** After making file changes, tell the user what to run. If I need git state, ask the user to share the relevant output — do not look for backdoor workarounds. Only invoke these commands when the user has explicitly authorised it for this turn (e.g. "go ahead and run git status"). A prior authorisation does not carry forward to later turns.
