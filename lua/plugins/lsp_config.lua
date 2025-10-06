local on_attach = function(_, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gb', '<C-o>', { noremap = true, silent = true })
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"lua_ls", "terraformls", "pyright", "gopls", "biome", "bashls"},
  automatic_installation =  false,
  automatic_setup = false,
  automatic_enable = false,
  handler = nil,
})

vim.lsp.config('lua_ls', {
  on_attach = on_attach
})
vim.lsp.config('terraformls', {
  on_attach = on_attach
})
vim.lsp.config('pyright', {
  on_attach = on_attach
})
vim.lsp.config('intelephense', {
  on_attach = on_attach
})
vim.lsp.config('html', {
  on_attach = on_attach
})
vim.lsp.config('gopls', {
  on_attach = on_attach
})
vim.lsp.config('biome', {
  on_attach = on_attach
})
vim.lsp.config('bashls', {
  on_attach = on_attach
})

vim.api.nvim_set_keymap('n', '<space>e', ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>q', ':lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
