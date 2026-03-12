require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "clangd",
    "tinymist",
  },
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config["lua_ls"] = {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
}

vim.lsp.config["pyright"] = {
  capabilities = capabilities,
}

vim.lsp.config["ts_ls"] = {
  capabilities = capabilities,
}

vim.lsp.config["clangd"] = {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", ".git" },
}

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "ts_ls",
  "clangd",
  "tinymist",
})
