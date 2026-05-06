{inputs, ...}: {
  flake.modules.nixos.role_workstation = {...}: {
    imports = with inputs.self.modules.nixos; [
      program_gnupg
      program_gnome-keyring
      program_i3
      program_nemo
      program_teams
      program_xdg-portal
    ];

    boot.kernel.sysctl."kernel.pty.max" = 8192;

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.role_workstation
    ];
  };

  flake.modules.homeManager.role_workstation = {...}: {
    imports = with inputs.self.modules.homeManager; [
      program_ark
      program_backup-home
      program_bat
      program_bc
      program_btop
      program_chromium
      program_claude-code
      program_cmus
      program_direnv
      program_discord
      program_dunst
      program_ffmpeg
      program_firefox
      program_flameshot
      program_fontconfig
      program_ghostty
      program_git
      program_gnome-keyring
      program_gnome-terminal
      program_gnupg
      program_i3
      program_just
      program_konsole
      program_krita
      program_mpv
      program_nemo
      program_nvim
      program_nvim-completion
      program_nvim-conform
      program_nvim-editorconfig
      program_nvim-lsp
      program_nvim-luasnip
      program_nvim-misc
      program_nvim-treesitter
      program_okular
      program_picard
      program_opencode
      program_pi
      program_picom
      program_playerctl
      program_polybar
      program_prusaslicer
      program_pulseaudio

      hardware_audio
      program_qimgv
      program_rofi
      program_slack
      program_starship
      program_szyszka
      program_tree
      program_wget
      program_xdg
      program_yt-dlp

      theme_app-arc
      theme_cursor-breeze
      theme_icon-papirus
    ];
  };
}
