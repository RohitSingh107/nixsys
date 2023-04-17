{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [

      telescope-nvim
      which-key-nvim
      vim-airline #vim
      vim-airline-themes #vim
      dracula-nvim
      gruvbox-nvim
      nvim-colorizer-lua
      comment-nvim
      nvim-web-devicons
      vim-devicons #vim
      nvim-tree-lua


      ## Coc Extensions
      coc-json
      coc-snippets

      ## Coding
      vim-snippets #vim
      vim-visual-multi #vim

      ## Beautification
      nvim-treesitter
      indent-blankline-nvim
      nvim-ts-rainbow2
    ];

    extraPackages = [ pkgs.shfmt ];

    extraLuaConfig = ''

    local api = vim.api

    local core_conf_files = {
      "$NIXOS_CONFIG_DIR/home/nvim/lua/base.lua", -- base settings
      "$NIXOS_CONFIG_DIR/home/nvim/lua/autocmd.lua", -- Auto Commands settings
      "$NIXOS_CONFIG_DIR/home/nvim/lua/mappings.lua", -- Custom Mappings
      "$NIXOS_CONFIG_DIR/home/nvim/lua/coc-conf.lua", -- coc.nvim specific settings
      "$NIXOS_CONFIG_DIR/home/nvim/lua/plugin-settings.lua", -- plugins specific settings
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
        "snippets.userSnippetsDirectory" = "/home/rohits/nixsys/home/nvim/snippets";
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
