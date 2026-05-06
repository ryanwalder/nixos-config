{...}: {
  flake.modules.homeManager.program_gnome-terminal = {...}: {
    programs.gnome-terminal = {
      enable = true;
      showMenubar = false;
      profile = {
        "b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
          default = true;
          visibleName = "Default";
          scrollbackLines = 10000;
          scrollOnOutput = false;
          showScrollbar = false;
          font = "Hack Nerd Font Mono 13";
          audibleBell = false;
          boldIsBright = true;
          colors = {
            foregroundColor = "#eeeeec";
            backgroundColor = "#000000";
            palette = [
              "#000000"
              "#cc0000"
              "#4e9a06"
              "#c4a000"
              "#3465a4"
              "#75507b"
              "#06989a"
              "#d3d7cf"
              "#555753"
              "#ef2929"
              "#8ae234"
              "#fce94f"
              "#729fcf"
              "#ad7fa8"
              "#34e2e2"
              "#eeeeec"
            ];
          };
        };
      };
    };
  };
}
