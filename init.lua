vim.o.clipboard = 'unnamedplus'
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.cindent = true

-- Packages using builtin package manager.
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/vague2k/vague.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/FotiadisM/tabset.nvim"
});

vim.keymap.set('n', '<C-p>', ':vs<CR><C-w><C-w>')
vim.keymap.set('n', '<C-S-p>', ':quit<CR>')
vim.keymap.set('n', '<C-l>', '<C-w><C-w>')
vim.keymap.set('n', '<C-e>', 'zz')
vim.keymap.set('n', '<F9>', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<C-Space>', ':call feedkeys(":tag ")<CR>')

local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<ESC>"] = actions.close,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<ESC>"] = actions.close,
      },
    },
  },
})

require('tabset').setup({
  defaults = {
    tabwidth = 4,
    expandtab = true
  },
  languages = {
    {
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml", "lua" },
      config = {
        tabwidth = 2
      }
    }
  }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-o>', builtin.find_files)
vim.keymap.set('n', '<C-s>', builtin.live_grep)
vim.keymap.set('n', '<Space>', function()
    builtin.buffers({
        sort_lastused = true,
    })
end)

vim.keymap.set({'n', 'i', 'v'}, '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})

vim.o.guifont = "Liberation Mono:h12"

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.0
	vim.g.neovide_scroll_animation_length = 0.07
end

vim.cmd("colorscheme vague")
