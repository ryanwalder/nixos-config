{ ... }: {
  flake.modules.homeManager.program_gnupg = { pkgs, ... }: {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gtk2;
    };
  };
}
