-- Brief Aside: **What is LSP?**
--
-- LSP is an acronym you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--- Go to definition
--- Find references
--- Autocompletion
--- Symbol Search
--- and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

--This function gets run when an LSP attaches to a particular buffer.
-- That is to say, every time a new file is opened that is associated with
-- an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
-- function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- NOTE: Remember that lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself
		-- many times.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-T>.
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		-- Jump to the type of the word under your cursor.
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

		-- Fuzzy find all the symbols in your current workspace
		-- Similar to document symbols, except searches over your whole project.
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Rename the variable under your cursor
		-- Most Language Servers support renaming across files, etc.
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		-- Opens a popup that displays documentation about the word under your cursor
		-- See `:help K` for why this keymap
		map("K", vim.lsp.buf.hover, "Hover Documentation")

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		-- For example, in C this would take you to the header
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		-- See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			callback = vim.lsp.buf.clear_references,
		})
		end
	end,
})

-- LSP servers and clients are able to communicate to each other what features they support.
-- By default, Neovim doesn't support everything that is in the LSP Specification.
-- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
-- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
-- Add any additional override configuration in the following tables. Available keys are:
-- - cmd (table): Override the default command used to start the server
-- - filetypes (table): Override the default list of associated filetypes for the server
-- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
-- - settings (table): Override the default settings passed when initializing the server.
-- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
	-- clangd = {},
	ansiblels = {},
	bashls = {},
	gopls = {},
	golangci_lint_ls = {},
	dockerls = {},
	eslint = {},
	jsonls = {},
	lua_ls = {
		-- cmd = {...},
		-- filetypes { ...},
		-- capabilities = {},
		settings = {
	 Lua = {
		 runtime = { version = "LuaJIT" },
		 workspace = {
		checkThirdParty = false,
		library = {
			"${3rd}/luv/library",
			unpack(vim.api.nvim_get_runtime_file("", true)),
		},
		 },
		 completion = {
		callSnippet = "Replace",
		 },
	 },
		},
	},
	ruff_lsp = {},
	pylint = {},
	pylsp = {},
	yamlls = {},
}

-- Ensure the servers and tools above are installed
--	To check the current status of installed tools and/or manually install
--	other tools, you can run
--	 :Mason
--
--	You can press `g?` for help in this menu
require("mason").setup()

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
 local ensure_installed = vim.tbl_keys(servers or {})
 vim.list_extend(ensure_installed, {
	"stylua",
	"pylint",
	"flake8",
	"autopep8",
	"gofumpt",
	"golangci-lint",
	"gopls",
	"eslint",
	"eslint_d",
	"luacheck",
	"shellcheck",
	"shfmt",
	"hadolint",
	"ansible-lint",
	"vint",
	"yamllint",
	"yamlfmt",
	"yamlfix",
 })
 require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

 require("mason-lspconfig").setup({
	handlers = {
	 function(server_name)
		 local server = servers[server_name] or {}
		 -- This handles overriding only values explicitly passed
		 -- by the server configuration above. Useful when disabling
		 -- certain features of an LSP (for example, turning off formatting for tsserver)
		 server.capabilities = vim.tbl_deep_extend("force", {}, capabilities or {}, server.capabilities or {})
		 require("lspconfig")[server_name].setup(server)
	 end,
	},
 })

-- RUFF

-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
 local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

 -- Configure `ruff-lsp`.
 -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
 -- For the default config, along with instructions on how to customize the settings
 require("lspconfig").ruff_lsp.setup({
	on_attach = on_attach,
	init_options = {
		settings = {
	 -- Any extra CLI arguments for `ruff` go here.
	 args = {},
		},
	},
 })

require("lspconfig").pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		formatCommand = { "black" },
		pylsp = {
	 plugins = {
		 pyls_flake8 = { enabled = true },
		 pylint = { enabled = true, args = {} },
		 black = { enabled = true },
		 isort = { enabled = true },
		 pyls_mypy = {
		enabled = false,
		--live_mode = true,
		 },
	 },
		},
	},
})

local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

if not configs.golangcilsp then
	configs.golangcilsp = {
		default_config = {
	 cmd = { "golangci-lint-langserver" },
	 root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
	 init_options = {
		 command = {
		"golangci-lint",
		"run",
		"--enable-all",
		"--disable",
		"lll",
		"--out-format",
		"json",
		"--issues-exit-code=1",
		 },
	 },
		},
	}
end
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
})
