{...}: {
  flake.modules.homeManager.program_inkscape = {pkgs, ...}: {
    home.packages = [pkgs.inkscape];
  };
}
