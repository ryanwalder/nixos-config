{ inputs, ... }: {
  flake.modules.nixos.ryan = { ... }: {
    users.users.ryan = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjoBnlkUwn8uJVVr+2xHTAkmVPi3+KrMdK1ZLypKbb0lTAu3UIjzAE0tcblo5bCER1jBzE3GfT0RHGvYHaLoVuuqcbZ5vYdPGopHRwHXWizyT87jrCO7Sljpbtaz7cWaFN1DvCvL+ppJS4DcylAaBbyBzGCfotVIW5YxIbJTH9ed1OiSxKgkae5zycWCPaZ3db7H6Q0TpMDMf3seCXDad6H9oTKIwOm1ZjTlCI9rms1+SEzNy90OTU0dz+lUQ6v2aHF/R4zJ0uqLkaMe9kSsu+UM/h///2OejYIo6SKQ929KyKiH+Au78gvewo584NNgIdMe9rreudGZokWnfNqd/ZgiNkU5KVpMzXqZ/SK3czP3yenCHYNQdvQhaMmUktVrijOXWHYO/rugSosf7VxZnb7xWQp6n0iG3//g88sWDmDlXojXsKC1U1792rxATI1gK/4gfrJtJTTLM68DHL8j1AVXPFORS+fud1dy1qfnoyfotHcjz3gw/rd3b4Knc7leNNPqNY2ai1TKofFnQfqjukba7yZkE2ojo3dy2eoP2ogSBcXHJoG7TLC7mM2Sjzyf2A7OYvTupJLsiK5GspEPY6sbydH/vBujPuMe9+mCZ3Azt8kPzBLtkDNnaZE4Xm5N3KMzKQKX8L4QFbANipPOyXzAYNb5uhEClWzsXiJKIidQ== YUBIKEY-PERSONAL-A"
      ];
    };

    home-manager.users.ryan.imports = [ inputs.self.modules.homeManager.ryan ];
  };

  flake.modules.homeManager.ryan = {
    home.username = "ryan";
    home.stateVersion = "25.11";
  };
}
