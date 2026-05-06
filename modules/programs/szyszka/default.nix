{ ... }: {
  flake.modules.homeManager.program_szyszka = { pkgs, lib, ... }:
  let
    szyszkaPatched = pkgs.szyszka.overrideAttrs (old: {
      patches = (old.patches or []) ++ [ ./fix-regex-backslash.patch ];
    });

    szyszkaWrapper = pkgs.writeShellApplication {
      name = "szyszka-nemo";
      runtimeInputs = [ szyszkaPatched ];
      text = ''
        paths=()
        for uri in "$@"; do
          path="''${uri#file://}"
          path="$(printf '%b' "''${path//%/\\x}")"
          paths+=("$path")
        done
        exec szyszka "''${paths[@]}"
      '';
    };
  in {
    home.packages = [ szyszkaPatched szyszkaWrapper ];

    home.activation.nemoRenamer = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.dconf}/bin/dconf write /org/nemo/preferences/bulk-rename-tool \
        "b'${lib.getExe szyszkaWrapper}'"
    '';
  };
}
