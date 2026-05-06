{...}: {
  flake.modules.homeManager.program_rofi = {pkgs, ...}: {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      theme = "Arc-Dark";
    };
  };
}
