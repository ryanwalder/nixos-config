{ ... }: {
  flake.modules.homeManager.program_nvim-treesitter = { ... }: {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };
  };
}
