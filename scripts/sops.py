#!/usr/bin/env python3
"""Manage sops secrets: add/remove hosts, edit secrets, update encryption."""

import argparse
import os
import subprocess
import sys
from pathlib import Path

import yaml  # type: ignore[import-untyped]

SSH_PUBKEY = Path("/etc/ssh/ssh_host_ed25519_key.pub")
SSH_PRIVKEY = Path("/etc/ssh/ssh_host_ed25519_key")

REPO_ROOT: Path
KEYS_FILE: Path
SOPS_FILE: Path
SECRETS_DIR: Path


def load_keys() -> dict:
    return yaml.safe_load(KEYS_FILE.read_text())


def save_keys(data: dict) -> None:
    KEYS_FILE.write_text(yaml.dump(data, default_flow_style=False, sort_keys=False))


def make_rule(path: str, keys: list[str]) -> dict:
    return {
        "path_regex": rf"^secrets/{path}\.yaml$",
        "key_groups": [{"age": keys}],
    }


def generate(keys: dict) -> None:
    hosts = keys.get("hosts", {})
    scopes = keys.get("scopes", {})
    rules = []

    common_refs = scopes.get("common", [])
    if common_refs:
        rules.append(make_rule("common", [hosts[r] for r in common_refs]))

    for name, key in hosts.items():
        rules.append(make_rule(f"host/{name}", [key]))

    for role, refs in scopes.get("role", {}).items():
        if refs:
            rules.append(make_rule(f"role/{role}", [hosts[r] for r in refs]))

    SOPS_FILE.write_text(yaml.dump({"creation_rules": rules}, default_flow_style=False, sort_keys=False))
    print(f"Generated {SOPS_FILE}")


def get_age_key() -> str:
    return subprocess.check_output(
        ["sudo", "ssh-to-age", "-private-key", "-i", str(SSH_PRIVKEY)],
        text=True,
    ).strip()


def cmd_add(args: argparse.Namespace) -> None:
    if not SSH_PUBKEY.exists():
        print(f"Error: {SSH_PUBKEY} not found", file=sys.stderr)
        sys.exit(1)

    age_key = subprocess.check_output(
        ["ssh-to-age", "-i", str(SSH_PUBKEY)], text=True
    ).strip()
    print(f"Registered host '{args.hostname}' with age key: {age_key}")

    keys = load_keys()
    keys.setdefault("hosts", {})[args.hostname] = age_key

    if not args.scopes:
        save_keys(keys)
        print(f"No scopes specified. Add {args.hostname} to scopes in {KEYS_FILE}, then run: just sops update")
        return

    for scope in args.scopes:
        parts = scope.split(".")
        node = keys.setdefault("scopes", {})
        for part in parts[:-1]:
            node = node.setdefault(part, {})
        node.setdefault(parts[-1], [])
        if args.hostname not in node[parts[-1]]:
            node[parts[-1]].append(args.hostname)
        print(f"Added {args.hostname} to scope '{scope}'")

    save_keys(keys)
    cmd_update(args)


def cmd_remove(args: argparse.Namespace) -> None:
    keys = load_keys()

    if args.hostname not in keys.get("hosts", {}):
        print(f"Error: host '{args.hostname}' not found", file=sys.stderr)
        sys.exit(1)

    del keys["hosts"][args.hostname]

    scopes = keys.get("scopes", {})
    if args.hostname in scopes.get("common", []):
        scopes["common"].remove(args.hostname)
    for role_refs in scopes.get("role", {}).values():
        if args.hostname in role_refs:
            role_refs.remove(args.hostname)

    save_keys(keys)
    print(f"Removed host '{args.hostname}'")
    cmd_update(args)


def cmd_edit(args: argparse.Namespace) -> None:
    os.environ["SOPS_AGE_KEY"] = get_age_key()
    sys.exit(subprocess.call(["sops", str(SECRETS_DIR / f"{args.file}.yaml")]))


def cmd_update(args: argparse.Namespace) -> None:
    keys = load_keys()
    generate(keys)

    os.environ["SOPS_AGE_KEY"] = get_age_key()
    for f in sorted(SECRETS_DIR.rglob("*.yaml")):
        print(f"Rekeying: {f}")
        subprocess.check_call(["sops", "updatekeys", "-y", str(f)])
    print("Done.")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Manage sops secrets")
    parser.add_argument("repo_root", type=Path, help="Repository root directory")
    sub = parser.add_subparsers(dest="command", required=True)

    p_add = sub.add_parser("add", help="Register host's SSH key and optionally add to scopes")
    p_add.add_argument("hostname", help="Hostname to register")
    p_add.add_argument("scopes", nargs="*", help="Scopes to add the host to (e.g. common role.home)")
    p_add.set_defaults(func=cmd_add)

    p_remove = sub.add_parser("remove", help="Remove a host key from all scopes")
    p_remove.add_argument("hostname", help="Hostname to remove")
    p_remove.set_defaults(func=cmd_remove)

    p_edit = sub.add_parser("edit", help="Edit a secrets file")
    p_edit.add_argument("file", help="Secrets file path relative to secrets/ (without .yaml)")
    p_edit.set_defaults(func=cmd_edit)

    p_update = sub.add_parser("update", help="Regenerate .sops.yaml and re-encrypt all secrets")
    p_update.set_defaults(func=cmd_update)

    return parser


def init_paths(repo_root: Path) -> None:
    global REPO_ROOT, KEYS_FILE, SOPS_FILE, SECRETS_DIR
    REPO_ROOT = repo_root
    KEYS_FILE = REPO_ROOT / ".sops-keys.yaml"
    SOPS_FILE = REPO_ROOT / ".sops.yaml"
    SECRETS_DIR = REPO_ROOT / "secrets"


def main() -> None:
    args = build_parser().parse_args()
    init_paths(args.repo_root)
    args.func(args)


if __name__ == "__main__":
    main()
