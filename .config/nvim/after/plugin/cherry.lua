vim.g.cherry_highlights = {
	{ guibg = "#ea6962", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#e78a4e", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#d8a657", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#a9b665", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#89b482", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#d3869b", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#7daea3", guifg = "#1d2021", gui = "bold" },
	{ guibg = "#d4be98", guifg = "#1d2021", gui = "bold" },
}

-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
-- 	pattern = "*",
-- 	callback = function() require("cherry").setup() end
-- })

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
	pattern = "*",
	callback = function() require("cherry").update_pairs() end
})
