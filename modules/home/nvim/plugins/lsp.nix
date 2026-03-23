{ pkgs, ... }:

let
  css-variables-language-server = pkgs.stdenv.mkDerivation rec {
    pname = "css-variables-language-server";
    version = "2.8.4";
    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/css-variables-language-server/-/css-variables-language-server-${version}.tgz";
      hash = "sha256-iYheZKWa+PlsUa9w2yo0Ct5Z5NnfXoYa+Zr1zqeJBak=";
    };
    sourceRoot = "package";
    nativeBuildInputs = [ pkgs.makeWrapper ];
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib/node_modules/css-variables-language-server
      cp -r . $out/lib/node_modules/css-variables-language-server/
      mkdir -p $out/bin
      makeWrapper ${pkgs.nodejs}/bin/node $out/bin/css-variables-language-server \
        --add-flags "$out/lib/node_modules/css-variables-language-server/bin/index.js"
      runHook postInstall
    '';
  };
in
{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      keymaps = {
        silent = true;
        lspBuf = {
          gd = { action = "definition";      desc = "Go to definition"; };
          gD = { action = "declaration";     desc = "Go to declaration"; };
          gr = { action = "references";      desc = "References"; };
          gi = { action = "implementation";  desc = "Go to implementation"; };
          K  = { action = "hover";           desc = "Hover docs"; };
          "<leader>rn" = { action = "rename";       desc = "Rename symbol"; };
          "<leader>ca" = { action = "code_action";  desc = "Code action"; };
        };
        diagnostic = {
          "[d" = { action = "goto_prev"; desc = "Prev diagnostic"; };
          "]d" = { action = "goto_next"; desc = "Next diagnostic"; };
          "<leader>e" = { action = "open_float"; desc = "Diagnostic float"; };
        };
      };
      servers = {
        autotools_ls.enable = true;
        bashls.enable = true;
        bicep = { enable = true; package = pkgs.bicep-lsp; };
        cmake.enable = true;
        css_variables = { enable = true; package = css-variables-language-server; };
        cssls.enable = true;
        docker_language_server.enable = true;
        eslint = {
          enable = true;
          config.nodePath = "${pkgs.nodePackages.eslint}/lib/node_modules";
        };
        gopls.enable = true;
        groovyls = { enable = true; package = pkgs.groovy-language-server; };
        helm_ls.enable = true;
        htmx.enable = true;
        jsonls.enable = true;
        jsonnet_ls.enable = true;
        just.enable = true;
        lua_ls = {
          enable = true;
          config.settings.Lua.runtime.version = "LuaJIT";
        };
        marksman.enable = true;
        nixd.enable = true;
        postgres_lsp.enable = true;
        rubocop.enable = true;
        ruby_lsp.enable = true;
        rls.enable = true;
        systemd_ls.enable = true;
        systemd_lsp.enable = true;
        terraform_lsp.enable = true;
        terraformls.enable = true;
        tflint.enable = true;
        ts_ls = {
          enable = true;
          config.init_options.tsserver.path =
            "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
        };
        vimls.enable = true;
        vue_ls.enable = true;
        yamlls.enable = true;
        zuban.enable = true;
      };
    };
  };
}
