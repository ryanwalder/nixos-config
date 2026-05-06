{ ... }: {
  flake.modules.homeManager.program_gnome-keyring = { ... }: {
    services.gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };
  };

  flake.modules.nixos.program_gnome-keyring = { ... }: {
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
