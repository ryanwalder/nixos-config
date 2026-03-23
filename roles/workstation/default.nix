{...}: {
  imports = [
    ../../modules/nixos/printing
    ../../modules/nixos/i3
    ../../modules/nixos/audio
    ../../modules/nixos/gnupg
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  home-manager.users.ryan = {
    imports = [
      ../../modules/home/fonts
      ../../modules/home/bash
      ../../modules/home/cli-tools
      ../../modules/home/direnv
      ../../modules/home/discord
      ../../modules/home/git
      ../../modules/home/gnupg
      ../../modules/home/mpv
      ../../modules/home/polybar
      ../../modules/home/i3
      ../../modules/home/starship
      ../../modules/home/wezterm
      ../../modules/home/xdg
      ../../modules/home/yt-dlp
      ../../modules/home/nvim
    ];
  };
}
