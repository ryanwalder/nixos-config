{ ... }: {
  flake.modules.nixos.program_teams = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.teams-for-linux ];
  };
}
