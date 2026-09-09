
-- The colorscheme, statusline and bufferline live in theme.lua.

--  Which Key
vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
}


-- Colorizer lua
require 'colorizer'.setup()


-- numToStr Comment.nvim
require('Comment').setup()

-- Nvim dev web icons
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}

-- NVIM Tree lua setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,

  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,

  },
})
require'nvim-web-devicons'.get_icons()



-- Treesitter highlight/indent is built-in since Neovim 0.10+ with nvim-treesitter 1.0+
-- Parsers are installed via Nix (withPlugins), no setup call needed



-- Indent Blankline
vim.opt.termguicolors = true

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅" -- fill indent space
-- vim.opt.listchars:append "eol:↴" -- show where line ends



-- -- Indent Blankline
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    -- Catppuccin Mocha: red, yellow, blue, peach, green, mauve, teal.
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94e2d5" })
end)

require("ibl").setup { indent = { highlight = highlight } }
-- ibl




-- Telescope
require('telescope').setup({
	extensions = {
    	fzf = {
      	fuzzy = true,                    -- false will only do exact matching
      	override_generic_sorter = true,  -- override the generic sorter
      	override_file_sorter = true,     -- override the file sorter
      	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    	}
  	}
})

require('telescope').load_extension('fzf')




-- Neoformat
-- Formatting is reached through <leader>lf in lua/lsp.lua, which only falls
-- back to neoformat when the language server cannot format the buffer.
-- black is installed by the `custom.nvim.languages.python` toggle; pinning the
-- list stops neoformat from probing yapf/autopep8/isort first.
vim.g.neoformat_enabled_python = { "black" }

-- Leave the buffer untouched if no formatter is actually installed.
vim.g.neoformat_only_msg_on_error = 1
