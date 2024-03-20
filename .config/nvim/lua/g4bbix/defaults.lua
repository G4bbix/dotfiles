vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.history = 1000
vim.opt.undolevels = 1000
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.showtabline = 2
vim.opt.tabstop = 2
vim.opt.list = true
vim.opt.listchars = "tab:>.,trail:.,extends:#,nbsp:."
vim.opt.scrolloff = 10
vim.opt.expandtab = false
vim.opt.startofline = false
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.highlightedyank_highlight_duration = -1

vim.g.coq_settings = {
	auto_start = "shut-up"
}

vim.diagnostic.config({
	virtual_text = {
		prefix =  ""
	}
})
