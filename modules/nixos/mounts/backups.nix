{ ... }: {
  boot.supportedFilesystems = [ "nfs" ];
  systemd.mounts = [{
    what = "nas.tfu.ac:/media/backups";
    where = "/media/backups";
    type = "nfs";
    options = "nofail";
    wantedBy = [ "multi-user.target" ];
  }];

  systemd.automounts = [{
    where = "/media/backups";
    automountConfig.TimeoutIdleSec = "600";
    wantedBy = [ "multi-user.target" ];
  }];
}
