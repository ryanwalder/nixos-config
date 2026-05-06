{inputs, lib, ...}: {
  flake.modules.nixos.role_base = {pkgs, config, ...}: {
    imports = with inputs.self.modules.nixos; [
      inputs.home-manager.nixosModules.home-manager
      program_firewall
      program_nix
      program_pciutils
      program_ssh
      program_sudo
    ];

    hardware.enableRedistributableFirmware = lib.mkDefault true;

    sops.defaultSopsFile = "${inputs.self}/secrets/host/${config.networking.hostName}.yaml";
    sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [
        inputs.nixcord.homeModules.nixcord
        inputs.nixvim.homeModules.nixvim
        inputs.self.modules.homeManager.role_base
      ];
    };
  };

  flake.modules.homeManager.role_base = {...}: {
    imports = with inputs.self.modules.homeManager; [
      program_bash
      program_curl
      program_htop
      program_nix
      program_nvim
      program_tree
      program_wget
    ];
  };
}
