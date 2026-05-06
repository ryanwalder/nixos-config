{ ... }: {
  flake.modules.homeManager.program_okular = { pkgs, ... }: {
    home.packages = [ pkgs.kdePackages.okular ];
  };
}
