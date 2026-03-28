{ ... }: {
  flake.modules.homeManager.nvim = { ... }: {
    programs.nixvim.plugins = {
      blink-indent.enable = true;
      blink-pairs.enable = true;
      blink-cmp-spell.enable = true;
      blink-emoji.enable = true;

      blink-cmp = {
        enable = true;

        settings.snippets.preset = "luasnip";
        settings.keymap.preset = "enter";

        settings.sources.default = [
          "lsp"
          "path"
          "buffer"
          "spell"
          "emoji"
          "snippets"
        ];

        settings.sources.providers.spell = {
          module = "blink-cmp-spell";
          name = "Spell";
          score_offset = 100;
        };

        settings.sources.providers.emoji = {
          module = "blink-emoji";
          name = "Emoji";
          score_offset = 15;
          opts = {
            insert = true;
          };
        };

        settings.sources.providers.snippets = {
          module = "blink.cmp.sources.snippets";
          name = "Snippets";
        };
      };
    };
  };
}
