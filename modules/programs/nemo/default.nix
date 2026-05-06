{...}: {
  flake.modules.nixos.program_nemo = {pkgs, ...}: {
    programs.dconf.enable = true;
    services.gvfs.enable = true;

    environment.pathsToLink = ["share/thumbnailers"];

    environment.systemPackages = with pkgs; [
      # image thumbnails
      gdk-pixbuf
      webp-pixbuf-loader
      libheif.bin
      libheif.out
      libavif
      libjxl

      # video thumbnails
      ffmpeg-headless
      ffmpegthumbnailer
    ];
  };

  flake.modules.homeManager.program_nemo = {pkgs, ...}: {
    home.packages = with pkgs; [
      nemo
    ];

    dconf.settings = {
      "org/nemo/icon-view" = {
        captions = ["none" "none" "none"];
        labels-beside-icons = false;
      };
      "org/nemo/list-view" = {
        enable-folder-expansion = true;
      };
      "org/nemo/preferences" = {
        confirm-move-to-trash = false;
        confirm-trash = false;
        date-font-choice = "system-mono";
        date-format = "iso";
        default-folder-viewer = "compact-view";
        inherit-folder-viewer = true;
        quick-renames-with-pause-in-between = true;
        show-advanced-permissions = false;
        show-directory-item-counts = "always";
        show-hidden-files = true;
        show-image-thumbnails = "always";
        show-location-entry = true;
        swap-trash-delete = true;
      };
      "org/nemo/preferences/menu-config" = {
        selection-menu-move-to-trash = false;
        selection-menu-open-in-terminal = true;
      };
      "org/nemo/search" = {
        search-reverse-sort = false;
        search-sort-column = "name";
      };
      "org/nemo/window-state" = {
        side-pane-view = "tree";
        start-with-sidebar = true;
      };
      "org/cinnamon/desktop/default-applications/terminal" = {
        exec = "konsole";
      };
    };

    systemd.user.services.thumbnail-cleanup = {
      Unit.Description = "Remove thumbnails older than 24 hours";
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.findutils}/bin/find %h/.cache/thumbnails -type f -mmin +1440 -delete";
      };
    };

    systemd.user.timers.thumbnail-cleanup = {
      Unit.Description = "Thumbnail cleanup every 30 minutes";
      Timer = {
        OnCalendar = "*:0/30";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
