require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Keymap to toggle nvim-tree
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFile<CR>')

-- Autocommand to open nvim-tree on startup and switch focus to the file
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-tree.api").tree.open()
    -- Switch focus back to the file
    vim.cmd("wincmd l")
  end
})
