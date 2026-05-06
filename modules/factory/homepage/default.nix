{lib, ...}: {
  config.flake.factory.homepage = {
    settingsYAML ? "",
    services ? [],
    widgets ? [],
    bookmarks ? [],
    customCSS ? "",
    customJS ? "",
    environmentFiles ? [],
  }: {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 3000;
      inherit services widgets bookmarks customCSS customJS environmentFiles;
    };

    environment.etc."homepage-dashboard/settings.yaml" = lib.mkIf (settingsYAML != "") {
      text = lib.mkForce settingsYAML;
    };
  };
}
