{...}: {
  flake.modules.homeManager.program_starship = {...}: {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = false;
        scan_timeout = 1000;
        python.disabled = true;
        package.disabled = true;
      };
    };
  };
}
