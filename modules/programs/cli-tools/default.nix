{ ... }: {
  flake.modules.homeManager.cli-tools = { pkgs, ... }: {
    home.packages = with pkgs; [
      wget
      curl
      tree
      nemo
      flameshot
      firefox
      claude-code
      rofi
      just
      btop
    ];
  };
}
