local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint" },
	["yaml.ansible"]  = { "ansible_lint" },
	sh = { "Shellcheck" },
	json = { "jsonlint" },
	yaml = { "yamllint" },
	dockerfile = { "hadolint" },
	python =  { "ruff", "pylint" },
	go = { "golangcilint"}
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
