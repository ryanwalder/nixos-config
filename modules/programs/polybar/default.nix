{ ... }: {
  flake.modules.homeManager.program_polybar = { lib, pkgs, config, ... }:
  let
    cfg = config.modules.home.polybar;
    icon = glyph: "%{T2}${builtins.fromJSON glyph}%{T-}";
    i = {
      cpu    = icon ''"\uF2DB"'';
      memory = icon ''"\uF538"'';
      disk   = icon ''"\uF0A0"'';
      net    = icon ''"\uF796"'';
      vol0   = icon ''"\uF026"'';
      vol1   = icon ''"\uF027"'';
      vol2   = icon ''"\uF028"'';
      mute   = icon ''"\uF6A9"'';
    };
    togglePavucontrol = pkgs.writeShellScript "polybar-toggle-pavucontrol" ''
      pkill pavucontrol || pavucontrol &
    '';
    toggleBtop = pkgs.writeShellScript "polybar-toggle-btop" ''
      pid=$(pgrep -f polybar-btop)
      if [ -n "$pid" ]; then
        kill -9 $pid
      else
        ${pkgs.gnome-terminal}/bin/gnome-terminal --class=polybar-btop -- ${pkgs.btop}/bin/btop &
      fi
    '';
    launchPolybar = pkgs.writeShellScriptBin "polybar-launch" ''
      exec 9>/run/user/$(id -u)/polybar-launch.lock
      flock -n 9 || exit 0

      pkill -x polybar || true
      while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

      primary=$(xrandr | awk '/ connected primary/{print $1}')
      all=$(xrandr | awk '/ connected/{print $1}')

      for mon in $all; do
        if [ "$mon" = "$primary" ]; then
          MONITOR=$mon polybar primary 2>&1 | logger -t polybar &
        else
          MONITOR=$mon polybar secondary 2>&1 | logger -t polybar &
        fi
      done
    '';
  in {
    options.modules.home.polybar = {
      networkInterface = lib.mkOption {
        type = lib.types.str;
        default = "enp6s0";
        description = "Network interface to display in the polybar network module.";
      };
    };

    config = {
      services.polybar = {
        enable = true;
        package = pkgs.polybar.override {
          i3Support = true;
          pulseSupport = true;
        };
        script = "${launchPolybar}/bin/polybar-launch";

        settings = {
          "colors" = {
            bg = "#1c1f26";
            fg = "#e8e9ca";
            cpu = "#a6e3a1";
            ram = "#89b4fa";
            disk = "#f9e2af";
            clock = "#c792ea";
            sep = "#3f5360";
            network = "#a6e3a1";
            ws-focused = "#42a5f5";
            ws-urgent = "#f07178";
            ws-occupied = "#555970";
            ws-empty = "#2d3047";
            ws-focused-bg = "#2a2d3a";
          };

          "bar/primary" = {
            monitor = "\${env:MONITOR:}";
            width = "100%";
            height = 28;
            radius = 0;
            fixed-center = true;
            background = "\${colors.bg}";
            foreground = "\${colors.fg}";
            font-0 = "Hack Nerd Font Mono:size=10;2";
            font-1 = "Hack Nerd Font Mono:size=14;3";
            modules-left = "i3";
            modules-center = "";
            modules-right = "pulseaudio sep cpu sep memory sep filesystem sep network sep date";
            module-margin-left = 1;
            module-margin-right = 1;
            padding-right = 2;
            tray-position = "right";
            tray-padding = 4;
            scroll-up = "#i3.prev";
            scroll-down = "#i3.next";
          };

          "bar/secondary" = {
            monitor = "\${env:MONITOR:}";
            width = "100%";
            height = 28;
            radius = 0;
            fixed-center = true;
            background = "\${colors.bg}";
            foreground = "\${colors.fg}";
            font-0 = "Hack Nerd Font Mono:size=10;2";
            font-1 = "Hack Nerd Font Mono:size=14;3";
            modules-left = "i3";
            modules-center = "";
            modules-right = "date";
            module-margin-left = 1;
            module-margin-right = 1;
            padding-right = 2;
            scroll-up = "#i3.prev";
            scroll-down = "#i3.next";
          };

          "module/sep" = {
            type = "custom/text";
            content = "|";
            content-foreground = "\${colors.sep}";
          };

          "module/pulseaudio" = {
            type = "internal/pulseaudio";
            format-volume = "<ramp-volume> <label-volume>";
            label-volume = "%percentage%%";
            label-muted = "${i.mute} muted";
            label-muted-foreground = "\${colors.sep}";
            ramp-volume-0 = i.vol0;
            ramp-volume-1 = i.vol1;
            ramp-volume-2 = i.vol2;
            click-right = "${togglePavucontrol}";
          };

          "module/network" = {
            type = "internal/network";
            interface = cfg.networkInterface;
            interval = 3;
            label-connected = "${i.net} %local_ip%";
            label-connected-foreground = "\${colors.network}";
            label-disconnected = "${i.net} down";
            label-disconnected-foreground = "\${colors.sep}";
          };

          "module/i3" = {
            type = "internal/i3";
            pin-workspaces = true;
            strip-wsnumbers = false;
            index-sort = true;
            enable-click = true;
            enable-scroll = true;
            wrapping-scroll = false;
            reverse-scroll = true;
            label-focused = "%name%";
            label-focused-foreground = "\${colors.ws-focused}";
            label-focused-background = "\${colors.ws-focused-bg}";
            label-focused-padding = 2;
            label-unfocused = "%name%";
            label-unfocused-foreground = "\${colors.ws-occupied}";
            label-unfocused-padding = 2;
            label-visible = "%name%";
            label-visible-foreground = "\${colors.ws-occupied}";
            label-visible-padding = 2;
            label-urgent = "%name%";
            label-urgent-foreground = "\${colors.ws-urgent}";
            label-urgent-background = "\${colors.ws-focused-bg}";
            label-urgent-padding = 2;
            label-empty = "%name%";
            label-empty-foreground = "\${colors.ws-empty}";
            label-empty-padding = 2;
          };

          "module/cpu" = {
            type = "internal/cpu";
            interval = 1;
            format-foreground = "\${colors.cpu}";
            label = "%{A3:${toggleBtop}:}${i.cpu} %percentage%%%{A}";
          };

          "module/memory" = {
            type = "internal/memory";
            interval = 2;
            format-foreground = "\${colors.ram}";
            label = "${i.memory} %gb_used%/%gb_total%";
          };

          "module/filesystem" = {
            type = "internal/fs";
            interval = 30;
            mount-0 = "/";
            format-mounted-foreground = "\${colors.disk}";
            label-mounted = "${i.disk} %used%/%total%";
          };

          "module/date" = {
            type = "internal/date";
            interval = 1;
            date = "%Y-%m-%d";
            time = "%H:%M:%S";
            format-foreground = "\${colors.clock}";
            label = "%date%  %time%";
          };
        };
      };

      xsession.windowManager.i3.config.bars = lib.mkForce [];

      xsession.windowManager.i3.config.startup = [
        {
          command = "${launchPolybar}/bin/polybar-launch";
          notification = false;
          always = true;
        }
      ];

      home.packages = [ launchPolybar ];
    };
  };
}
