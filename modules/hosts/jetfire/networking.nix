{...}: {
  flake.modules.nixos.jetfire = {
    networking.hostName = "jetfire";
  };
}
