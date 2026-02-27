--------------------------------------------------
-- Mason
--------------------------------------------------
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

--------------------------------------------------
-- Capabilities (for nvim-cmp)
--------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

--------------------------------------------------
-- Lua
--------------------------------------------------
vim.lsp.config["lua_ls"] = {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
}

--------------------------------------------------
-- Python
--------------------------------------------------
vim.lsp.config["pyright"] = {
  capabilities = capabilities,
}

--------------------------------------------------
-- TypeScript
--------------------------------------------------
vim.lsp.config["ts_ls"] = {
  capabilities = capabilities,
}

--------------------------------------------------
-- C / C++ (clangd)
--------------------------------------------------
vim.lsp.config["clangd"] = {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", ".git" },
}

--------------------------------------------------
-- Typst
--------------------------------------------------
vim.lsp.config["tinymist"] = {
  capabilities = capabilities,
  filetypes = { "typst" },
}

--------------------------------------------------
-- Enable servers
--------------------------------------------------
vim.lsp.enable({
  "lua_ls",
  "pyright",
  "ts_ls",
  "clangd",
  "tinymist",
})

--------------------------------------------------
-- Typst filetype
--------------------------------------------------
vim.filetype.add({
  extension = { typ = "typst" },
})
