{ ... }: {
  flake.modules.nixos.blackout = {
    home-manager.users.ryan = {
      xsession.windowManager.i3.config.workspaceOutputAssign = [
        { workspace = "1";  output = "DP-0"; }
        { workspace = "2";  output = "DP-0"; }
        { workspace = "3";  output = "DP-0"; }
        { workspace = "4";  output = "DP-0"; }
        { workspace = "5";  output = "DP-0"; }
        { workspace = "6";  output = "DP-4"; }
        { workspace = "7";  output = "DP-4"; }
        { workspace = "8";  output = "DP-2"; }
        { workspace = "9";  output = "DP-2"; }
        { workspace = "10"; output = "DP-2"; }
      ];
    };
  };
}
