vim.diagnostic.config({
  float = {
    border = "rounded",
    focusable = true,
    style = "minimal",
    source = "always",
    header = "",
    prefix = "●",
  },
  virtual_text = false,
  signs = true,
  underline = true,
})
