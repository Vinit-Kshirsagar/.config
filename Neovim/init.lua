-- Lazy.nvim 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin 
require("lazy").setup({
  -- Dracula theme for Neovim
  { 
    "dracula/vim",  -- Dracula theme for Neovim
    config = function()
      vim.cmd("colorscheme dracula")  -- Set the colorscheme to Dracula
    end
  }
  -- Treesitter for text highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", 
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "java", "lua", "python", "cpp", "javascript", "html" }, -- Add your desired languages
        highlight = {
          enable = true, -- Enable Treesitter
          additional_vim_regex_highlighting = false, -- Disable default highlighting
        },
      })
    end,
  },
  -- Mason Installation and setup
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason with Neovim's LSP
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls" }, --installs jdtls
      })
    end,
  },
  -- nvim-lspconfig for jdtls
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").jdtls.setup{} 
    end,
  },
})

-- General settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.tabstop = 4                -- Number of spaces for a tab
vim.opt.shiftwidth = 4             -- Number of spaces for autoindent
vim.opt.expandtab = true           -- Convert tabs to spaces
vim.opt.termguicolors = true       -- Enable true colors
vim.cmd("syntax on")               -- Fallback syntax highlighting
vim.cmd("filetype plugin indent on") -- Enable filetype-based settings

