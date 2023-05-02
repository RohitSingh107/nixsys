{ pkgs, ... }: {
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
          default = "DuckDuckGo";
          force = true;
          order = [
            "DuckDuckGo"
            "Google"
          ];
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
        bookmarks = [
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
            ];
          }
        ];

        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #   privacy-badger
        # ];
        # extraConfig = "";

        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.search.region" = "IN";
          "browser.search.isUS" = false;
          "distribution.searchplugins.defaultLocale" = "en-GB";
          "general.useragent.locale" = "en-GB";
          "browser.bookmarks.showMobileBookmarks" = true;
          "browser.newtabpage.pinned" = [{
            title = "NixOS";
            url = "https://nixos.org";
          }];
        };

        userChrome = ''
          /* Hide tab bar in FF Quantum */
          @-moz-document url("chrome://browser/content/browser.xul") {
            #TabsToolbar {
              visibility: collapse !important;
              margin-bottom: 21px !important;
            }
  
            #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
              visibility: collapse !important;
            }
          }
        '';

        userContent = ''
          /* Hide scrollbar in FF Quantum */
          *{scrollbar-width:none !important}
        '';



      };
    };

  };
}
