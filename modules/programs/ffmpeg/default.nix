{...}: {
  flake.modules.homeManager.program_ffmpeg = {pkgs, ...}: {
    home.packages = with pkgs; [
      ffmpeg-headless
    ];
  };
}
