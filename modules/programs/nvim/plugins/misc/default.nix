{ ... }: {
  flake.modules.homeManager.nvim = { ... }: {
    programs.nixvim.plugins = {
      blame.enable = true;
      lualine.enable = true;
      web-devicons.enable = true;
      which-key = {
        enable = true;
        settings = {
          icons = {
            group = " ";
            rules = false;
            separator = "-";
          };
          keys = {
            scroll_down = "<Down>";
            scroll_up = "<Up>";
          };
        };
      };
    };
  };
}
