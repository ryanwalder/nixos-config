{inputs, ...}: {
  flake.modules.nixos.role_rb = {...}: {
    imports = with inputs.self.modules.nixos; [
      program_citrix-workspace
    ];

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.role_rb
    ];
  };

  flake.modules.homeManager.role_rb = {...}: {
    imports = with inputs.self.modules.homeManager; [
      program_citrix-workspace
      program_tuple
    ];
  };
}
