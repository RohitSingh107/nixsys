{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    # package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.esbenp.prettier-vscode
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

    haskell = {
      enable = true;
      hie = {
        enable = true;
      };
    };
    keybindings = [
      {
        key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
        when = "textInputFocus";
      }
    ];

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
    mutableExtensionsDir = false;
    userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
    };
  };


}
