{...}: {
  flake.modules.homeManager.program_backup-home = {pkgs, ...}: let
    backup-home = pkgs.writeShellApplication {
      name = "backup-home";
      runtimeInputs = with pkgs; [coreutils procps rsync util-linux];
      text = builtins.readFile ./scripts/backup-home.sh;
    };
  in {
    home.packages = [backup-home];

    systemd.user.services.backup-home = {
      Unit.Description = "Backup home directory to /media/backups";
      Service = {
        Type = "oneshot";
        ExecStart = "${backup-home}/bin/backup-home";
      };
    };

    systemd.user.timers.backup-home = {
      Unit.Description = "Run home backup hourly";
      Timer = {
        OnCalendar = "hourly";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
