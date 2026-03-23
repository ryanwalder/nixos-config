{ ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      python.disabled = true;
      package.disabled = true;
    };
  };
}
