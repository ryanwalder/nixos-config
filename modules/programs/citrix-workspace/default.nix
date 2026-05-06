{...}: {
  flake.modules.nixos.program_citrix-workspace = {...}: {
    nixpkgs.config.permittedInsecurePackages = [
      "libsoup-2.74.3"
    ];
  };

  flake.modules.homeManager.program_citrix-workspace = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.programs.citrix-workspace.extraCerts = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
      description = "Extra X.509 certificates to trust in Citrix Workspace (e.g. corporate CAs).";
    };

    config.home.packages = [
      (
        if config.programs.citrix-workspace.extraCerts == []
        then pkgs.citrix_workspace
        else
          pkgs.citrix_workspace.override {
            inherit (config.programs.citrix-workspace) extraCerts;
          }
      )
    ];
  };
}
