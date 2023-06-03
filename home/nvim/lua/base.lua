
local vim = vim
local g = vim.g
local o = vim.o
local opt = vim.opt

o.expandtab = true
o.termguicolors = true

-- -- Do not save when switching buffers
-- o.hidden = true

-- -- Decrease update time
o.timeoutlen = 500
-- o.updatetime = 200

-- -- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.relativenumber = true
-- o.signcolumn = "yes"
o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
o.cmdheight = 1
o.showmatch = true
o.hlsearch = true

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
-- o.backup = false
-- o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

opt.mouse = "a"

vim.api.nvim_command("syntax enable") -- for rust
vim.api.nvim_command("filetype plugin indent on") -- for rust
vim.api.nvim_command("hi Normal guibg=NONE ctermbg=NONE") -- transparent background
-- vim.api.nvim_command('command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument') -- format on save


-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "

-- -- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g["rainbow_active"] = 1 -- color parenthesis

vim.g["rust_clip_command"] = 'xclip -selection clipboard' -- for rust

-- -- For dart server
vim.g["lsc_auto_map"] = true 
vim.g["dart_html_in_string"] = true 
vim.g["dart_style_guide"] = 2
vim.g["dart_format_on_save"] = 1




