---
name: bash_scripts_standards
description: All bash scripts must use strict mode, pass shellcheck, and be formatted with shfmt
type: feedback
---

All bash scripts must:
1. Use a portable shebang: `#!/usr/bin/env bash` (not `#!/bin/bash`).
2. Use strict mode: `set -euo pipefail` at the top.
3. Pass shellcheck (proper quoting, handle potential empty/failed commands).
4. Be formatted with shfmt.
5. Never reference bash via `/nix/store/...` paths (e.g. `${pkgs.bash}/bin/bash` in a shebang). Let `env` resolve bash from `PATH`.

**Why:** User's standard for all shell scripts.

**How to apply:** Any time a bash script is created or modified — git helpers, launcher scripts, polybar scripts, hook scripts, anything.
