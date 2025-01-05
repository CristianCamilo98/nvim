require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"lua_ls", "terraformls", "jedi_language_server"},
})

require'lspconfig'.lua_ls.setup{}
require'lspconfig'.terraformls.setup{}
require'lspconfig'.jedi_language_server.setup{}

vim.api.nvim_set_keymap('n', '<space>e', ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>', { noremap = true, silent = true })
