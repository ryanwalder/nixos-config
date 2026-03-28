{ ... }: {
  config.flake.factory.systemd-mount = { what, where, type, options ? "nofail", idleTimeout ? "600" }: {
    systemd.mounts = [{
      inherit what where type options;
      wantedBy = [ "multi-user.target" ];
    }];
    systemd.automounts = [{
      inherit where;
      automountConfig.TimeoutIdleSec = idleTimeout;
      wantedBy = [ "multi-user.target" ];
    }];
  };
}
