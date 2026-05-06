{...}: {
  flake.modules.nixos.program_nix = {...}: {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
  };

  flake.modules.homeManager.program_nix = {...}: {
    xdg.configFile."nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';
  };
}
