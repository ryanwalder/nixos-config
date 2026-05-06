{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages (ps: [ps.pyyaml]))
    sops
    ssh-to-age
  ];
}
