{ ... }: {
  flake.modules.homeManager.program_konsole = { pkgs, ... }: {
    home.packages = [ pkgs.kdePackages.konsole ];

    xdg.configFile."konsolerc".text = ''
      [Desktop Entry]
      DefaultProfile=Default.profile

      [MainWindow]
      MenuBar=Disabled
      StatusBar=Disabled
      ToolBarsMovable=Disabled

      [TabBar]
      TabBarVisibility=AlwaysHideTabBar

      [Toolbar mainToolBar]
      Hidden=true
    '';

    home.file.".local/share/konsole/Default.profile".text = ''
      [Appearance]
      ColorScheme=Custom
      Font=Hack Nerd Font Mono,13,-1,5,50,0,0,0,0,0
      BoldIntense=true

      [General]
      Name=Default
      Parent=FALLBACK/
      ShowTerminalSizeHint=false

      [Scrolling]
      HistoryMode=2
      HistorySize=10000
      ScrollBarPosition=2

      [Terminal Features]
      BellMode=2
    '';

    home.file.".local/share/konsole/Custom.colorscheme".text = ''
      [Background]
      Color=0,0,0

      [BackgroundIntense]
      Color=0,0,0

      [Foreground]
      Color=238,238,236

      [ForegroundIntense]
      Color=238,238,236

      [Color0]
      Color=0,0,0

      [Color0Intense]
      Color=85,87,83

      [Color1]
      Color=204,0,0

      [Color1Intense]
      Color=239,41,41

      [Color2]
      Color=78,154,6

      [Color2Intense]
      Color=138,226,52

      [Color3]
      Color=196,160,0

      [Color3Intense]
      Color=252,233,79

      [Color4]
      Color=52,101,164

      [Color4Intense]
      Color=114,159,207

      [Color5]
      Color=117,80,123

      [Color5Intense]
      Color=173,127,168

      [Color6]
      Color=6,152,154

      [Color6Intense]
      Color=52,226,226

      [Color7]
      Color=211,215,207

      [Color7Intense]
      Color=238,238,236

      [General]
      Description=Custom
      Opacity=1
    '';
  };
}
