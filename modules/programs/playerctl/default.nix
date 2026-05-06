{...}: {
  flake.modules.homeManager.program_playerctl = {pkgs, ...}: {
    home.packages = with pkgs; [
      playerctl
    ];
  };
}
