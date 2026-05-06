{...}: {
  flake.modules.homeManager.program_bc = {pkgs, ...}: {
    home.packages = with pkgs; [
      bc
    ];
  };
}
