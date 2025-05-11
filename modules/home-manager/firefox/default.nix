{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    enableGnomeExtensions = false; # need to set the NixOS option services.gnome.gnome-browser-connector.enable to true.
    # package = pkgs.firefox {
    #   # See nixpkgs' firefox/wrapper.nix to check which options you can use
    #   cfg = {
    #     # Gnome shell native connector
    #     enableGnomeExtensions = true;
    #     # Tridactyl native connector
    #     enableTridactylNative = true;
    #   };
    # };

    profiles = {
      rohit = {
        id = 0;
        isDefault = true;
        name = "Rohit Singh";
        search = {
          default = "ddg";
          force = true;
          order = [
            "ddg"
            "google"
          ];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              icon = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };

            "bing".metaData.hidden = true;
            "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
        bookmarks = {
          force = true;

          settings = [
            {
              name = "wikipedia";
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
            {
              name = "kernel.org";
              url = "https://www.kernel.org";
            }
            {
              name = "Opensuse Search Page";
              url = "https://search.opensuse.org/";
            }
            {
              name = "Nix sites";
              bookmarks = [
                {
                  name = "homepage";
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  url = "https://nixos.wiki/";
                }
                {
                  name = "Home Manager Appendix";
                  url = "https://nix-community.github.io/home-manager/options.xhtml";
                }
              ];
            }
          ];
        };
        settings = {
          # Force enable hardware acceleration
          "media.hardware-video-decoding.force-enabled" = true;
          "webgl.force-enabled" = true;
          "layers.acceleration.force-enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;

          "browser.bookmarks.addedImportButton" = false;
          # "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.bookmarks.showMobileBookmarks" = true;
          "browser.download.panel.shown" = true;
          "browser.newtabpage.pinned" = [
            {
              title = "NixOS";
              url = "https://nixos.org";
            }
          ];
          "browser.search.region" = "IN";
          "browser.search.isUS" = false;
          "browser.startup.page" = 3;
          "distribution.searchplugins.defaultLocale" = "en-GB";
          "dom.security.https_only_mode" = true;
          "general.useragent.locale" = "en-GB";
        };
        # extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        #   # privacy-badger
        #   firefox-color
        #   bitwarden
        #   ublock-origin
        #   duckduckgo-privacy-essentials
        # ];
        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          # privacy-badger
          firefox-color
          bitwarden
          ublock-origin
          duckduckgo-privacy-essentials
        ];
        extraConfig = ''
          /* Source file made available under Mozilla Public License v. 2.0 See the main repository for updates as well as full license text.
             https://github.com/Godiesc/opera-gx */

          /* Default rules */
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("svg.context-properties.content.enabled", true);
          user_pref("layout.css.color-mix.enabled", true);
          user_pref("browser.tabs.delayHidingAudioPlayingIconMS", 0);
          user_pref("layout.css.backdrop-filter.enabled", true);
          user_pref("browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar", false);

          /*To active container tabs without any extension */
          user_pref("privacy.userContext.enabled", true);
          user_pref("privacy.userContext.ui.enabled", true);
          user_pref("privacy.userContext.longPressBehavior", 2);
        '';

        # userChrome = ''
        # '';

        # userContent = ''
        #   '';
      };
    };
  };
}
