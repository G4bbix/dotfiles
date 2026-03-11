require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
		go = { "golangci-lint" },
    python = { "ruff_format", "ruff_fix" },
		sh = { "shfmt" },
    javascript = { "eslint_d" },
    json =  { "fixjson", "jq" },
    yaml = { "yamlfmt", "yamlfix" },
    ["yaml.ansible"] = { "yamlfmt", "yamlfix" },
  },
})
