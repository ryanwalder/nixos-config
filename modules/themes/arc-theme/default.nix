{...}: {
  flake.modules.homeManager.theme_app-arc = {
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      arc-theme
      arc-kde-theme
      kdePackages.qtstyleplugin-kvantum
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };
      gtk4.theme = config.gtk.theme;
    };

    qt = {
      enable = true;
      style = {
        name = "kvantum";
        package = pkgs.kdePackages.qtstyleplugin-kvantum;
      };
    };

    xdg.configFile."Kvantum/ArcDark".source = pkgs.runCommand "arc-kde-theme-opaque" {} ''
      cp -r ${pkgs.arc-kde-theme}/share/Kvantum/ArcDark $out
      chmod -R u+w $out
      substituteInPlace $out/ArcDark.kvconfig \
        --replace-fail 'translucent_windows=true' 'translucent_windows=false' \
        --replace-fail 'reduce_window_opacity=10' 'reduce_window_opacity=0' \
        --replace-fail 'blur_translucent=true' 'blur_translucent=false'
    '';

    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=ArcDark
    '';
  };
}
