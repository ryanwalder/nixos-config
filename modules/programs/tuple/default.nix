{...}: {
  flake.modules.homeManager.program_tuple = {pkgs, ...}: let
    tuple = pkgs.stdenv.mkDerivation rec {
      pname = "tuple";
      version = "v2026_04_21.1";

      src = pkgs.fetchurl {
        url = "https://tuple-client-releases.s3.amazonaws.com/linux/${version}/x86_64/tuple";
        sha256 = "2b0622cde90420cf186e09a4389f42a042d5e47049db11a788e39063d26bd1f6";
      };

      dontUnpack = true;

      nativeBuildInputs = [pkgs.autoPatchelfHook];

      installPhase = ''
        runHook preInstall
        install -Dm755 $src $out/bin/tuple
        runHook postInstall
      '';
    };
  in {
    home.packages = [tuple];
  };
}
