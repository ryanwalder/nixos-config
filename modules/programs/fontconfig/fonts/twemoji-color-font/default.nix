{...}: {
  flake.modules.homeManager.fonts_twemoji = {pkgs, ...}: {
    home.packages = with pkgs; [
      twemoji-color-font
    ];
  };
}
