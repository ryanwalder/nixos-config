{ inputs, ... }: {
  flake.modules.homeManager.workstation = { ... }: {
    imports = with inputs.self.modules.homeManager; [
      bash
      git
      gnupg
      nvim
      starship
      direnv
      fonts
      cli-tools
      discord
      mpv
      polybar
      i3
      wezterm
      xdg
      yt-dlp
    ];
  };
}
