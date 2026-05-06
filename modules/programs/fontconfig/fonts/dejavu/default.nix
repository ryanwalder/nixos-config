{...}: {
  flake.modules.homeManager.fonts_dejavu = {pkgs, ...}: {
    home.packages = with pkgs; [
      dejavu_fonts
    ];
  };
}
