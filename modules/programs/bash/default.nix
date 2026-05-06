{...}: {
  flake.modules.homeManager.program_bash = {config, ...}: {
    programs.bash = {
      enable = true;
      enableCompletion = true;

      historyFile = "${config.xdg.stateHome}/bash/history";
      historySize = 50000;
      historyFileSize = 500000;
      historyControl = ["ignoreboth"];

      shellOptions = ["histappend" "checkwinsize"];

      shellAliases = {
        ls = "ls --group-directories-first --color=auto";
        grep = "grep --color=auto --exclude-dir={.git,.venv,node_modules,.terraform}";
        ll = "ls -l";
        la = "ls -al";
        mtr = "mtr --curses";
        tree = "tree --dirsfirst -I \"\\.terraform|\\.git/|\\.venv|node_modules\"";
        ".." = "cd ../";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
      };

      sessionVariables = {
        PAGER = "less";
        EDITOR = "vim";
      };

      initExtra = ''
        if command -v bat &>/dev/null; then
          alias cat="bat --no-pager --plain"
        fi

        stty -ixon
        stty -ixoff

        export SSH_AUTH_SOCK="/run/user/1000/gnupg/S.gpg-agent.ssh"

        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
      '';

      profileExtra = ''
        setxkbmap -option caps:none
      '';
    };
  };
}
