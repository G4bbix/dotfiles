local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "michaeljsmith/vim-indent-object" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "tpope/vim-commentary" },
	{ "tpope/vim-fugitive" },
	{ "lilydjwg/colorizer" },
	{ "AndrewRadev/splitjoin.vim" },
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_enable_italic_comments = true
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{ "tpope/vim-sensible" },
	{ "pearofducks/ansible-vim" },
	{
		"fadein/vim-FIGlet",
		config = function()
			vim.g.use_FIGlet_as_operatorfunc = 1
		end,
	},
	{ "evansalter/vim-checklist" },
	{ "Raimondi/delimitMate" },
	-- {"fatih/vim-go", build=":GoUpdateBinaries"},
	{ "machakann/vim-highlightedyank" },
	{ "ron-rs/ron.vim" },
	{ "G4bbix/opium.vim" },
	{ "mhinz/vim-signify" },
	{ "mbbill/undotree" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			-- Useful for getting pretty icons, but requires special font.
			--  If you already have a Nerd Font, or terminal set up with fallback fonts
			--  you can enable this
			-- { 'nvim-tree/nvim-web-devicons' }
		},
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			signs = false,
		},
	},
	{ "stevearc/dressing.nvim" },
	{ "j-hui/fidget.nvim" },
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/nvim-cmp",
			"onsails/lspkind.nvim",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "mfussenegger/nvim-lint" },
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"G4bbix/cherry_nvim",
		priority = 0,
	},
	{ "nvim-telescope/telescope.nvim",
		dependencies = {
				"nvim-lua/plenary.nvim",
				"debugloop/telescope-undo.nvim",
		}
	}
})
