{...}: {
  flake.modules.homeManager.program_ark = {pkgs, ...}: {
    home.packages = [pkgs.kdePackages.ark];
  };
}
