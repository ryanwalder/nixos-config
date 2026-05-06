{...}: {
  flake.modules.homeManager.program_slack = {pkgs, ...}: {
    home.packages = [pkgs.slack];
  };
}
