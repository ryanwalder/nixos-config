{ inputs, ... }: {
  flake.modules.nixos.blackout = {
    imports = [
      (inputs.self.factory.syncthing {
        user = "ryan";
        devices = { };
        folders = { };
      })
    ];
  };
}
