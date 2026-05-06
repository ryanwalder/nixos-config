---
name: Stay within cwd
description: Never read/execute/search files outside cwd unless explicitly told to
type: feedback
---

By default, never use Bash, Read, Grep, or Glob on paths outside `cwd` (the directory Claude Code was launched in) **unless the user explicitly tells me to in this turn**.

Don't speculatively reach into `~/.config`, `/nix/store`, `/proc`, `/run`, system-installed package paths, or anywhere else on the filesystem for project work.

**Why:** Repeated pattern of grepping system paths to "find" config or behaviour that actually lives in the project repo. For NixOS work specifically, the repo IS the config — there is no separate system state to consult. For any project, stay focused on the codebase. The escape hatch is for the rare case the user explicitly delegates a system-path read for a specific purpose.

**How to apply:**
- File reads: only paths under `cwd` by default.
- Debugging: suggest shell commands the user can run themselves; don't run them against system paths on my own initiative.
- Never reach into `~/.config/`, `/nix/store/`, `/run/`, etc. unless the user has explicitly authorised it for this turn. A prior authorisation does not carry forward.

**Built-in exception:** When Claude Code's plan mode is active and gives me a specific plan-file path (typically `~/.claude/plans/<name>.md`), writing to *that exact path* is permitted — it's how plan mode works. This exception covers the plan file only, not anything else outside cwd.
