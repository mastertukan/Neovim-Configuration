vim.o.winborder = "rounded"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.cursorcolumn = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.swapfile = false
vim.g.mapleader = " "

vim.keymap.set("n", "<Leader>o", ":update<CR> :source<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- Copying
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- Pasting
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

-- Splitting the line
vim.keymap.set("n", "<Leader>j", "f,a<CR><Esc>")

-- Line numbers inside :Explore
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"

-- Pairing brackets
-- vim.keymap.set("i", '"<tab>', '"  "<Left><Left>')
-- vim.keymap.set("i", "<leader>p", '"+p')
-- vim.keymap.set("i", "<leader>P", '"+P')
-- vim.keymap.set("i", "<leader>p", '"+p')
-- vim.keymap.set("i", "<leader>P", '"+P')
-- vim.keymap.set("i", "<leader>P", '"+P')
-- vim.keymap.set("i", "<leader>p", '"+p')
-- vim.keymap.set("i", "<leader>P", '"+P')

vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/mcauley-penney/techbase.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/saghen/frizbee" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/romgrk/barbar.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/OmniSharp/omnisharp-vim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- { src = "https://github.com/tpope/vim-surround" },
})

vim.cmd("packadd nvim-treesitter")

require("mason").setup()
require("barbar").setup()
require("nvim-treesitter.config").setup({
	build = ":TSUpdate",
	lazy = false,
	install_dir = vim.fn.stdpath("data") .. "/site",
	-- autoinstall = true,
	-- auto_install = true,
	ensure_installed = { "lua", "c", "go", "python", "zig", "rust" },
	highlight = { enabled = true },
})
require("smear_cursor").setup({
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

require("blink.cmp").setup({
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	keymap = { ["<Tab>"] = { "select_and_accept", "fallback" } },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofumpt" },
		python = { "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		c_sharp = { "clang-format" },
		matlab = { "mh_style" },
		zig = { "black" },
		java = { "ast-grep" },
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
})

vim.lsp.enable({
	"lua_ls",
	"gopls",
	"clangd",
	"jdtls",
	"pyright",
	"rust-analyzer",
	"zls",
	"matlab-language-server",
	"snyk",
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("matlab-language-server", {
	settings = {
		Matlab = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.config("rust-analyzer", {})

vim.lsp.config("snyk", {})

vim.keymap.set("n", "<Tab>", ":BufferNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferNext<CR>")
vim.keymap.set("n", "<Leader>x", ":BufferClose<CR>")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {},
	extensions = {},
})

-- Status Line
require("lualine").setup({
	override_by_extension = {
		["m"] = {
			icon = "",
			name = "Matlab",
		},
	},
	strict = true,
	options = {
		icons_enabled = true,
		theme = "iceberg_dark",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- Telescope
vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>f", ":Telescope<CR>")

-- Colorscheme
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
