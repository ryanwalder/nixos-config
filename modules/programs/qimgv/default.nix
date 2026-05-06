{...}: {
  flake.modules.homeManager.program_qimgv = {pkgs, ...}: {
    home.packages = with pkgs; [
      qimgv
    ];

    xdg.mimeApps.defaultApplications = {
      "image/avif" = "qimgv.desktop";
      "image/apng" = "qimgv.desktop";
      "image/bmp" = "qimgv.desktop";
      "image/gif" = "qimgv.desktop";
      "image/jpeg" = "qimgv.desktop";
      "image/png" = "qimgv.desktop";
      "image/svg+xml" = "qimgv.desktop";
      "image/tiff" = "qimgv.desktop";
      "image/vnd.wap.wbmp" = "qimgv.desktop";
      "image/webp" = "qimgv.desktop";
    };
  };
}
