require('lualine').setup {
	options = {
		theme = "gruvbox-material",
		component_separators = { left = '' , right = ''}
	},
	sections = {
		lualine_y = { '%B', '%b' },
	}
}

require('lualine').setup()
