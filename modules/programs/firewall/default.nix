{...}: {
  flake.modules.nixos.program_firewall = {...}: {
    networking.firewall.enable = true;
  };
}
