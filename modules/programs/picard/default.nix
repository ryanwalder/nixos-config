{...}: {
  flake.modules.homeManager.program_picard = {pkgs, ...}: {
    home.packages = with pkgs; [
      picard
    ];
  };
}
