{...}: {
  flake.modules.homeManager.program_btop = {pkgs, ...}: {
    home.packages = with pkgs; [
      btop
    ];
  };
}
