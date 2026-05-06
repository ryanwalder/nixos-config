# NixOS Config

My config for NixOS.

## Secrets Management

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix). Encrypted secrets live in the repo and are decrypted at activation time using host SSH keys.

### Structure

```
secrets/
  common.yaml          # shared across all hosts
  host/<name>.yaml     # per-host secrets (only that host can decrypt)
  role/<role>.yaml     # per-role secrets
```

### Key Files

- `.sops-keys.yaml` — source of truth for key management. Contains:
  - **hosts** — map hostnames to age public keys (derived from SSH host keys)
  - **scopes** — controls which hosts can decrypt which secret files
- `.sops.yaml` — generated from `.sops-keys.yaml` by `just sops update`. Do not edit directly.

### Key Management

```sh
just sops add <hostname> [scope ...]   # register host key, optionally add to scopes
just sops remove <hostname>            # remove host from all scopes
just sops edit <file>                  # decrypt/edit/re-encrypt a secrets file
just sops update                       # regenerate .sops.yaml and re-encrypt all secrets
```

Scopes use dot notation matching the nested YAML structure:
- `common` — `scopes.common`
- `role.workstation` — `scopes.role.workstation`

### Adding a New Host

1. Boot the host and ensure it has an ed25519 SSH host key
2. Run `just sops add <hostname> common` on that host
3. Add to role scopes if needed: edit `.sops-keys.yaml`, then run `just sops update`
