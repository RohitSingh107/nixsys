-- Rust. Enabled per host via `custom.nvim.languages.rust.enable`.
-- checkOnSave is left at the default (cargo check); pointing it at clippy would
-- need clippy on PATH, which the rust-analyzer package does not provide.
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
}
