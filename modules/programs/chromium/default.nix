{...}: {
  flake.modules.homeManager.program_chromium = {...}: {
    programs.chromium.enable = true;
  };
}
