-- See `:help cmp`
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	completion = { completeopt = 'menu,menuone,noinsert' },
	mapping = cmp.mapping.preset.insert({
		['<C-e>'] = cmp.mapping.abort(),

		-- For an understanding of why these mappings were
		-- chosen, you will need to read `:help ins-completion`
		--
		-- No, but seriously. Please read `:help ins-completion`, it is really good!
			-- Select the [n]ext item
			['<C-n>'] = cmp.mapping.select_next_item(),
			-- Select the [p]revious item
			['<C-p>'] = cmp.mapping.select_prev_item(),

			-- Scroll the documentation window [b]ack / [f]orward
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),

			-- Accept ([y]es) the completion.
			--  This will auto-import if your LSP supports it.
			--  This will expand snippets if the LSP sent a snippet.
			['<C-y>'] = cmp.mapping.confirm { select = true },

			-- If you prefer more traditional completion keymaps,
			-- you can uncomment the following lines
			--['<CR>'] = cmp.mapping.confirm { select = true },
			--['<Tab>'] = cmp.mapping.select_next_item(),
			--['<S-Tab>'] = cmp.mapping.select_prev_item(),

			-- Manually trigger a completion from nvim-cmp.
			--  Generally you don't need this, because nvim-cmp will display
			--  completions whenever it has completion options available.
			['<C-Space>'] = cmp.mapping.complete {},

			-- Think of <c-l> as moving to the right of your snippet expansion.
			--  So if you have a snippet that's like:
			--  function $name($args)
			--    $body
			--  end
			--
			-- <c-l> will move you to the right of each of the expansion locations.
			-- <c-h> is similar, except moving you backwards.
			['<C-l>'] = cmp.mapping(function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { 'i', 's' }),
			['<C-h>'] = cmp.mapping(function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { 'i', 's' }),

	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	}),
	formatting = {
    format = lspkind.cmp_format(),
  },
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})
require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})


local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local nvim_lsp = require('lspconfig')

nvim_lsp['gopls'].setup{
  cmd = {'gopls'},
  -- on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
}
