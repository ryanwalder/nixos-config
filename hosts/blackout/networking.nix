{ ... }: {
  networking.hostName = "blackout";
  networking.useDHCP = false;
  networking.useNetworkd = true;

  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "enp6s0";
      networkConfig.DHCP = "ipv4";
      linkConfig.RequiredForOnline = "routable";
    };
  };

  programs.mtr.enable = true;
}
