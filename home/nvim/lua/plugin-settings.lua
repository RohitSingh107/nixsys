
-- Dracula Colorscheme
vim.api.nvim_command("colorscheme dracula") -- colorscheme
vim.api.nvim_command("hi Normal guibg=NONE ctermbg=NONE") -- transparent background

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
    dotfiles = true,
  },
})
require'nvim-web-devicons'.get_icons()


-- Vim Airline settings
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#left_sep"] = ' '
vim.g["airline#extensions#tabline#left_alt_sep"] = '|'
vim.g["airline#extensions#tabline#formatter"] = 'unique_tail'





-- https://gitlab.com/HiPhish/nvim-ts-rainbow2
require('nvim-treesitter.configs').setup {
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  }
}



-- Indent Blankline
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅" -- fill indent space
-- vim.opt.listchars:append "eol:↴" -- show where line ends

require("indent_blankline").setup {
    -- show_current_context = true,
    -- show_current_context_start = true,
    space_char_blankline = " ",
    show_end_of_line = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
--



-- -- Treesitter
-- require'nvim-treesitter.configs'.setup {
--   -- A list of parser names, or "all" (the four listed parsers should always be installed)
--   ensure_installed = { "c", "lua", "vim", "help" },
--
--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,
--
--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   auto_install = true,
--
--   -- List of parsers to ignore installing (for "all")
--   ignore_install = { "javascript" },
--
--   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--   -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
--
--   highlight = {
--     enable = true,
--
--     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--     -- the name of the parser)
--     -- list of language that will be disabled
--     disable = { "c", "rust" },
--     -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
--     disable = function(lang, buf)
--         local max_filesize = 100 * 1024 -- 100 KB
--         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--         if ok and stats and stats.size > max_filesize then
--             return true
--         end
--     end,
--
--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
-- }







