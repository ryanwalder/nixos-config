{ ... }: {
  config.flake.factory.syncthing =
    {
      user,
      devices ? { },
      folders ? { },
      options ? { },
    }:
    {
      services.syncthing = {
        enable = true;
        inherit user;
        dataDir = "/home/${user}";
        configDir = "/home/${user}/.config/syncthing";
        settings = {
          inherit devices folders options;
        };
      };
    };
}
