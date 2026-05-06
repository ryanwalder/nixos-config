{...}: {
  flake.modules.homeManager.program_wget = {pkgs, ...}: {
    home.packages = with pkgs; [
      wget
    ];
  };
}
