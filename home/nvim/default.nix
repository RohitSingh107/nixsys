{ pkgs, ... }: {

  home.file = {

    ".config/nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
    # ".config/nvim/snippets" = {
    #   source = ./snippets;
    #   recursive = true;
    # };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;

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
      nvim-treesitter
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

    local api = vim.api

    local core_conf_files = {
      "$HOME/.config/nvim/lua/base.lua", -- base settings
      "$HOME/.config/nvim/lua/autocmd.lua", -- Auto Commands settings
      "$HOME/.config/nvim/lua/mappings.lua", -- Custom Mappings
      "$HOME/.config/nvim/lua/coc-conf.lua", -- coc.nvim specific settings
      "$HOME/.config/nvim/lua/plugin-settings.lua", -- plugins specific settings
    }

    -- source all the core config files
    for _, name in ipairs(core_conf_files) do
      local path = name
      local source_cmd = "source " .. path
      vim.cmd(source_cmd)
    end

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
