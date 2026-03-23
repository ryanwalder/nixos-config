{ config, lib, pkgs, ... }: {
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
