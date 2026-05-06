{...}: {
  flake.modules.homeManager.theme_cursor-breeze = {pkgs, ...}: {
    home.pointerCursor = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
      size = 24;
    };
  };
}
