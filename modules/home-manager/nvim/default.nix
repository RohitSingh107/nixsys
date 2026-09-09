{
  pkgs,
  lib,
  config,
  ...
}: let
  # Every language Neovim knows how to talk to. Adding one here is enough:
  # it declares the option, installs the server and emits vim.lsp.enable().
  # The matching server definition lives in ./lsp/<server>.lua.
  #
  # These are language *servers*, not toolchains. gopls shells out to `go`,
  # rust-analyzer to `cargo`, and hls needs a matching GHC; without them on
  # PATH the server attaches but reports no results. Get the toolchain from the
  # project (devenv/nix develop) and launch Neovim inside it.
  servers = {
    python = {
      server = "pyright";
      # pyright type-checks but cannot format, so black comes along to give
      # <leader>lf something to do in Python buffers (via neoformat).
      packages = [pkgs.pyright pkgs.black];
    };
    go = {
      server = "gopls";
      packages = [pkgs.gopls];
    };
    rust = {
      server = "rust_analyzer";
      packages = [pkgs.rust-analyzer];
    };
    haskell = {
      server = "hls";
      packages = [pkgs.haskell-language-server];
    };
  };

  # Languages switched on by this host. Everything is off by default.
  enabled = lib.filterAttrs (lang: _: config.custom.nvim.languages.${lang}.enable) servers;

  enabledServers = lib.mapAttrsToList (_: s: s.server) enabled;
  enabledPackages = lib.concatMap (s: s.packages) (lib.attrValues enabled);

  # vim.lsp.enable({}) is a harmless no-op, so no special case when all are off.
  lspEnable = ''
    vim.lsp.enable({${lib.concatMapStringsSep ", " (s: "\"${s}\"") enabledServers}})
  '';
in {
  options.custom.nvim.languages =
    lib.mapAttrs (lang: _: {
      enable = lib.mkEnableOption "the ${lang} language server in Neovim";
    })
    servers;

  config = {
    home.file = {
      ".config/nvim/snippets" = {
        source = ./snippets;
        recursive = true;
      };
      # Server definitions are read off the runtimepath by vim.lsp.enable().
      # Shipping all of them is inert; only the enabled ones are ever started.
      ".config/nvim/lsp" = {
        source = ./lsp;
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
        nvim-colorizer-lua
        comment-nvim
        nvim-web-devicons
        nvim-tree-lua
        telescope-fzf-native-nvim

        ## Statusline and bufferline, both configured in lua/theme.lua
        lualine-nvim
        bufferline-nvim

        ## Color themes
        catppuccin-nvim
        gruvbox-nvim
        dracula-nvim

        ## Coding
        vim-snippets # vim
        vim-visual-multi # vim
        friendly-snippets
        neoformat

        ## Beautification
        {
          plugin = nvim-treesitter.withPlugins (p: [
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
            p.tree-sitter-elixir
            p.tree-sitter-erlang
            # p.tree-sitter-latex
            # p.tree-sitter-rust
            # p.tree-sitter-c
            # p.tree-sitter-go
            # p.tree-sitter-tsx
            # p.tree-sitter-typescript
          ]);
          # config = toLuaFile ./nvim/plugin/treesitter.lua;
        }
        indent-blankline-nvim
        # nvim-ts-rainbow2 # Depricated
        rainbow-delimiters-nvim
      ];

      extraPackages = with pkgs; [shfmt xclip wl-clipboard] ++ enabledPackages;

      withRuby = false;
      withPython3 = false;

      initLua = ''

        ${builtins.readFile ./lua/options.lua}
        ${builtins.readFile ./lua/theme.lua}
        ${builtins.readFile ./lua/autocmd.lua}
        ${builtins.readFile ./lua/mappings.lua}
        ${builtins.readFile ./lua/lsp.lua}
        ${builtins.readFile ./lua/plugin-settings.lua}

        ${lspEnable}
      '';
    };
  };
}
