{...}: {
  flake.modules.homeManager.program_pulseaudio = {pkgs, ...}: {
    home.packages = with pkgs; [
      pulseaudio
    ];
  };
}
