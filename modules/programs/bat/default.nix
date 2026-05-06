{...}: {
  flake.modules.homeManager.program_bat = {pkgs, ...}: {
    home.packages = with pkgs; [
      bat
    ];
  };
}
