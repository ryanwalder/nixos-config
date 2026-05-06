{...}: {
  flake.modules.homeManager.program_ghostty = {...}: {
    programs.ghostty = {
      enable = true;
      settings = {
        background = "#000000";
        foreground = "#eeeeec";
        palette = [
          "0=#000000"
          "1=#cc0000"
          "2=#4e9a06"
          "3=#c4a000"
          "4=#3465a4"
          "5=#75507b"
          "6=#06989a"
          "7=#d3d7cf"
          "8=#555753"
          "9=#ef2929"
          "10=#8ae234"
          "11=#fce94f"
          "12=#729fcf"
          "13=#ad7fa8"
          "14=#34e2e2"
          "15=#eeeeec"
        ];
        window-padding-x = 0;
        window-padding-y = 0;
        window-show-tab-bar = "never";
        window-decoration = false;
        scrollback-limit = 10000;
        bold-is-bright = true;
        background-opacity = 1;
        scrollbar = "never";
        window-vsync = false;
        window-inherit-working-directory = false;
        window-save-state = "never";
        resize-overlay = "never";
        clipboard-read = "allow";
        clipboard-write = "allow";
        clipboard-paste-protection = true;
        copy-on-select = true;
        right-click-action = "context-menu";
        undo-timeout = "30m";
        bell-features = "no-audio";
        linux-cgroup = "always";
      };
    };
  };
}
