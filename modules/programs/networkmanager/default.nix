{...}: {
  flake.modules.nixos.program_networkmanager = {...}: {
    networking.networkmanager.enable = true;
    users.users.ryan.extraGroups = ["networkmanager"];
  };

  flake.modules.homeManager.program_networkmanager = {pkgs, ...}: {
    home.packages = [pkgs.networkmanagerapplet];
  };
}
