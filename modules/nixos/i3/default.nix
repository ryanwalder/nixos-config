{ config, lib, pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.xkb.layout = "gb";
}
