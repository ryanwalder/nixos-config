{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "blackout";

  flake.modules.nixos.blackout = {
    imports = with inputs.self.modules.nixos; [
      locale_uk
      user_ryan

      role_base
      role_home
      role_workstation
      role_gaming
      role_rb

      hardware_audio
      hardware_boot
      hardware_ssd
      hardware_swap
      hardware_gpu-nvidia
      hardware_cpu-amd
      hardware_bluetooth
      hardware_brother-hl3270cdw
    ];

    system.stateVersion = "25.11";
  };
}
