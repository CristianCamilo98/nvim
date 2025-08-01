local on_attach = function(_, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gb', '<C-o>', { noremap = true, silent = true })
end

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enabled = false,
  ensure_installed = {"lua_ls", "terraformls", "pyright", "gopls", "biome", "bashls"}
})

require'lspconfig'.lua_ls.setup{
  on_attach = on_attach
}
require'lspconfig'.terraformls.setup{
  on_attach = on_attach
}
require'lspconfig'.pyright.setup{
  on_attach = on_attach
}
require'lspconfig'.intelephense.setup{
  on_attach = on_attach
}
require'lspconfig'.html.setup{
  on_attach = on_attach
}

require'lspconfig'.gopls.setup{
  on_attach = on_attach
}

require'lspconfig'.biome.setup{
  on_attach = on_attach
}

require'lspconfig'.bashls.setup{
  on_attach = on_attach
}

vim.api.nvim_set_keymap('n', '<space>e', ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>q', ':lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
