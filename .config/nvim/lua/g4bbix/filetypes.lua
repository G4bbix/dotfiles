vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt.shiftwidth = 4
		vim.opt.showtabline = 4
		vim.opt.tabstop = 4
		vim.opt.softtabstop = 4
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python,bash,sh",
	callback = function()
		vim.opt.commentstring = '# %s'
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "vim",
	callback = function()
		vim.opt.commentstring = '" %s'
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "css,scss,js",
	callback = function()
		vim.opt.commentstring = '// %s'
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		vim.opt.commentstring = '<!-- %s -->'
	end
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = {"*/playbooks/*.yml", "*/playbooks/*.yaml"},
	callback = function()
		vim.opt.filetype = "yaml.ansible"
	end
})
