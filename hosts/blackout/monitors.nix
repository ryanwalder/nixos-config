{ pkgs, ... }: {
  services.xserver.xrandrHeads = [
    {
      output = "DP-4";
      monitorConfig = ''
        Option "PreferredMode" "2560x1440"
        Option "Position" "0 0"
        Option "Rotate" "right"
        Option "DPI" "96 x 96"
      '';
    }
    {
      output = "DP-0";
      primary = true;
      monitorConfig = ''
        Option "PreferredMode" "3440x1440"
        Option "Position" "1440 650"
        Option "Rotate" "normal"
        Option "DPI" "96 x 96"
        Option "TargetRefresh" "165"
      '';
    }
    {
      output = "DP-2";
      monitorConfig = ''
        Option "PreferredMode" "2560x1440"
        Option "Position" "4880 650"
        Option "Rotate" "normal"
        Option "DPI" "96 x 96"
      '';
    }
  ];
}
