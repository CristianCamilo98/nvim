-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd([[highlight RedundantSpaces ctermbg=red guibg=red]])
vim.cmd([[match RedundantSpaces /\s\+$/]])

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    "numToStr/Comment.nvim",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-lualine/lualine.nvim",
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "zbirenbaum/copilot.lua",
    {
      "yetone/avante.nvim",
      build = "make BUILD_FROM_SOURCE=true",
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      ---@module 'avante'
      ---@type avante.Config
      opts = {
        behavior = {
          auto_suggestions = false,
          enable_token_counting = false,
        },
        provider = "copilot",
        providers = {
          claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-sonnet-4-20250514",
            timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 20480,
            },
          },
          copilot = {
            endpoint = "https://api.github.com",
            model = "github-copilot",
            timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 32786,
            },
          },
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "stevearc/dressing.nvim", -- for input provider dressing
        "folke/snacks.nvim", -- for input provider snacks
        "nvim-tree/nvim-web-devicons", -- for echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- suport for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            filetypes = { "markdown", "Avante" },
            -- Start with rendering disabled by default
            enabled = false,
          },
          ft = { "markdown", "Avante" },
          config = function(_, opts)
            require("render-markdown").setup(opts)

            -- Create a toggle function for markdown rendering
            local function toggle_markdown_render()
              require("render-markdown").toggle()
            end

            vim.keymap.set("n", "<leader>mr", toggle_markdown_render, {
              desc = "Toggle Markdown Rendering",
              buffer = true,
            })


            -- Also create autocmd to set up the keybinding for markdown files
            vim.api.nvim_create_autocmd("FileType", {
              pattern = { "markdown", "Avante" },
              callback = function()
                vim.keymap.set("n", "<leader>mr", toggle_markdown_render, {
                  desc = "Toggle Markdown Rendering",
                  buffer = true,
                })
              end,
            })
          end,
        },
      },
    },
    {
    "nvim-telescope/telescope.nvim", tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" }
    },
    "lukas-reineke/indent-blankline.nvim",
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
          { "mason-org/mason.nvim", opts = {} },
          "neovim/nvim-lspconfig",
      },
    },
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async"
      },
    },

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
