{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
        formatters_by_ft = {
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          vue = [ "prettier" ];
          css = [ "prettier" ];
          scss = [ "prettier" ];
          html = [ "prettier" ];
          json = [ "prettier" ];
          jsonc = [ "prettier" ];
          yaml = [ "prettier" ];
          markdown = [ "prettier" ];
          graphql = [ "prettier" ];
          lua = [ "stylua" ];
          nix = [ "alejandra" ];
          sh = [ "shfmt" "shellcheck" ];
          bash = [ "shfmt" "shellcheck" ];
          go = [ "gofmt" ];
          rust = [ "rustfmt" ];
          terraform = [ "terraform_fmt" ];
          toml = [ "taplo" ];
          handlebars = [ "djlint" ];
        };
      };
    };

    # Formatter binaries for the neovim wrapper
    extraPackages = with pkgs; [
      prettier
      stylua
      alejandra
      shfmt
      shellcheck
      go # provides gofmt
      rustfmt
      terraform # provides terraform fmt
      taplo # TOML formatter
      djlint # Handlebars/Jinja/HTML template formatter
    ];

    # Replace LSP format keybinding with conform
    keymaps = [
      {
        key = "<leader>f";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end
        '';
        options = {
          silent = true;
          desc = "Format buffer";
        };
      }
    ];
  };
}
