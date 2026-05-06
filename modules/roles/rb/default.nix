{inputs, ...}: {
  flake.modules.nixos.role_rb = {...}: {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.role_rb
    ];
  };

  flake.modules.homeManager.role_rb = {...}: {
    imports = with inputs.self.modules.homeManager; [
      program_citrix-workspace
    ];
  };
}
