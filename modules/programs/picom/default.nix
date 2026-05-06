{...}: {
  flake.modules.homeManager.program_picom = {...}: {
    services.picom = {
      enable = true;

      shadow = false;
      fade = false;

      opacityRules = [
        "85:window_type = 'dnd'"
      ];
    };
  };
}
