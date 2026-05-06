{...}: {
  flake.modules.homeManager.program_krita = {pkgs, ...}: {
    home.packages = [pkgs.krita];
  };
}
