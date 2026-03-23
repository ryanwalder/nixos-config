{ ... }: {
  # Required for gpg-agent scdaemon to communicate with Yubikey
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;
}
