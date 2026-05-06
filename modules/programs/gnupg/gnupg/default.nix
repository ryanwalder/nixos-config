{ ... }: {
  flake.modules.nixos.program_gnupg = { ... }: {
    services.pcscd.enable = true;
    hardware.gpgSmartcards.enable = true;
  };
}
