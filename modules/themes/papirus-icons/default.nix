{...}: {
  flake.modules.homeManager.theme_icon-papirus = {pkgs, ...}: {
    home.packages = with pkgs; [
      papirus-icon-theme
    ];

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
