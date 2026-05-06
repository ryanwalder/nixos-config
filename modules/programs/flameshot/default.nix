{inputs, ...}: {
  flake.modules.homeManager.program_flameshot = {
    lib,
    pkgs,
    config,
    ...
  }: let
    flameshot = inputs.nixpkgs-flameshot13.legacyPackages.${pkgs.stdenv.hostPlatform.system}.flameshot;
  in {
    services.flameshot = {
      enable = true;
      package = flameshot;
      settings.General = {
        autoCloseIdleDaemon = true;
        contrastOpacity = 188;
        disabledTrayIcon = true;
        drawColor = "#c0c0c0";
        predefinedColorPaletteLarge = true;
        savePath = "${config.home.homeDirectory}/downloads/screenshots";
        showAbortNotification = false;
        showDesktopNotification = false;
        showHelp = false;
        showMagnifier = false;
        showStartupLaunchMessage = false;
        squareMagnifier = true;
      };
    };

    xsession.windowManager.i3.config.keybindings = lib.mkIf config.xsession.windowManager.i3.enable {
      "Print" = "exec ${flameshot}/bin/flameshot full -c";
      "Mod4+Print" = "exec ${flameshot}/bin/flameshot gui";
    };
  };
}
