{ ... }: {
  flake.modules.homeManager.program_opencode = { pkgs, ... }: {
    home.packages = [ pkgs.opencode ];
  };
}
