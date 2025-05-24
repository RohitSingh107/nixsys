{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    # package = pkgs.vscodium;

    profiles = {
      default = {
        enableExtensionUpdateCheck = true;
        enableUpdateCheck = true;

        extensions = [
          pkgs.vscode-extensions.esbenp.prettier-vscode
          pkgs.vscode-extensions.haskell.haskell
        ];
        globalSnippets = {
          fixme = {
            body = [
              "$LINE_COMMENT FIXME: $0"
            ];
            description = "Insert a FIXME remark";
            prefix = [
              "fixme"
            ];
          };
        };

        languageSnippets = {
          haskell = {
            fixme = {
              body = [
                "$LINE_COMMENT FIXME: $0"
              ];
              description = "Insert a FIXME remark";
              prefix = [
                "fixme"
              ];
            };
          };
        };

        userSettings = {
          "files.autoSave" = "off";
          "[nix]"."editor.tabSize" = 2;
        };

        keybindings = [
          {
            key = "ctrl+c";
            command = "editor.action.clipboardCopyAction";
            when = "textInputFocus";
          }
        ];
      };
    };

    haskell = {
      enable = true;
      hie = {
        enable = false;
      };
    };

    mutableExtensionsDir = false;
  };
}
