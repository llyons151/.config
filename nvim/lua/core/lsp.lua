-- Mason core
require("mason").setup()

-- mason-lspconfig: ONLY servers Mason can install
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls" },  -- removed "ccls"
  automatic_installation = true,
})

-- Lua
vim.lsp.config["lua_ls"] = {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
}

-- C/C++ via ccls (installed with pacman)
vim.lsp.config["ccls"] = {
  init_options = {
    compilationDatabaseDirectory = "build",
    index = { threads = 0 },
    clang = { excludeArgs = { "-frounding-math" } },
  },
}

-- Python
vim.lsp.config["pyright"] = {}

-- JavaScript / TypeScript (Neovim 0.11 name)
vim.lsp.config["ts_ls"] = {}

-- Enable them (start on new buffers)
vim.lsp.enable({ "lua_ls", "ccls", "pyright", "ts_ls" })

