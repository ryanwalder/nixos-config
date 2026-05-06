{...}: {
  flake.modules.nixos.program_cups = {...}: {
    services.printing = {
      enable = true;
      browsing = true;
      webInterface = true;
      listenAddresses = ["localhost:631"];
      allowFrom = ["localhost"];
    };
  };
}
