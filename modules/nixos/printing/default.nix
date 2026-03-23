{ config, lib, pkgs, ... }: {
  services.printing = {
    enable = true;
    browsing = true;
    webInterface = true;
    listenAddresses = [ "localhost:631" ];
    allowFrom = [ "localhost" ];
  };
}
