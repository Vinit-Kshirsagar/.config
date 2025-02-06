-- Lazy.nvim bootstrap
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

-- Plugin setup
require("lazy").setup({
  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Ensure parsers are updated
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "java", "lua", "python", "cpp", "javascript", "html" }, -- Add your desired languages
        highlight = {
          enable = true, -- Enable Treesitter-based highlighting
          additional_vim_regex_highlighting = false, -- Disable default regex highlighting
        },
      })
    end,
  },
  -- Mason for managing LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason LSP Config for integrating Mason with Neovim's LSP
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls" }, -- Automatically install Java LSP
      })
    end,
  },
  -- nvim-lspconfig for configuring LSP servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").jdtls.setup{} -- Basic setup for jdtls (Java LSP)
    end,
  },
})

-- General Neovim settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.tabstop = 4                -- Number of spaces for a tab
vim.opt.shiftwidth = 4             -- Number of spaces for autoindent
vim.opt.expandtab = true           -- Convert tabs to spaces
vim.opt.termguicolors = true       -- Enable true colors
vim.cmd("syntax on")               -- Fallback syntax highlighting
vim.cmd("filetype plugin indent on") -- Enable filetype-based settings

