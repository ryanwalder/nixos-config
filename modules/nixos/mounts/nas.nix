{ ... }: {
  boot.supportedFilesystems = [ "nfs" ];
  systemd.mounts = [
    {
      what = "nas.tfu.ac:/media/ryan";
      where = "/media/ryan";
      type = "nfs";
      options = "nofail";
      wantedBy = [ "multi-user.target" ];
    }
    {
      what = "nas.tfu.ac:/media/ftp";
      where = "/media/ftp";
      type = "nfs";
      options = "nofail";
      wantedBy = [ "multi-user.target" ];
    }
  ];

  systemd.automounts = [
    {
      where = "/media/ryan";
      automountConfig.TimeoutIdleSec = "600";
      wantedBy = [ "multi-user.target" ];
    }
    {
      where = "/media/ftp";
      automountConfig.TimeoutIdleSec = "600";
      wantedBy = [ "multi-user.target" ];
    }
  ];
}
