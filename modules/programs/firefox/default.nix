{...}: {
  flake.modules.homeManager.program_firefox = {config, ...}: {
    xdg.mimeApps.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
    };

    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";

      profiles.home = {
        id = 0;
        name = "home";
        isDefault = true;

        search = {
          force = true;
          default = "Kagi";

          engines."Kagi".urls = [
            {
              template = "https://kagi.com/search?q={searchTerms}";
            }
          ];
        };

        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.homepage" = "http://localhost:3000";
          "browser.startup.page" = 3;
          "browser.sessionstore.restore_on_demand" = false;
          "browser.sessionstore.max_windows_undo" = 10;
          "browser.aboutwelcome.enabled" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.download.alwaysOpenPanel" = false;
          "browser.formfill.enable" = false;
          "browser.tabs.insertRelatedAfterCurrent" = false;
          "browser.tabs.warnOnClose" = false;
          "browser.tabs.warnOnCloseOtherTabs" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.suggest.topsites" = false;
          "extensions.ui.locale.hidden" = true;
          "media.autoplay.default" = 5;
          "privacy.donottrackheader.enabled" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "sidebar.visibility" = true;
          "signon.autofillForms" = false;
          "signon.rememberSignons" = false;
          "widget.use-xdg-desktop-portal.file-picker" = 2;
          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [];
              unified-extensions-area = [
                "_idk-what-this-means-browser-action"
                "gdpr_cavi_au_dk-browser-action"
                "_e4a8a97b-f2ed-450b-b12d-ee082ba24781_-browser-action"
                "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
                "addon_darkreader_org-browser-action"
                "_ddc359d1-844a-42a7-9aa1-88a850a938a8_-browser-action"
                "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"
              ];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "vertical-spacer"
                "urlbar-container"
                "search-container"
                "downloads-button"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                "ublock0_raymondhill_net-browser-action"
                "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
                "unified-extensions-button"
              ];
              toolbar-menubar = ["menubar-items"];
              TabsToolbar = [
                "tabbrowser-tabs"
                "new-tab-button"
                "alltabs-button"
              ];
              vertical-tabs = [];
              PersonalToolbar = [
                "import-button"
                "personal-bookmarks"
              ];
            };
            seen = [
              "developer-button"
              "_idk-what-this-means-browser-action"
              "gdpr_cavi_au_dk-browser-action"
              "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_e4a8a97b-f2ed-450b-b12d-ee082ba24781_-browser-action"
              "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
              "addon_darkreader_org-browser-action"
              "_ddc359d1-844a-42a7-9aa1-88a850a938a8_-browser-action"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"
              "screenshot-button"
            ];
            dirtyAreaCache = [
              "nav-bar"
              "vertical-tabs"
              "unified-extensions-area"
              "PersonalToolbar"
              "toolbar-menubar"
              "TabsToolbar"
            ];
            currentVersion = 23;
            newElementCount = 6;
          };
        };
      };

      policies = {
        DefaultDownloadDirectory = "\${home}/downloads";

        ExtensionSettings = {
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
            default_area = "navbar";
            private_browsing = true;
          };
          # ClearURLs
          "{74145f27-f039-47ce-a470-a662b129930a}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # Consent-O-Matic
          "gdpr@cavi.au.dk" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # Custom New Tab Page
          "custom-new-tab-page@mint.as" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/custom-new-tab-page/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # Dark Reader
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # DownThemAll!
          "{DDC359D1-844A-42a7-9AA1-88A850A938A8}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/downthemall/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # Greasemonkey
          "{e4a8a97b-f2ed-450b-b12d-ee082ba24781}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/greasemonkey/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # HistoryBlock
          "historyblock@kain" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/historyblock/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # LocalCDN
          "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # Old Reddit Redirect
          "{9063c2e4-e07c-4c2c-9646-cfe7ca8d0571}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/old-reddit-redirect/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # Privacy Badger
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # SponsorBlock
          "sponsor@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
          # YouTube List View
          "@idk-what-this-means" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtubelistview/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          };
        };
      };
    };
  };
}
