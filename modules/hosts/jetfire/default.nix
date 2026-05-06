{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "jetfire";

  flake.modules.nixos.jetfire = {
    imports = with inputs.self.modules.nixos; [
      locale_uk
      user_ryan

      role_base
      role_workstation
      role_rb

      hardware_boot
      hardware_ssd
      hardware_swap
      hardware_cpu-intel
      hardware_bluetooth
      hardware_laptop

      program_networkmanager
    ];

    system.stateVersion = "25.11";
  };
}
