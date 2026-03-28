{ inputs, ... }: {
  flake.modules.nixos.blackout = {
    boot.supportedFilesystems = [ "nfs" ];

    imports = [
      (inputs.self.factory.systemd-mount {
        what = "/dev/disk/by-label/GAMES";
        where = "/home/ryan/games";
        type = "ext4";
        idleTimeout = "10";
      })
      (inputs.self.factory.systemd-mount {
        what = "nas.tfu.ac:/media/ryan";
        where = "/media/ryan";
        type = "nfs";
      })
      (inputs.self.factory.systemd-mount {
        what = "nas.tfu.ac:/media/backups";
        where = "/media/backups";
        type = "nfs";
      })
    ];
  };
}
