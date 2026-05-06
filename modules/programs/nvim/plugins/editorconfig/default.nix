{...}: {
  flake.modules.homeManager.program_nvim-editorconfig = {...}: {
    programs.nixvim.editorconfig.enable = true;
  };
}
