{ config, ... }: {
  swapDevices = [
    {
      device = "/var/lib/swap";
      size = 64 * 1024;
      randomEncryption.enable = true;
    }
  ];
}
