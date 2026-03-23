{...}: {
  programs.mpv = {
    enable = true;

    config = {
      vo = "gpu";
      gpu-api = "opengl";
      hwdec-codecs = "all";
      cache-default = "600 M";
      demuxer-readahead-secs = 1800;
      cache = 20480;
      cache-seek-min = 20480;
      demuxer-max-bytes = "4GB";
      cache-pause = "no";
    };

    bindings = {
      WHEEL_UP = "add volume 2";
      WHEEL_DOWN = "add volume -2";
      WHEEL_LEFT = "seek -10";
      WHEEL_RIGHT = "seek 10";
    };
  };
}
