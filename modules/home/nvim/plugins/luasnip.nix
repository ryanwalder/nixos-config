{ pkgs, ... }: {
  programs.nixvim.plugins = {
    luasnip.enable = true;
  };

  programs.nixvim.extraConfigLua = ''
    do
      local ls = require("luasnip")
      local lines = {"#!/usr/bin/env bash", "set -euo pipefail", "IFS=$'\\n\\t'"}
      for _, ft in ipairs({"sh", "bash"}) do
        ls.add_snippets(ft, {
          ls.snippet("!bash", { ls.text_node(lines) }),
        })
      end
    end
  '';
}
