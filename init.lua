vim.keymap.set('n', '<F9>', ':e $MYVIMRC<CR>')

vim.o.clipboard = 'unnamedplus'
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.cindent = true
vim.o.hlsearch = not vim.o.hlsearch
vim.o.guicursor = "n-v-c-i:block"

vim.opt.title = true
vim.opt.titlestring = "nvim - %t"

-- lazy.nvim bootstrap (stable-friendly)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- important: stable branch
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Utility
  { "nvim-lua/plenary.nvim" },

  -- LSP installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },

  -- Colorschemes
  { "vague2k/vague.nvim" },
  { "flazz/vim-colorschemes" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Tab / indent control
  { "FotiadisM/tabset.nvim" },

  -- TypeScript / LSP
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
})

require("mason").setup()

-- clangd
vim.lsp.config("clangd", {
  filetypes = { "c", "cpp", "objc", "objcpp" },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  },
})

vim.lsp.enable("clangd")

vim.keymap.set('n', '<C-p>', ':vs<CR><C-w><C-w>')
vim.keymap.set('n', '<C-S-p>', ':quit<CR>')
vim.keymap.set('n', '<C-l>', '<C-w><C-w>')
vim.keymap.set('n', '<C-e>', 'zz')
vim.keymap.set('n', '<C-Space>', ':call feedkeys(":tag ")<CR>')
vim.keymap.set('n', '<A-m>', ':make<CR>')
vim.keymap.set('n', '<C-j>', '<Cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<Cmd>cprev<CR>zz')
vim.keymap.set('n', '<C-Enter>', ':!tag<CR>')
vim.keymap.set("n", "<CR>", function()
    vim.cmd("w") -- Save the current buffer
end, { desc = "Save file", silent = true })

vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gf', vim.lsp.buf.format, { noremap = true, silent = true })

require("typescript-tools").setup {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
        enable = false,
        filetypes = { "javascriptreact", "typescriptreact" },
    }
  },
}

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

-- Different tab widths depending on the file types.
require('tabset').setup({
  defaults = {
    tabwidth = 4,
    expandtab = true
  },
  languages = {
    {
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml", "lua", "css", "html", "java" },
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

--vim.o.guifont = "Courier New:h12"
vim.o.guifont = "Cascadia Mono:h14"
--vim.o.guifont = "Ac437 IBM BIOS-2y:h17:w0.5"
--vim.o.guifont = "Ac437 IBM VGA 8x14:h19"

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.0
	vim.g.neovide_scroll_animation_length = 0.07
end

vim.cmd("colorscheme znake")
