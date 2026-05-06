{...}: {
  flake.modules.nixos.program_ssh = {...}: {
    services.openssh.enable = true;
  };
}
