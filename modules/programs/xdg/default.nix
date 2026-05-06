{...}: {
  flake.modules.homeManager.program_xdg = {config, ...}: {
    xdg.mimeApps.enable = true;
    xdg.userDirs.setSessionVariables = true;

    xdg.userDirs = {
      enable = true;
      createDirectories = false;
      desktop = "${config.home.homeDirectory}";
      download = "${config.home.homeDirectory}/downloads";
      templates = "${config.home.homeDirectory}";
      publicShare = "${config.home.homeDirectory}";
      documents = "${config.home.homeDirectory}";
      music = "/media/ftp/Music";
      pictures = "/media/backups/other/photos";
      videos = "${config.home.homeDirectory}";
    };
  };
}
