{inputs, ...}: {
  flake.modules.nixos.role_home = {config, ...}: {
    imports = [
      (inputs.self.factory.homepage {
        environmentFiles = [config.sops.templates."homepage.env".path];

        settingsYAML = ''
          color: zinc
          theme: dark
          headerStyle: boxed
          target: _parent
          hideVersion: true
          statusStyle: basic
          bookmarksStyle: icons
          layout:
            Network:
              header: false
              style: row
              columns: 4
            Media:
              header: false
              style: row
              columns: 4
              iconsOnly: true
              Downloaders:
                header: false
              Arrs:
                header: false
              Playback:
                header: false
              Overview:
                header: false
            Local:
              header: false
              iconsOnly: true
            Developer:
              header: false
              iconsOnly: true
            Social:
              header: false
              iconsOnly: true
            Shopping:
              header: false
              iconsOnly: true
            Piracy:
              header: false
              iconsOnly: true
        '';

        services = [
          {
            Network = [
              {
                OPNSense = {
                  icon = "opnsense.png";
                  href = "https://opnsense.tfu.ac";
                  siteMonitor = "https://opnsense.tfu.ac";
                  widget = {
                    type = "opnsense";
                    url = "https://opnsense.tfu.ac";
                    username = "{{HOMEPAGE_VAR_OPNSENSE_USERNAME}}";
                    password = "{{HOMEPAGE_VAR_OPNSENSE_PASSWORD}}";
                  };
                };
              }
              {
                Unifi = {
                  icon = "unifi.png";
                  href = "https://nas.tfu.ac:8443";
                  siteMonitor = "https://nas.tfu.ac:8443";
                  widget = {
                    type = "unifi";
                    url = "https://nas.tfu.ac:8443";
                    username = "{{HOMEPAGE_VAR_UNIFI_USERNAME}}";
                    password = "{{HOMEPAGE_VAR_UNIFI_PASSWORD}}";
                  };
                };
              }
              {
                "Home Assistant" = {
                  icon = "home-assistant.png";
                  href = "https://homeassistant.tfu.ac";
                  siteMonitor = "https://homeassistant.tfu.ac";
                  widget = {
                    type = "homeassistant";
                    url = "https://homeassistant.tfu.ac";
                    key = "{{HOMEPAGE_VAR_HOMEASSISTANT_KEY}}";
                  };
                };
              }
              {
                Scrutiny = {
                  icon = "scrutiny.png";
                  href = "http://nas.tfu.ac:18080";
                  siteMonitor = "http://nas.tfu.ac:18080";
                  widget = {
                    type = "scrutiny";
                    url = "http://nas.tfu.ac:18080";
                  };
                };
              }
            ];
          }
          {
            Media = [
              {
                Downloaders = [
                  {
                    "Syncthing (Blackout)" = {
                      icon = "syncthing.png";
                      href = "http://blackout.tfu.ac:8384";
                      siteMonitor = "http://blackout.tfu.ac:8384";
                      widget = {
                        type = "customapi";
                        method = "GET";
                        url = "http://blackout.tfu.ac:8384/rest/svc/report";
                        headers = {
                          X-API-Key = "{{HOMEPAGE_VAR_SYNCTHING_BLACKOUT_KEY}}";
                        };
                        mappings = [
                          {field = "numDevices"; label = "Devices"; format = "number";}
                          {field = "numFolders"; label = "Folders"; format = "number";}
                          {field = "totFiles"; label = "Files"; format = "number";}
                          {field = "totMiB"; label = "MB"; format = "number";}
                        ];
                      };
                    };
                  }
                  {
                    Prowlarr = {
                      icon = "prowlarr.png";
                      href = "http://nas.tfu.ac:9696";
                      siteMonitor = "http://nas.tfu.ac:9696";
                      widget = {
                        type = "prowlarr";
                        url = "http://nas.tfu.ac:9696";
                        key = "{{HOMEPAGE_VAR_PROWLARR_KEY}}";
                      };
                    };
                  }
                  {
                    AutoBrr = {
                      icon = "autobrr.png";
                      href = "http://nas.tfu.ac:7474";
                      siteMonitor = "http://nas.tfu.ac:7474";
                      widget = {
                        type = "autobrr";
                        url = "http://nas.tfu.ac:7474";
                        key = "{{HOMEPAGE_VAR_AUTOBRR_KEY}}";
                      };
                    };
                  }
                  {
                    qBittorrent = {
                      icon = "qbittorrent.png";
                      href = "http://nas.tfu.ac:8585";
                      siteMonitor = "http://nas.tfu.ac:8585";
                      widget = {
                        type = "qbittorrent";
                        url = "http://nas.tfu.ac:7476/proxy/{{HOMEPAGE_VAR_QBITTORRENT_URL}}";
                      };
                    };
                  }
                ];
              }
              {
                Arrs = [
                  {
                    "Syncthing (NAS)" = {
                      icon = "syncthing.png";
                      href = "http://nas.tfu.ac:8384";
                      siteMonitor = "http://nas.tfu.ac:8384";
                      widget = {
                        type = "customapi";
                        method = "GET";
                        url = "http://nas.tfu.ac:8384/rest/svc/report";
                        headers = {
                          X-API-Key = "{{HOMEPAGE_VAR_SYNCTHING_NAS_KEY}}";
                        };
                        mappings = [
                          {field = "numDevices"; label = "Devices"; format = "number";}
                          {field = "numFolders"; label = "Folders"; format = "number";}
                          {field = "totFiles"; label = "Files"; format = "number";}
                          {field = "totMiB"; label = "MB"; format = "number";}
                        ];
                      };
                    };
                  }
                  {
                    Sonarr = {
                      icon = "sonarr.png";
                      href = "http://nas.tfu.ac:8989/calendar";
                      siteMonitor = "http://nas.tfu.ac:8989";
                      widget = {
                        type = "sonarr";
                        url = "http://nas.tfu.ac:8989";
                        key = "{{HOMEPAGE_VAR_SONARR_KEY}}";
                      };
                    };
                  }
                  {
                    Radarr = {
                      icon = "radarr.png";
                      href = "http://nas.tfu.ac:7878/calendar";
                      siteMonitor = "http://nas.tfu.ac:7878";
                      widget = {
                        type = "radarr";
                        url = "http://nas.tfu.ac:7878";
                        key = "{{HOMEPAGE_VAR_RADARR_KEY}}";
                      };
                    };
                  }
                ];
              }
              {
                Playback = [
                  {
                    "Syncthing (Foundry)" = {
                      icon = "syncthing.png";
                      href = "https://sync.tfu.io";
                      siteMonitor = "https://sync.tfu.io";
                      widget = {
                        type = "customapi";
                        method = "GET";
                        url = "https://sync.tfu.io/rest/svc/report";
                        headers = {
                          X-API-Key = "{{HOMEPAGE_VAR_SYNCTHING_FOUNDRY_KEY}}";
                        };
                        mappings = [
                          {field = "numDevices"; label = "Devices"; format = "number";}
                          {field = "numFolders"; label = "Folders"; format = "number";}
                          {field = "totFiles"; label = "Files"; format = "number";}
                          {field = "totMiB"; label = "MB"; format = "number";}
                        ];
                      };
                    };
                  }
                  {
                    Jellyfin = {
                      icon = "jellyfin.png";
                      href = "http://nas.tfu.ac:8096";
                      siteMonitor = "http://nas.tfu.ac:8096";
                      widget = {
                        type = "jellyfin";
                        url = "http://nas.tfu.ac:8096";
                        key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
                        enableBlocks = true;
                        enableNowPlaying = false;
                      };
                    };
                  }
                  {
                    AudioBookshelf = {
                      icon = "audiobookshelf.png";
                      href = "http://nas.tfu.ac:13378";
                      siteMonitor = "http://nas.tfu.ac:13378";
                      widget = {
                        type = "audiobookshelf";
                        url = "http://nas.tfu.ac:13378";
                        fields = ["books" "booksDuration"];
                        key = "{{HOMEPAGE_VAR_AUDIOBOOKSHELF_KEY}}";
                      };
                    };
                  }
                ];
              }
              {
                Overview = [
                  {
                    Calendar = {
                      widget = {
                        type = "calendar";
                        view = "agenda";
                        showTime = false;
                        maxEvents = 15;
                        integrations = [
                          {
                            type = "radarr";
                            service_group = "Arrs";
                            service_name = "Radarr";
                          }
                          {
                            type = "sonarr";
                            service_group = "Arrs";
                            service_name = "Sonarr";
                          }
                        ];
                      };
                    };
                  }
                ];
              }
            ];
          }
        ];

        widgets = [
          {
            resources = {
              cpu = true;
              memory = true;
              disk = "/";
            };
          }
        ];

        bookmarks = [
          {
            Local = [
              {LibreChat = [{abbr = "LC"; icon = "librechat.png"; href = "http://localhost:3080";}];}
              {ComfyUI = [{abbr = "CUI"; icon = "https://registry.npmmirror.com/@lobehub/icons-static-png/1.75.0/files/dark/comfyui-color.png"; href = "http://inferno.tfu.ac:8188/";}];}
              {Mealie = [{abbr = "ME"; icon = "mealie.png"; href = "http://192.168.1.10:9000";}];}
              {Immich = [{abbr = "IM"; icon = "immich.png"; href = "http://nas.tfu.ac:2283";}];}
              {Grafana = [{abbr = "GF"; icon = "http://nas.tfu.ac:3001/public/img/fav32.png"; href = "http://nas.tfu.ac:3001";}];}
            ];
          }
          {
            Developer = [
              {Gitlab = [{abbr = "GL"; icon = "gitlab.png"; href = "http://gitlab.com/ryanwalder";}];}
              {Github = [{abbr = "GH"; icon = "github.png"; href = "https://github.com/ryanwalder";}];}
            ];
          }
          {
            Social = [
              {YouTube = [{abbr = "YT"; icon = "youtube.png"; href = "https://www.youtube.com/feed/subscriptions";}];}
              {Twitter = [{abbr = "TW"; icon = "twitter.png"; href = "https://x.com";}];}
              {"Hacker News" = [{abbr = "HN"; icon = "https://news.ycombinator.com/y18.svg"; href = "https://news.ycombinator.com/";}];}
              {Facebook = [{abbr = "FB"; icon = "facebook.png"; href = "https://facebook.com";}];}
            ];
          }
          {
            Shopping = [
              {Amazon = [{abbr = "AZ"; icon = "https://www.amazon.co.uk/favicon.ico"; href = "https://www.amazon.co.uk";}];}
              {eBay = [{abbr = "EB"; icon = "https://www.ebay.com/favicon.ico"; href = "https://www.ebay.co.uk/sh/ovw";}];}
              {Deliveroo = [{abbr = "DR"; icon = "https://cwa.roocdn.com/_next/static/favicon-32x32.9ac59871.png"; href = "https://deliveroo.co.uk/restaurants/camberley/farnborough?fulfillment_method=DELIVERY&geohash=gcp7y9xzjjpp";}];}
              {"Just Eat" = [{abbr = "JE"; icon = "https://www.just-eat.co.uk/consumer-web/root-static/favicon-32x32.png"; href = "https://www.just-eat.co.uk/area/gu14-farnborough";}];}
              {Ocado = [{abbr = "OC"; icon = "https://www.ocado.com/favicon.ico"; href = "https://www.ocado.com/";}];}
            ];
          }
          {
            Piracy = [
              {"Pass the Popcorn" = [{abbr = "PtP"; icon = "https://passthepopcorn.me/favicon.ico"; href = "https://passthepopcorn.me";}];}
              {"Broadcast the Net" = [{abbr = "BtN"; icon = "https://broadcasthe.net/favicon.ico"; href = "https://broadcasthe.net";}];}
              {Redacted = [{abbr = "RED"; icon = "https://redacted.sh/static/favicon.ico"; href = "https://redacted.sh";}];}
              {Anthelion = [{abbr = "ANT"; icon = "https://anthelion.me/favicon.ico"; href = "https://anthelion.me";}];}
              {Nebulance = [{abbr = "NEB"; icon = "https://nebulance.io/favicon.ico"; href = "https://nebulance.io";}];}
              {"My Anonamouse" = [{abbr = "MaM"; icon = "https://sas.myanonamouse.net/favicon-32x32.png"; href = "https://www.myanonamouse.net/";}];}
              {Blutopia = [{abbr = "BLU"; icon = "https://blutopia.cc/favicon.ico"; href = "https://blutopia.cc";}];}
              {Darkpeers = [{abbr = "DRK"; icon = "https://darkpeers.org/favicon.ico"; href = "https://darkpeers.org";}];}
              {Empornium = [{abbr = "EMP"; icon = "https://www.empornium.sx/favicon.ico?v=1579037309"; href = "https://www.empornium.sx";}];}
            ];
          }
        ];

        customCSS = ''
          .bookmark-group {
            margin-top: 50px;
            margin-left: 20px;
          }

          .services-group + .bookmark-group {
            margin-left: 0 !important;
            padding-left: 0 !important;
          }

          #revalidate {
            visibility: hidden;
          }
        '';
      })
    ];

    sops.secrets = let
      sopsFile = "${inputs.self}/secrets/role/home.yaml";
    in {
      "homepage/opnsense_username" = {inherit sopsFile;};
      "homepage/opnsense_password" = {inherit sopsFile;};
      "homepage/unifi_username" = {inherit sopsFile;};
      "homepage/unifi_password" = {inherit sopsFile;};
      "homepage/homeassistant_key" = {inherit sopsFile;};
      "homepage/syncthing_blackout_key" = {inherit sopsFile;};
      "homepage/prowlarr_key" = {inherit sopsFile;};
      "homepage/autobrr_key" = {inherit sopsFile;};
      "homepage/qbittorrent_url" = {inherit sopsFile;};
      "homepage/syncthing_nas_key" = {inherit sopsFile;};
      "homepage/sonarr_key" = {inherit sopsFile;};
      "homepage/radarr_key" = {inherit sopsFile;};
      "homepage/syncthing_foundry_key" = {inherit sopsFile;};
      "homepage/jellyfin_key" = {inherit sopsFile;};
      "homepage/audiobookshelf_key" = {inherit sopsFile;};
    };

    sops.templates."homepage.env" = {
      content = ''
        HOMEPAGE_VAR_OPNSENSE_USERNAME=${config.sops.placeholder."homepage/opnsense_username"}
        HOMEPAGE_VAR_OPNSENSE_PASSWORD=${config.sops.placeholder."homepage/opnsense_password"}
        HOMEPAGE_VAR_UNIFI_USERNAME=${config.sops.placeholder."homepage/unifi_username"}
        HOMEPAGE_VAR_UNIFI_PASSWORD=${config.sops.placeholder."homepage/unifi_password"}
        HOMEPAGE_VAR_HOMEASSISTANT_KEY=${config.sops.placeholder."homepage/homeassistant_key"}
        HOMEPAGE_VAR_SYNCTHING_BLACKOUT_KEY=${config.sops.placeholder."homepage/syncthing_blackout_key"}
        HOMEPAGE_VAR_PROWLARR_KEY=${config.sops.placeholder."homepage/prowlarr_key"}
        HOMEPAGE_VAR_AUTOBRR_KEY=${config.sops.placeholder."homepage/autobrr_key"}
        HOMEPAGE_VAR_QBITTORRENT_URL=${config.sops.placeholder."homepage/qbittorrent_url"}
        HOMEPAGE_VAR_SYNCTHING_NAS_KEY=${config.sops.placeholder."homepage/syncthing_nas_key"}
        HOMEPAGE_VAR_SONARR_KEY=${config.sops.placeholder."homepage/sonarr_key"}
        HOMEPAGE_VAR_RADARR_KEY=${config.sops.placeholder."homepage/radarr_key"}
        HOMEPAGE_VAR_SYNCTHING_FOUNDRY_KEY=${config.sops.placeholder."homepage/syncthing_foundry_key"}
        HOMEPAGE_VAR_JELLYFIN_KEY=${config.sops.placeholder."homepage/jellyfin_key"}
        HOMEPAGE_VAR_AUDIOBOOKSHELF_KEY=${config.sops.placeholder."homepage/audiobookshelf_key"}
      '';
    };
  };
}
