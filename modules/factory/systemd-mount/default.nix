{ lib, ... }: {
  config.flake.factory.systemd-mount = { what, where, type, options ? null, idleTimeout ? "600" }: let
    defaultOptions = if type == "nfs" then "nofail,_netdev" else "nofail";
    finalOptions = if options != null then options else defaultOptions;
  in {
    systemd.mounts = [{
      inherit what where type;
      options = finalOptions;
      mountConfig.TimeoutSec = "30s";
      wantedBy = [ "multi-user.target" ];
    }];
    systemd.automounts = [{
      inherit where;
      automountConfig.TimeoutIdleSec = idleTimeout;
      wantedBy = [ "multi-user.target" ];
    }];
  };
}
