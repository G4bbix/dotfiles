vim.g.coq_settings = { 
	xdg = true,
	keymap = {
		manual_complete = "<leader>y"
	}
}
vim.keymap.set("i", "<C-y>", "pumvisible() ? <Enter> : <C-y>") 
