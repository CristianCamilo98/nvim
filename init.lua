require("config.lazy")
require("plugins")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.number = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.keymap.set('n', '<leader>h', ':nohlsearch<Cr>')

-- Enable to copy/paste using system clipboard
vim.api.nvim_set_option("clipboard","unnamed")
vim.g.copilot_proxy_strict_ssl = false

-- Automatically format Terraform files on save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {'*.tf', '*.tfvars'},  -- Matches Terraform files
  callback = function()
    -- Determine the available formatter (terraform or tofu)
    local formatter = vim.fn.executable('terraform') == 1 and 'terraform' or (vim.fn.executable('tofu') == 1 and 'tofu' or nil)

    if formatter then
      -- Run the formatter using a shell command after saving
      vim.fn.system(formatter .. ' fmt ' .. vim.fn.expand('%'))
      -- Optionally reload the file to reflect changes
      vim.cmd('edit')
    else
      -- Notify the user if neither formatter is available
      vim.notify('Neither terraform nor tofu is installed!', vim.log.levels.ERROR)
    end
  end
})

