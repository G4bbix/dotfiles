vim.keymap.set("n", "<leader>fig", ":FIGlet<CR>")

vim.keymap.set("n", "<PageUp>", "<C-U>")
vim.keymap.set("i", "<PageUp>", "<C-O><C-U>")
vim.keymap.set("n", "<PageDown>", "<C-D>")
vim.keymap.set("i", "<PageDown>", "<C-O><C-D>")

vim.keymap.set("i", "<Insert>", "<Nop>")
vim.keymap.set("i", "<S-Insert>", "<Insert>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<F5>", ":UndotreeToggle<CR>")

vim.keymap.set("n", "üd", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "¨d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>nt", ":tabnew<CR>", { desc = "Open new tab" })

vim.keymap.set("n", "<leader>ww", function()
	vim.opt.wrap = not vim.opt.wrap._value
end, { desc = "Toggle wrapping" })

vim.keymap.set("n", "<leader>af", function()
	require("conform").format()
end, { desc = "Format code using conform" })

vim.keymap.set("n", "<leader>tt", function()
	vim.cmd(":ToggleTerm size=25 direction=horizontal")
end, { desc = "Toggle Shell" })
