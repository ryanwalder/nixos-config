{...}: {
  flake.modules.homeManager.fonts_font-awesome = {pkgs, ...}: {
    home.packages = with pkgs; [
      font-awesome_6
    ];
  };
}
