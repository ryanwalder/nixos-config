{ ... }: {
  flake.modules.homeManager.git = { pkgs, ... }:
  let
    gitScripts = [
      (pkgs.writeShellScriptBin "git-brd" (builtins.readFile ./scripts/git-brd))
      (pkgs.writeShellScriptBin "git-rum" (builtins.readFile ./scripts/git-rum))
      (pkgs.writeShellScriptBin "git-sum" (builtins.readFile ./scripts/git-sum))
      (pkgs.writeShellScriptBin "git-sss" (builtins.readFile ./scripts/git-sss))
    ];
  in {
    home.packages = gitScripts;

    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "Ryan Walder";
          email = "ryan@tfu.io";
          signingkey = "0x350052349934BA77";
        };
        init.defaultBranch = "main";
        core.editor = "vi";
        merge.ff = "only";
        push = { default = "simple"; followTags = true; };
        rebase.autostash = true;
        status.showUntrackedFiles = "all";
        transfer.fsckobjects = true;
        credential.helper = "cache --timeout=28800";
        fetch.prune = true;
        gpg.program = "gpg";
        alias = {
          brd = "!git-brd";
          rum = "!git-rum";
          rim = "!git-rum interactive";
          sum = "!git-sum";
          sss = "!git-sss";
          f   = "fetch --all";
          co  = "checkout";
          br  = "branch";
          st  = "status";
          cp  = "cherry-pick";
          unadd    = "reset HEAD";
          uncommit = "reset HEAD~";
          logs = "log --show-signature";
          lg   = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        };
      };
    };
  };
}
