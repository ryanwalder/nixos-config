{...}: {
  flake.modules.homeManager.program_just = {pkgs, ...}: {
    home.packages = with pkgs; [
      just
    ];
  };
}
