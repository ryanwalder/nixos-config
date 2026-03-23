{...}: {
  # Plugins which reequire more indepth config
  imports = [
    ./completion.nix
    ./conform.nix
    ./lsp.nix
    ./treesitter.nix
    ./luasnip.nix
  ];

  # Plugins which don't require configuring
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
}
