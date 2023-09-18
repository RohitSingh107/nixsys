{ pkgs, ... }: {

  home.file = {

    ".config/nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    ".config/nvim/snippets" = {
      source = ./snippets;
      recursive = true;
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [

      telescope-nvim
      which-key-nvim
      vim-airline #vim
      vim-airline-themes #vim
      nvim-colorizer-lua
      comment-nvim
      nvim-web-devicons
      vim-devicons #vim
      nvim-tree-lua

      ## Color themes
      catppuccin-nvim
      gruvbox-nvim
      dracula-nvim

      ## Coding
      vim-snippets #vim
      vim-visual-multi #vim

      ## Beautification
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-yaml
          p.tree-sitter-toml
          p.tree-sitter-fish
          p.tree-sitter-haskell
          p.tree-sitter-regex
          p.tree-sitter-html
          p.tree-sitter-sql
          # p.tree-sitter-latex
          # p.tree-sitter-rust
          # p.tree-sitter-c
          # p.tree-sitter-go
          # p.tree-sitter-tsx
          # p.tree-sitter-typescript
        ]));
        # config = toLuaFile ./nvim/plugin/treesitter.lua;
      }
      indent-blankline-nvim
      nvim-ts-rainbow2


      ## Coc Extensions
      coc-json
      coc-snippets
      coc-clangd
      coc-emmet
      coc-eslint
      # coc-flutter
      coc-highlight
      coc-html
      coc-json
      coc-pairs
      coc-prettier
      coc-pyright
      coc-rust-analyzer
      # coc-tabnine
      coc-tsserver
      # coc-vimlsp
      coc-sh
      coc-lua
      coc-markdownlint
      # coc-tailwindcss
      # coc-stylelint



    ];

    extraPackages = [
      pkgs.shfmt
    ];

    extraLuaConfig = ''

      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/autocmd.lua}
      ${builtins.readFile ./lua/mappings.lua}
      ${builtins.readFile ./lua/coc-conf.lua}
      ${builtins.readFile ./lua/plugin-settings.lua}

    '';


    coc = {
      enable = true;
      settings = {
        "snippets.userSnippetsDirectory" = "~/.config/nvim/snippets";
        "prettier.printWidth" = 80;
        "coc.preferences.formatOnSaveFiletypes" = [
          "css"
          "markdown"
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
          "json"
          "html"
          "solidity"
          "cpp"
          "c++"
        ];

        languageserver = {
          haskell = {
            command = "haskell-language-server-wrapper";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            filetypes = [
              "haskell"
              "lhaskell"
            ];
            settings = {
              haskell = {
                checkParents = "CheckOnSave";
                checkProject = true;
                maxCompletions = 40;
                formattingProvider = "ormolu";
                plugin = {
                  stan = {
                    globalOn = true;
                  };
                };
              };
            };
          };
          nix = {
            command = "rnix-lsp";
            filetypes = [ "nix" ];
          };
        };
        "snippets.ultisnips.pythonPrompt" = false;
        "pyright.enable" = true;
        "python.linting.mypyEnabled" = true;
      };
    };
  };



}
