vim.o.winborder = "rounded"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
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
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
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
	ensure_installed = { "lua", "c", "go", "python", "zig", "rust", "javascript", "typescript", "html", "tsx" },
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
		typescript = { "prettierd" },
		css = { "prettierd" },
		javascript = { "prettierd" }
	},
	notify_no_formatters = true,

	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_format = "fallback",
	-- },
})

require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged_enable = true,
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
	auto_attach = true,
	attach_to_untracked = false,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	blame_formatter = nil, -- Use default
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- })

vim.keymap.set("n", "<leader>z", function()
	require("conform").format({
		async = true,
		lsp_format = "fallback",
	})
end, { desc = "Format current buffer" })

-- 1. Bind leader+0 in Visual Mode to trigger a range formatting command
vim.keymap.set("v", "<leader>0", ":ConformFormatRange<CR>", { silent = true, desc = "Format selection" })

-- 2. Create the internal command that processes visual ranges cleanly
vim.api.nvim_create_user_command("ConformFormatRange", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line and end_line:len() or 0 },
        }
    end

    require("conform").format({
        async = true,
        lsp_format = "fallback",
        range = range,
    })
end, { range = true })

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
	"ts_ls",
	"cssls",
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

vim.lsp.config("cssls", {
	filetypes = { 'css', 'scss', 'less' },
	settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
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

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--query-driver=C:/msys64/ucrt64/bin/g++.exe",
	},
})

vim.lsp.config("rust-analyzer", {})

vim.lsp.config("snyk", {})

vim.keymap.set("n", "<Tab>", ":BufferNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<CR>")
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
vim.keymap.set("n", "<Leader>t", ":Telescope<CR>")
vim.keymap.set("n", "<Leader>f", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>b", ":Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>g", ":Telescope grep_string<CR>")

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
