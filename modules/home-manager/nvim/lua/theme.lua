-------------------------------------------------
-- THEME
-------------------------------------------------
-- Everything that decides how the editor *looks*: the colorscheme, the
-- statusline and the bufferline. Sourced right after options.lua, because the
-- colorscheme has to exist before any plugin reads its highlight groups.

-- Catppuccin --------------------------------------------------------------
-- default_integrations covers nvim-tree, telescope, indent-blankline,
-- rainbow-delimiters, gitsigns and mini already; only which-key has to be
-- asked for. There is no treesitter or native_lsp key in catppuccin 2.x --
-- treesitter is unconditional and LSP styling moved to lsp_styles.
require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true, -- replaces the old `hi Normal guibg=NONE`
  term_colors = true,
  integrations = {
    which_key = true,
  },
  lsp_styles = {
    underlines = {
      errors = { "undercurl" },
      warnings = { "undercurl" },
      hints = { "undercurl" },
      information = { "undercurl" },
    },
  },
}

vim.cmd.colorscheme "catppuccin"

local C = require("catppuccin.palettes").get_palette "mocha"

-- Lualine -----------------------------------------------------------------
require("lualine").setup {
  options = {
    -- Registered as catppuccin-<flavour>; the bare "catppuccin" name does not
    -- exist on the runtimepath.
    theme = "catppuccin-mocha",
    icons_enabled = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    globalstatus = true, -- one statusline for the window, not one per split
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = "✘ ", warn = "▲ ", info = "⚑ ", hint = "⚐ " },
      },
      { "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
    },
    lualine_x = { "filetype", "encoding" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "nvim-tree", "quickfix" },
}

-- Bufferline --------------------------------------------------------------
-- Catppuccin 2.x no longer ships a bufferline integration, and bufferline's
-- own colour derivation reads Normal's background -- which is NONE here -- so
-- the groups are spelled out against the palette instead.
local function buf_hl(fg, opts)
  return vim.tbl_extend("keep", { fg = fg, bg = "NONE" }, opts or {})
end

require("bufferline").setup {
  options = {
    mode = "buffers",
    separator_style = "thin",
    indicator = { style = "underline" },
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      return (level:match "error" and "✘ " or "▲ ") .. count
    end,
    show_buffer_close_icons = true,
    show_close_icon = false,
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
  highlights = {
    fill = buf_hl(C.overlay0),
    background = buf_hl(C.overlay0),
    buffer_visible = buf_hl(C.subtext0),
    -- sp is the colour of the underline indicator; bufferline otherwise
    -- derives it from this group's fg, which makes the indicator invisible.
    buffer_selected = buf_hl(C.text, { bold = true, italic = false, sp = C.mauve }),
    indicator_visible = buf_hl(C.surface1),
    indicator_selected = buf_hl(C.mauve),
    separator = buf_hl(C.surface0),
    separator_visible = buf_hl(C.surface0),
    separator_selected = buf_hl(C.surface0),
    modified = buf_hl(C.peach),
    modified_visible = buf_hl(C.peach),
    modified_selected = buf_hl(C.green),
    close_button = buf_hl(C.overlay0),
    close_button_visible = buf_hl(C.subtext0),
    close_button_selected = buf_hl(C.red),
    duplicate = buf_hl(C.overlay0, { italic = true }),
    duplicate_visible = buf_hl(C.subtext0, { italic = true }),
    duplicate_selected = buf_hl(C.text, { italic = true }),
    error = buf_hl(C.red),
    error_visible = buf_hl(C.red),
    error_selected = buf_hl(C.red, { bold = true }),
    error_diagnostic = buf_hl(C.red),
    error_diagnostic_visible = buf_hl(C.red),
    error_diagnostic_selected = buf_hl(C.red, { bold = true }),
    warning = buf_hl(C.yellow),
    warning_visible = buf_hl(C.yellow),
    warning_selected = buf_hl(C.yellow, { bold = true }),
    warning_diagnostic = buf_hl(C.yellow),
    warning_diagnostic_visible = buf_hl(C.yellow),
    warning_diagnostic_selected = buf_hl(C.yellow, { bold = true }),
    info = buf_hl(C.sky),
    info_visible = buf_hl(C.sky),
    info_selected = buf_hl(C.sky, { bold = true }),
    hint = buf_hl(C.teal),
    hint_visible = buf_hl(C.teal),
    hint_selected = buf_hl(C.teal, { bold = true }),
    offset_separator = buf_hl(C.surface0),
  },
}
