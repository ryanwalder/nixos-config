{...}: {
  flake.modules.homeManager.program_pi = {pkgs, ...}: let
    pi = pkgs.stdenv.mkDerivation rec {
      pname = "pi-coding-agent";
      version = "0.72.1";

      src = pkgs.fetchurl {
        url = "https://github.com/badlogic/pi-mono/releases/download/v${version}/pi-linux-x64.tar.gz";
        hash = "sha256-APq4sfGUFAqMnb0mFLOOmXJs1d3jtbLWB71dqm+FHUA=";
      };

      nativeBuildInputs = [pkgs.autoPatchelfHook];

      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/pi $out/bin
        cp -r . $out/share/pi/
        ln -s $out/share/pi/pi $out/bin/pi
        runHook postInstall
      '';
    };
  in {
    home.packages = [pi];
  };
}
