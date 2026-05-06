{inputs, ...}: {
  flake.modules.nixos.hardware_laptop = {...}: {
    imports = [
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    ];

    services.thermald.enable = true;
    services.fwupd.enable = true;

    services.logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
      lidSwitchDocked = "ignore";
    };

    powerManagement.enable = true;
  };
}
