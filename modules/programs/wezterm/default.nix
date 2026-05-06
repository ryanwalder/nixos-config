{ ... }: {
  flake.modules.homeManager.program_wezterm = { ... }: {
    programs.wezterm.enable = true;
  };
}
