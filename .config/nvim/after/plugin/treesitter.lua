require'nvim-treesitter.configs'.setup {
   ensure_installed = { "bash", "csv", "dockerfile", "go", "html", "json", "python", "scss", "yaml", "lua", "vim", "vimdoc", "javascript" },
   sync_install = false,
   auto_install = true,
   ignore_install = { },

   highlight = {
     enable = true,
     additional_vim_regex_highlighting = false,
   },
}

local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
}
return { M }
