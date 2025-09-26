-- CyberNEO Neovim bootstrap using lazy.nvim and LazyVim
-- Safe, minimal starter aligned with the spec

local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

require("lazy").setup({
  spec = {
    -- LazyVim core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- You can add extras here, e.g. treesitter, lsp, etc. LazyVim includes sensible defaults.
  },
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})

