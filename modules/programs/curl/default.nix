{...}: {
  flake.modules.homeManager.program_curl = {pkgs, ...}: {
    home.packages = with pkgs; [
      curl
    ];
  };
}
