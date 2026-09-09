
-- Native LSP (Neovim 0.12+). No lspconfig, no completion plugin.
--
-- Server definitions live in ~/.config/nvim/lsp/<name>.lua and are picked up
-- off the runtimepath. Which ones are actually started is decided in Nix by
-- `custom.nvim.languages.<lang>.enable` in each host profile, which appends the
-- matching vim.lsp.enable() call after this file.

local keyset = vim.keymap.set

-- Diagnostics are shown in the sign column, so pin it open to stop the text
-- jumping sideways every time one appears or clears.
vim.o.signcolumn = "yes"
vim.o.updatetime = 300
vim.o.winborder = "rounded"

-- "noselect" is required, not cosmetic: autotrigger completion otherwise selects
-- and inserts the first candidate as soon as the menu opens, so typing "os." and
-- carrying on gives you "os.CLD_CONTINUEDpath". Nothing is inserted until <C-y>.
-- "menuone" keeps the menu up when there is only one match, "popup" shows the
-- documentation preview for the selected item.
vim.o.completeopt = "menu,menuone,noselect,popup"

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { source = true },
})

local group = vim.api.nvim_create_augroup("UserLsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end

    -- Autocompletion, built in. <C-n>/<C-p> or Tab/S-Tab to move, <C-y> to accept.
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Highlight other references to the symbol under the cursor, as coc-highlight did.
    if client:supports_method("textDocument/documentHighlight") then
      local hl = vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = hl,
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = hl,
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Neovim already maps grn (rename), gra (code action), grr (references),
    -- gri (implementation), grt (type definition), gO (symbols), K (hover) and
    -- <C-s> (signature help). Only the gaps are mapped here.
    --
    -- <leader>f is the Telescope prefix, so formatting lives under <leader>l.
    local opts = { buffer = ev.buf, silent = true }
    keyset("n", "gd", vim.lsp.buf.definition, opts)
    keyset("n", "<leader>e", vim.diagnostic.open_float, opts)
  end,
})

-- <leader>lf formats with the language server when one can, and falls back to
-- neoformat otherwise. Pyright does not implement formatting, so Python lands
-- on neoformat's black (installed alongside pyright by the python toggle).
-- Mapped globally rather than on LspAttach so it also works in buffers with no
-- language server at all.
local function format(visual)
  local can_lsp_format = #vim.lsp.get_clients({
    bufnr = 0,
    method = "textDocument/formatting",
  }) > 0

  if can_lsp_format then
    vim.lsp.buf.format({ async = true })
  elseif visual then
    vim.cmd("'<,'>Neoformat")
  else
    vim.cmd("Neoformat")
  end
end

keyset("n", "<leader>lf", function()
  format(false)
end, { silent = true, desc = "Format buffer" })

keyset("x", "<leader>lf", function()
  -- leave visual mode first so '< and '> are set
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  format(true)
end, { silent = true, desc = "Format selection" })

-- Detach the buffer-local highlight autocmds when a client goes away.
vim.api.nvim_create_autocmd("LspDetach", {
  group = group,
  callback = function(ev)
    vim.lsp.buf.clear_references()
    pcall(vim.api.nvim_clear_autocmds, { group = "UserLspHighlight", buffer = ev.buf })
  end,
})

-- Let Tab walk the completion popup, but stay a plain Tab when it is closed.
keyset("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

keyset("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })
