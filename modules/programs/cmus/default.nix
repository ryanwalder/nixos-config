{...}: {
  flake.modules.homeManager.program_cmus = {pkgs, ...}: {
    home.packages = with pkgs; [
      cmus
    ];

    xdg.configFile."cmus/rc".text = ''
      cd /media/ftp/Music
      add /media/ftp/Music
      update-cache
      set format_treewin= %{?y?%y - }%l
      set play_library=true
      set aaa_mode=all
      set shuffle=albums
      set mpris=true
      set replaygain=smart
      set block_key_paste=true
      set buffer_seconds=300
      set follow=true
      set mouse=true
      set show_current_bitrate=true
      set resume=true
    '';

    systemd.user.services.cmus-update-cache = {
      Unit.Description = "Update cmus library cache";
      Service = {
        Type = "oneshot";
        ExecCondition = "${pkgs.cmus}/bin/cmus-remote -C status";
        ExecStart = "${pkgs.cmus}/bin/cmus-remote -C update-cache";
      };
    };

    systemd.user.timers.cmus-update-cache = {
      Unit.Description = "Periodically update cmus library cache";
      Timer = {
        OnUnitActiveSec = "1h";
        OnStartupSec = "5m";
      };
      Install.WantedBy = ["timers.target"];
    };

    xdg.desktopEntries.cmus = {
      name = "cmus";
      comment = "C* Music Player";
      exec = "${pkgs.kdePackages.konsole}/bin/konsole --name cmus --title cmus -e ${pkgs.cmus}/bin/cmus";
      terminal = false;
      type = "Application";
      icon = "multimedia-audio-player";
      categories = ["Audio" "Music" "Player"];
    };
  };
}
