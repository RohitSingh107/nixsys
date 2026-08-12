{pkgs, ...}: {
  programs.cursor = {
    enable = true;

    # pkgs.code-cursor is the Cursor editor (unfree). The host profile importing
    # this module needs nixpkgs.config.allowUnfree.
    package = pkgs.code-cursor;

    # Cursor's marketplace/extension UI stays usable: extensions declared below
    # are copied into a writable ~/.cursor/extensions, and anything installed
    # from inside Cursor survives a switch. Flip to false (and drop the
    # marketplace habit) if you want the extension set fully declarative.
    mutableExtensionsDir = true;

    # ~/.cursor/argv.json -- Electron-level flags, read before the window opens.
    argvSettings = {
      # Fedora/GNOME keyring backs Cursor's account tokens instead of the
      # plaintext fallback store.
      password-store = "gnome-libsecret";
      enable-crash-reporter = false;
    };

    profiles.default = {
      # The Nix store copy is read-only, so let the flake do the updating.
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        # Nix: nil LSP + alejandra, wired up in userSettings below.
        jnoortheen.nix-ide
        # Picks up flake devShells so language servers resolve per project.
        mkhl.direnv
        # Same modal muscle memory as the neovim config.
        vscodevim.vim
        editorconfig.editorconfig
        usernamehw.errorlens
        eamodio.gitlens
        esbenp.prettier-vscode
        timonwong.shellcheck
        tamasfe.even-better-toml
        haskell.haskell
        # Matches kitty's Dracula theme.
        dracula-theme.theme-dracula
        pkief.material-icon-theme
      ];

      # ~/.cursor/User/settings.json
      userSettings = {
        # -- Appearance -------------------------------------------------------
        "workbench.colorTheme" = "Dracula Theme";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "editor.fontFamily" = "'Fantasque Sans Mono', 'Fira Code Nerd Font', monospace";
        "editor.fontSize" = 16;
        "editor.lineHeight" = 1.4;
        "terminal.integrated.fontSize" = 15;
        "window.titleBarStyle" = "custom";
        "window.menuBarVisibility" = "toggle";

        # -- Editor behaviour -------------------------------------------------
        "files.autoSave" = "onFocusChange";
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "editor.formatOnSave" = true;
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.renderWhitespace" = "boundary";
        "editor.rulers" = [80 120];
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "editor.detectIndentation" = true;
        "explorer.confirmDragAndDrop" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;

        # -- Terminal ---------------------------------------------------------
        # Fish is the shell everywhere else in this flake.
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.profiles.linux".fish.path = "${pkgs.fish}/bin/fish";

        # -- Nix --------------------------------------------------------------
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
        "nix.serverSettings".nil.formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--quiet" "--"];
        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };

        # -- Per-language -----------------------------------------------------
        "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[yaml]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[markdown]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.wordWrap" = "on";
          "editor.rulers" = [];
        };
        "[haskell]"."editor.tabSize" = 2;

        # -- Vim mode ---------------------------------------------------------
        "vim.leader" = "<space>";
        "vim.useSystemClipboard" = true;
        "vim.hlsearch" = true;
        "vim.incsearch" = true;
        "vim.highlightedyank.enable" = true;
        # Ctrl-c/v/f keep their VS Code meaning instead of being swallowed by vim.
        "vim.handleKeys" = {
          "<C-c>" = false;
          "<C-v>" = false;
          "<C-f>" = false;
        };
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            before = ["<leader>" "w"];
            commands = ["workbench.action.files.save"];
          }
          {
            before = ["<leader>" "e"];
            commands = ["workbench.view.explorer"];
          }
          {
            before = ["<leader>" "f"];
            commands = ["workbench.action.quickOpen"];
          }
          {
            before = ["<leader>" "/"];
            commands = ["workbench.action.findInFiles"];
          }
          {
            before = ["<leader>" "h"];
            commands = [":nohl"];
          }
        ];

        # -- Telemetry --------------------------------------------------------
        "telemetry.telemetryLevel" = "off";
        "redhat.telemetry.enabled" = false;
        "gitlens.telemetry.enabled" = false;
      };

      # ~/.cursor/User/keybindings.json
      keybindings = [
        {
          key = "ctrl+shift+e";
          command = "workbench.view.explorer";
        }
        {
          key = "ctrl+`";
          command = "workbench.action.terminal.toggleTerminal";
        }
        {
          key = "ctrl+shift+f";
          command = "workbench.action.findInFiles";
        }
      ];

      # ~/.cursor/User/tasks.json -- the two commands this flake is driven with.
      userTasks = {
        version = "2.0.0";
        tasks = [
          {
            label = "nix fmt";
            type = "shell";
            command = "nix fmt";
            problemMatcher = [];
            group = "build";
          }
          {
            label = "home-manager switch (fedora)";
            type = "shell";
            command = "home-manager switch --flake .#rohit@fedora";
            problemMatcher = [];
            group = "build";
          }
          {
            label = "nix flake check";
            type = "shell";
            command = "nix flake check";
            problemMatcher = [];
            group = "test";
          }
        ];
      };

      globalSnippets = {
        fixme = {
          prefix = ["fixme"];
          body = ["$LINE_COMMENT FIXME: $0"];
          description = "Insert a FIXME remark";
        };
      };
    };
  };

  # Editor font, so this module doesn't lean on kitty.nix pulling it in.
  home.packages = [pkgs.fantasque-sans-mono];
}
