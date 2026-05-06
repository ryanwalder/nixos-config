{...}: {
  flake.modules.nixos.hardware_audio = {pkgs, ...}: {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };

  flake.modules.homeManager.hardware_audio = {pkgs, ...}: {
    xdg.desktopEntries.pavucontrol = {
      name = "PulseAudio Volume Control";
      comment = "Adjust audio volume levels";
      exec = "${pkgs.pavucontrol}/bin/pavucontrol";
      terminal = false;
      type = "Application";
      icon = "audio-volume-high";
      categories = ["Audio" "Mixer" "Settings"];
    };
  };
}
