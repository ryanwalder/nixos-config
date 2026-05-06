{...}: {
  flake.modules.homeManager.program_direnv = {...}: {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
