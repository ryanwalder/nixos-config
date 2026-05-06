{...}: {
  flake.modules.homeManager.program_nvtop = {pkgs, ...}: {
    home.packages = with pkgs; [
      nvtop
    ];
  };
}
