vim.o.winborder = "rounded"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.cursorcolumn = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.undofile = true
-- vim.o.swapfile = false -- nie wiem co to robi
vim.g.mapleader = " "

vim.keymap.set('n', '<Leader>o', ':update<CR> :source<CR>')
vim.keymap.set('i', 'jk', "<Esc>")
vim.keymap.set('n', ';', ":")
vim.keymap.set('n', '<Esc>', ":nohlsearch<CR>")

-- Copying
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+yg')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>yy', '"+yy')

-- Pasting
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>P', '"+P')

vim.pack.add({
		{src = "https://github.com/vague-theme/vague.nvim"},
		{src = "https://github.com/catppuccin/nvim"},
		{src = "https://github.com/mcauley-penney/techbase.nvim"},
		{src = "https://github.com/nvim-lua/plenary.nvim"},
		{src = "https://github.com/nvim-telescope/telescope.nvim"},
		{src = "https://github.com/neovim/nvim-lspconfig"},
		{src = "https://github.com/saghen/blink.cmp"},
		{src = "https://github.com/sphamba/smear-cursor.nvim"},
		{src = "https://github.com/mason-org/mason.nvim"},
		{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
})

vim.cmd("packadd nvim-treesitter")

require "mason".setup()
require "nvim-treesitter.config".setup({
				build = ":TSUpdate",
				lazy = false,
				install_dir = vim.fn.stdpath('data') .. '/site',
				-- autoinstall = true,
				-- auto_install = true,
				ensure_installed = { "lua", "c", "python", "zig", "rust" },
				highlight = { enabled = true },
})
require "smear_cursor".setup({
		opts = {
				stiffness = 0.9,
				trailing_stiffness = 0.6,
				matrix_pixel_threshold = 0.5,
				time_interval = 0.5,
				damping = 0.95,
				damping_insert_mode = 0.95,
				legacy_computing_symbols_support = true,
		},
})

--
-- vim.lsp.config("lua_ls", {
--
-- })



require "blink.cmp".setup({
				signature = { enabled = true },
				fuzzy = { implementation = 'lua'},
})

vim.lsp.enable({"lua_ls", "pyright"})
vim.lsp.config("lua_ls", {
				settings = {
								Lua = {
												workspace = {
																library = vim.api.nvim_get_runtime_file("", true),
												}
								}
				}

})

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = { },
  extensions = { }
}



vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<Leader>f', ":Telescope<CR>")

vim.cmd("colorscheme vague")
require("vague").setup({
	transparent_background = true,
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
