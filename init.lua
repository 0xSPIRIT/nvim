vim.cmd('source ~/AppData/Local/nvim/config.vim')

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

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        'nvim-telescope/telescope-project.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup({
                detection_methods = { "pattern", "git" },  -- Methods for detecting projects
                silent_chdir = true,  -- Set to true if you don’t want auto cd to project dir
            })
        end
    },
    {
        "ficcdaf/ashen.nvim",
        lazy = false,
        priority = 1000,
    },
    { "rose-pine/neovim", name = "rose-pine" },
    { 'dasupradyumna/midnight.nvim', lazy = false, priority = 1000 },
},
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})


local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            ".git"
        },
        pickers = {
            find_files = {
                find_command = {'fd', '--type', 'f'},
            },
            git_files = {hidden = true},  -- Disable git_files
            git_status = {hidden = true}, -- Disable git_status
            git_branches = {hidden = true}, -- Disable git_branches
        },
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

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-o>', builtin.find_files, { desc = 'Telescope find files' })

vim.keymap.set('n', '<C-s>', builtin.live_grep, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<Space>', function()
    builtin.buffers({
        sort_lastused = true,
    })
end, { desc = 'Telescope buffers' })

vim.cmd('colorscheme ashen')
