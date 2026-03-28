{ inputs, lib, ... }: {
  flake.modules.nixos.base = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.self.modules.nixos.host-options
    ];

    # Boot
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    # Firmware
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    # Firewall
    networking.firewall.enable = true;

    # SSH
    services.openssh.enable = true;

    # Sudo — wheel can run nixos-rebuild without password
    security.sudo.extraRules = [
      {
        groups = [ "wheel" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/nixos-rebuild";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];

    # Locale
    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "uk";
    };

    # Packages
    environment.systemPackages = with pkgs; [
      pciutils
    ];

    # Home Manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [
        inputs.nixcord.homeModules.nixcord
        inputs.nixvim.homeModules.nixvim
      ];
    };
  };
}
