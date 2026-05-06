{inputs, ...}: {
  flake.modules.homeManager.program_fontconfig = {...}: {
    imports = with inputs.self.modules.homeManager; [
      fonts_dejavu
      fonts_font-awesome
      fonts_nerd-fonts
      fonts_twemoji
    ];

    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [
          "DejaVu Sans"
          "Twitter Color Emoji"
          "Font Awesome 6 Free"
          "Font Awesome 6 Brands"
          "Font Awesome 6 Free Solid"
        ];
        serif = [
          "DejaVu Serif"
          "Twitter Color Emoji"
          "Font Awesome 6 Brands"
          "Font Awesome 6 Free Regular"
          "Font Awesome 6 Free Solid"
        ];
        monospace = [
          "Hack Nerd Font Mono"
          "Twitter Color Emoji"
          "Font Awesome 6 Brands"
          "Font Awesome 6 Free Regular"
          "Font Awesome 6 Free Solid"
        ];
      };
    };

    # No HM option for per-font feature flags keep as raw config
    xdg.configFile."fontconfig/conf.d/99-hack-no-ligatures.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <!-- Disable ligatures for Hack to avoid ff, fi, ffi, etc. becoming only one character wide -->
        <match target="font">
          <test name="family" compare="eq" ignore-blanks="true">
            <string>Hack Nerd Font Mono</string>
          </test>
          <edit name="fontfeatures" mode="append">
            <string>liga off</string>
            <string>dlig off</string>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}
