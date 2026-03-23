{ config, ... }: {
  imports = [
    ../../modules/nixos/mounts/backups.nix
  ];

  systemd.mounts = [{
    what = "/dev/disk/by-label/GAMES";
    where = "/home/ryan/games";
    type = "ext4";
    options = "nofail";
    wantedBy = [ "multi-user.target" ];
  }];

  systemd.automounts = [{
    where = "/home/ryan/games";
    automountConfig.TimeoutIdleSec = "10";
    wantedBy = [ "multi-user.target" ];
  }];
}
