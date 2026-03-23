{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protontricks
    protonup-ng
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    localNetworkGameTransfers.openFirewall = true;
  };
}
