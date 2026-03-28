{ ... }: {
  flake.modules.homeManager.nvim = { ... }: {
    programs.nixvim = { lib, ... }: {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      editorconfig.enable = true;

      clipboard = {
        register = "unnamedplus";
        providers = {
          xclip.enable = true;
          wl-copy.enable = true;
        };
      };

      opts = {
        number = false;
        relativenumber = false;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        smartindent = true;
        wrap = false;
        ignorecase = true;
        smartcase = true;
        termguicolors = true;
        scrolloff = 8;
        signcolumn = "yes";
        updatetime = 50;
        mouse = "";
        undodir = lib.nixvim.mkRaw ''vim.fn.stdpath "data" .. "/undo"'';
        backupdir = lib.nixvim.mkRaw ''vim.fn.stdpath "data" .. "/backup"'';
        undofile = true;
      };

      globals.mapleader = " ";
    };
  };
}
