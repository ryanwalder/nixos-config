{...}: {
  flake.modules.homeManager.program_htop = {pkgs, ...}: {
    home.packages = with pkgs; [
      htop
    ];
  };
}
