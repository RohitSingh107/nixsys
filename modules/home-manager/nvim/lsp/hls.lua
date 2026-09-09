-- Haskell. Enabled per host via `custom.nvim.languages.haskell.enable`.
-- Settings carried over from the previous coc-settings languageserver entry.
return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  root_markers = {
    "hie.yaml",
    "stack.yaml",
    "cabal.project",
    "package.yaml",
    ".git",
  },
  settings = {
    haskell = {
      checkParents = "CheckOnSave",
      checkProject = true,
      maxCompletions = 40,
      formattingProvider = "ormolu",
      plugin = { stan = { globalOn = true } },
    },
  },
}
