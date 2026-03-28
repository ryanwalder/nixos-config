{...}: {
  config.flake.factory.dhcp-interface = {
    priority ? "10",
    interface,
  }: {
    networking.useDHCP = false;
    networking.useNetworkd = true;
    systemd.network = {
      enable = true;
      networks."${priority}-lan" = {
        matchConfig.Name = interface;
        networkConfig.DHCP = "ipv4";
        linkConfig.RequiredForOnline = "routable";
      };
    };
  };
}
