{...}: {
  flake.modules.homeManager.program_dunst = {pkgs, ...}: {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          monitor = 0;
          width = 300;
          height = "(0, 300)";
          offset = "(10, 35)";
          indicate_hidden = true;
          shrink = false;
          transparency = 0;
          separator_height = 4;
          padding = 8;
          horizontal_padding = 8;
          frame_width = 3;
          frame_color = "#5294e2";
          separator_color = "frame";
          sort = true;
          idle_threshold = 120;
          font = "DejaVu Sans 8";
          line_height = 0;
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = true;
          ellipsize = "middle";
          ignore_newline = false;
          stack_duplicates = false;
          hide_duplicate_count = false;
          show_indicators = true;
          icon_position = "left";
          max_icon_size = 32;
          icon_path = "${pkgs.papirus-icon-theme}/share/icons/Papirus/16x16/status/:${pkgs.papirus-icon-theme}/share/icons/Papirus/16x16/devices/";
          sticky_history = true;
          history_length = 20;
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:";
          browser = "${pkgs.firefox}/bin/firefox -new-tab";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
        };

        experimental = {
          per_monitor_dpi = false;
        };

        urgency_low = {
          background = "#393939";
          foreground = "#888888";
          timeout = 10;
        };

        urgency_normal = {
          background = "#393939";
          foreground = "#ffffff";
          timeout = 10;
        };

        urgency_critical = {
          background = "#900000";
          foreground = "#ffffff";
          frame_color = "#ff0000";
          timeout = 0;
        };
      };
    };
  };
}
