{...}: {
  flake.modules.homeManager.program_tree = {pkgs, ...}: {
    home.packages = with pkgs; [
      tree
    ];
  };
}
