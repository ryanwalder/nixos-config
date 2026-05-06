{...}: {
  flake.modules.nixos.program_citrix-workspace = {...}: {
    nixpkgs.config.permittedInsecurePackages = [
      "libsoup-2.74.3"
    ];
  };

  flake.modules.homeManager.program_citrix-workspace = {pkgs, ...}: let
    opencvCompat = pkgs.symlinkJoin {
      name = "opencv4-citrix-compat";
      paths = [pkgs.opencv4];
      postBuild = ''
        for so in ${pkgs.opencv4}/lib/*.so; do
          ln -s "$so" "$out/lib/$(basename "$so").410" || true
        done
      '';
    };

    sonameCompat = {pkg, base, soname}: pkgs.symlinkJoin {
      name = "${base}-citrix-compat";
      paths = [(pkgs.lib.getLib pkg)];
      postBuild = ''
        if [ ! -e "$out/lib/${soname}" ]; then
          target=$(cd "$out/lib" && ls ${base}.so.* 2>/dev/null | head -1)
          [ -n "$target" ] && ln -sf "$target" "$out/lib/${soname}" || true
        fi
      '';
    };

    fuse3Compat = sonameCompat {pkg = pkgs.fuse3; base = "libfuse3"; soname = "libfuse3.so.3";};
    gpgmeCompat = sonameCompat {pkg = pkgs.gpgme; base = "libgpgme"; soname = "libgpgme.so.11";};
    pugixmlCompat = sonameCompat {pkg = pkgs.pugixml.override {shared = true;}; base = "libpugixml"; soname = "libpugixml.so.1";};

    citrix = pkgs.stdenv.mkDerivation rec {
      pname = "citrix-workspace";
      version = "26.01.0.150";

      src = pkgs.requireFile {
        name = "linuxx64-${version}.tar.gz";
        sha256 = "0avrf9jpqhijvp6w4jgs7xgp4gg1q2mdzak9h9klkqrbsgrvjr3p";
        message = ''
          Citrix Workspace tarball not in the nix store. Download from
          https://www.citrix.com/downloads/workspace-app/linux/ and seed it:

            nix-prefetch-url file://$PWD/linuxx64-${version}.tar.gz
        '';
      };

      sourceRoot = ".";
      dontBuild = true;
      dontConfigure = true;
      dontAutoPatchelf = true;

      nativeBuildInputs = with pkgs; [
        autoPatchelfHook
        makeWrapper
        libfaketime
        perl
        which
        file
        more
      ];

      buildInputs = with pkgs; [
        glib
        glib-networking
        nss
        nspr
        openssl
        krb5
        zlib
        stdenv.cc.cc
        (lib.getLib systemd)

        libsoup_2_4
        heimdal

        gtk3
        cairo
        pango
        atk
        gdk-pixbuf
        harfbuzzFull
        freetype
        fontconfig

        libGL
        libgbm
        libva

        libx11
        libxcb
        libxtst
        libxext
        libxfixes
        libxrender
        libxinerama
        libxscrnsaver

        libpng12
        libjpeg8

        alsa-lib
        libpulseaudio

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base

        libxml2_13
        libxslt
        libsecret
        libnotify
        libxmu
        lcms2
        woff2
        enchant
        hyphen
        libmanette
        libseccomp
        pcsclite

        sane-backends
        libinput
        networkmanager
        libproxy
        libayatana-appindicator
        webkitgtk_4_1
        libxaw
        libxt

        opencvCompat
        fuse3Compat
        gpgmeCompat
        pugixmlCompat
      ];

      installPhase = ''
        runHook preInstall

        export ICAInstDir="$out/opt/citrix-icaclient"
        export HOME=$(mktemp -d)
        mkdir -p "$out/bin"

        sed -i \
          -e 's,^ANSWER="",ANSWER="$INSTALLER_YES",g' \
          -e 's,/bin/true,true,g' \
          -e 's, -C / , -C . ,g' \
          ./linuxx64/hinst

        source_date=$(date --utc --date=@$SOURCE_DATE_EPOCH "+%F %T")
        faketime -f "$source_date" ${pkgs.stdenv.shell} linuxx64/hinst CDROM "$(pwd)"

        # hinst's check_and_install_webkit2gtk extracts to / (root fs); replicate
        # the install ourselves into $ICAInstDir so the bundled webkit is reachable.
        tar -xzf ./linuxx64/linuxx64.cor/Webkit2gtk4.0/webkit2gtk-4.0.tar.gz \
            -C "$ICAInstDir" --strip-components=1

        rm -f "$ICAInstDir"/util/gst_aud_play \
              "$ICAInstDir"/util/gst_aud_read \
              "$ICAInstDir"/util/gst_*0.10 \
              "$ICAInstDir"/util/libgstflatstm0.10.so
        ln -sf "$ICAInstDir"/util/gst_play1.0 "$ICAInstDir"/util/gst_play
        ln -sf "$ICAInstDir"/util/gst_read1.0 "$ICAInstDir"/util/gst_read

        for prog in wfica selfservice; do
          wrapProgram "$ICAInstDir/$prog" \
            --set ICAROOT "$ICAInstDir" \
            --prefix LD_LIBRARY_PATH : "$ICAInstDir:$ICAInstDir/lib:$ICAInstDir/usr/lib/x86_64-linux-gnu:$ICAInstDir/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/injected-bundle"
          ln -sf "$ICAInstDir/$prog" "$out/bin/$prog"
        done

        install -Dm644 "$ICAInstDir/icons/receiver.png" \
          "$out/share/icons/hicolor/256x256/apps/citrix-workstation.png"

        mkdir -p "$out/share/applications"
        cat > "$out/share/applications/citrix-workstation.desktop" <<EOF
        [Desktop Entry]
        Type=Application
        Name=Citrix Workstation
        Comment=Connect to remote Citrix sessions
        Exec=selfservice
        Icon=citrix-workstation
        Categories=Network;RemoteAccess;
        Terminal=false
        StartupNotify=true
        EOF
        sed -i 's/^        //' "$out/share/applications/citrix-workstation.desktop"

        runHook postInstall
      '';

      postFixup = ''
        webkit="$out/opt/citrix-icaclient/usr/lib/x86_64-linux-gnu"
        if [ -d "$webkit" ]; then
          for f in "$webkit"/libwebkit2gtk-4.0.so.*; do
            ${pkgs.lib.getExe pkgs.perl} -0777 -pi -e \
              's{/usr/lib/x86_64-linux-gnu/webkit2gtk-4.0/injected-bundle/}{"\0" x length($&)}e' \
              "$f"
          done
        fi

        autoPatchelf -- "$out"
      '';
    };
  in {
    home.packages = [citrix];
  };
}
