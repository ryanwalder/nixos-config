{...}: {
  flake.modules.homeManager.fonts_nerd-fonts = {pkgs, ...}: {
    home.packages = with pkgs; [
      nerd-fonts.hack
    ];
  };
}
