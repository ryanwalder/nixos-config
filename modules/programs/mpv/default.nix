{ ... }: {
  flake.modules.homeManager.program_mpv = { lib, pkgs, config, ... }: {
    xdg.mimeApps.defaultApplications = {
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/quicktime" = "mpv.desktop";
      "video/x-msvideo" = "mpv.desktop";
      "video/mpeg" = "mpv.desktop";
      "video/x-flv" = "mpv.desktop";
      "video/3gpp" = "mpv.desktop";
      "video/x-ms-wmv" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      "application/x-matroska" = "mpv.desktop";
    };

    programs.mpv = {
      enable = true;

      config = {
        vo = "gpu";
        gpu-api = "opengl";
        hwdec-codecs = "all";
        cache-default = 600;
        demuxer-readahead-secs = 1800;
        cache = 2048;
        cache-seek-min = 2048;
        demuxer-max-bytes = "4GB";
        cache-pause = "no";
      };

      bindings = {
        WHEEL_UP    = "add volume 2";
        WHEEL_DOWN  = "add volume -2";
        WHEEL_LEFT  = "seek -10";
        WHEEL_RIGHT = "seek 10";
        "Alt+l"     = "cycle-values loop-playlist inf no";
      };
    };

    xsession.windowManager.i3.config.keybindings = lib.mkIf config.xsession.windowManager.i3.enable {
      "Mod4+Shift+m" = "exec ${pkgs.mpv}/bin/mpv --loop=inf --mute=yes --player-operation-mode=pseudo-gui --ytdl-raw-options=cookies-from-browser=firefox";
    };
  };
}
