-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------


local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

local builtin = require('telescope.builtin')

-- Telescope Keybindings
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Toogle NVim Tree 
-- map("n", "<space-f>", "<CMD>NvimTreeToggle<CR>")
map('n', '<C-\\>', '<CMD>NvimTreeToggle<CR>')

-- Insert New lines below and above
map("n", "]<space>", "<CMD>set paste<CR>m`o<Esc>``:set nopaste<CR>")
map("n", "[<space>", "<CMD>set paste<CR>m`O<Esc>``:set nopaste<CR>")

-- Keybindings for telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
map("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")
--
-- -- Move selected line / block of text in visual mode
-- map("x", "K", ":move '<-2<CR>gv-gv")
-- map("x", "J", ":move '>+1<CR>gv-gv")

-- Copying the vscode behaviour of making tab splits
-- map('n', '<C-\\>', '<CMD>vsplit<CR>')
-- map('n', '<A-\\>', '<CMD>split<CR>')

-- Move line up and down in NORMAL and VISUAL modes
map('n', '<C-j>', '<CMD>move .+1<CR>')
map('n', '<C-k>', '<CMD>move .-2<CR>')
map('x', '<C-j>', ":move '>+1<CR>gv=gv")
map('x', '<C-k>', ":move '<-2<CR>gv=gv")



