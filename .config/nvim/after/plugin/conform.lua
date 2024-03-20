require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
		go = { "gofmt", "gofumpt" },
    python = { "ruff_format", "ruff_fix", "autopep8", "autoflake" },
		sh = { "shfmt" },
    javascript = { "eslint_d" },
    json =  { "fixjson" },
    yaml = { "yamlfmt", "yamlfix" },
    ["yaml.ansible"] = { "yamlfmt", "yamlfix" },  
  },
})
