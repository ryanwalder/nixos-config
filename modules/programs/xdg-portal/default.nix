{...}: {
  flake.modules.nixos.program_xdg-portal = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = ["gtk"];
      xdgOpenUsePortal = true;
    };

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
    };
  };
}
