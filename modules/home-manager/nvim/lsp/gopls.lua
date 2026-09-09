-- Go. Enabled per host via `custom.nvim.languages.go.enable`.
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedwrite = true,
      },
      staticcheck = true,
    },
  },
}
