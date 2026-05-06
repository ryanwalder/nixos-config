{ ... }: {
  flake.modules.homeManager.program_prusaslicer = { pkgs, ... }: {
    home.packages = [ pkgs.prusa-slicer ];
  };
}
