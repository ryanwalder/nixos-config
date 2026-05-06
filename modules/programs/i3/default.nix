{...}: {
  flake.modules.nixos.program_i3 = {...}: {
    services.xserver.enable = true;
    services.xserver.windowManager.i3.enable = true;
    services.xserver.xkb.layout = "gb";

    environment.sessionVariables = {
      XDG_CURRENT_DESKTOP = "i3";
    };
  };

  flake.modules.homeManager.program_i3 = {pkgs, ...}: let
    mod = "Mod4";
  in {
    xsession.windowManager.i3 = {
      enable = true;

      config = {
        modifier = mod;
        floating.modifier = mod;

        fonts = {
          names = ["Hack Nerd Font Mono"];
          style = "Regular";
          size = 8.0;
        };

        colors = {
          focused = {
            border = "#42A5F5";
            background = "#42A5F5";
            text = "#E8E9CA";
            indicator = "#8BBAE0";
            childBorder = "#42A5F5";
          };
          unfocused = {
            border = "#393939";
            background = "#393939";
            text = "#2D303B";
            indicator = "#393939";
            childBorder = "#393939";
          };
          focusedInactive = {
            border = "#393939";
            background = "#393939";
            text = "#42A5F5";
            indicator = "#393939";
            childBorder = "#393939";
          };
          urgent = {
            border = "#8BBAE0";
            background = "#8BBAE0";
            text = "#E8E9CA";
            indicator = "#8BBAE0";
            childBorder = "#8BBAE0";
          };
        };

        window = {
          border = 2;
          commands = [
            {
              criteria = {window_role = "pop-up";};
              command = "floating enable";
            }
            {
              criteria = {window_role = "task_dialog";};
              command = "floating enable";
            }
            {
              criteria = {class = ".*";};
              command = "border pixel 2";
            }
            {
              criteria = {class = "scratch";};
              command = "move to scratchpad";
            }
            {
              criteria = {class = "pavucontrol";};
              command = "floating enable";
            }
            {
              criteria = {class = "Wicd-client.py";};
              command = "floating enable";
            }
            {
              criteria = {class = "Lxappearance";};
              command = "floating enable";
            }
            {
              criteria = {title = "Microsoft Teams Notification";};
              command = "floating enable";
            }
            {
              criteria = {class = "Piper";};
              command = "floating enable";
            }
            {
              criteria = {
                class = "MediaElch";
                title = "Settings";
              };
              command = "floating enable, border normal";
            }
            {
              criteria = {
                class = "MediaElch";
                title = "Search Result";
              };
              command = "floating enable, border normal";
            }
            {
              criteria = {
                class = "MediaElch";
                title = "Choose an Image";
              };
              command = "floating enable, border normal";
            }
            {
              criteria = {instance = "origin.exe";};
              command = "floating enable";
            }
            {
              criteria = {instance = "^Dungeondraft$";};
              command = "floating disable, border normal";
            }
            {
              criteria = {title = "^Origin$";};
              command = "floating enable, fullscreen disable";
            }
            {
              criteria = {
                instance = "^Steam$";
                title = "^Steam - Self Updater$";
              };
              command = "floating enable, resize set 500 750";
            }
            {
              criteria = {
                class = "Nemo";
                instance = "nemo";
                title = "File conflict";
              };
              command = "floating enable, move position center";
            }
          ];
        };

        floating.border = 2;

        focus.newWindow = "urgent";
        workspaceAutoBackAndForth = true;

        keybindings = {
          "${mod}+Shift+q" = "kill";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+h" = "split h";
          "${mod}+v" = "split v";

          "${mod}+f" = "fullscreen";

          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          "${mod}+space" = "floating toggle";

          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+0" = "workspace 10";

          "${mod}+Shift+1" = "move container to workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9";
          "${mod}+Shift+0" = "move container to workspace 10";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";

          "${mod}+r" = "mode resize";

          "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"'';

          "${mod}+Return" = "exec ${pkgs.kdePackages.konsole}/bin/konsole";
          "${mod}+Shift+f" = "exec ${pkgs.nemo}/bin/nemo";
          "${mod}+Shift+x" = "exec ${pkgs.xkill}/bin/xkill";

          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-match-fields name -matching regex -drun-display-format {name}";

          "${mod}+F7" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "${mod}+F8" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "${mod}+F9" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "${mod}+F12" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioPause" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          "${mod}+F11" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
          "${mod}+Shift+F11" = "exec --no-startup-id ${pkgs.cmus}/bin/cmus-remote -C player-next-album";
          "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
          "${mod}+F10" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
          "${mod}+Shift+F10" = "exec --no-startup-id ${pkgs.cmus}/bin/cmus-remote -C player-prev-album";
          "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
        };

        modes = {
          resize = {
            "Left" = "resize shrink width 1 px or 1 ppt";
            "Down" = "resize grow height 1 px or 1 ppt";
            "Up" = "resize shrink height 1 px or 1 ppt";
            "Right" = "resize grow width 1 px or 1 ppt";
            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };

        assigns = {
          "3" = [
            {
              class = "^steam$";
              title = "Steam$";
            }
            {
              class = "^steam$";
              title = "Friends List.*";
            }
            {
              class = "^steam$";
              title = "Chat$";
            }
            {
              class = "^steam$";
              title = "^Steam - Self Updater$";
            }
          ];
          "6" = [
            {instance = "^Slack$";}
            {instance = "^discord$";}
            {instance = "^vesktop$";}
          ];
          "10" = [
            {instance = "^cmus$";}
          ];
        };

        startup = [
          {
            command = "${pkgs.xsetroot}/bin/xsetroot -solid '#36393f'";
            notification = false;
          }
          {
            command = "${pkgs.xset}/bin/xset s 290 550";
            notification = false;
          }
          {
            command = "${pkgs.xset}/bin/xset dpms 285 600 900";
            notification = false;
          }
        ];
      };
    };
  };
}
