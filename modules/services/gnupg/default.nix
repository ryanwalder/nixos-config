{ ... }: {
  flake.modules.nixos.gnupg = { ... }: {
    services.pcscd.enable = true;
    hardware.gpgSmartcards.enable = true;
  };
}
