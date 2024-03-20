vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
  pattern = "*",
 command = "call OpiumInit()"
})

require("opium")

vim.api.nvim_set_hl(0, "OpiumLevel1", { bg = "#7DAEA3", fg = "#1D2021", bold = true })
vim.api.nvim_set_hl(0, "OpiumLevel2", { bg = "#89B482", fg = "#1D2021", bold = true })
vim.api.nvim_set_hl(0, "OpiumLevel3", { bg = "#A9B665", fg = "#1D2021", bold = true })
vim.api.nvim_set_hl(0, "OpiumLevel4", { bg = "#D8A657", fg = "#1D2021", bold = true })
vim.api.nvim_set_hl(0, "OpiumLevel5", { bg = "#D3869B", fg = "#1D2021", bold = true })
vim.api.nvim_set_hl(0, "OpiumLevel6", { bg = "#D4BE98", fg = "#1D2021", bold = true })
vim.g.opiumhigh = {'OpiumLevel1','OpiumLevel2','OpiumLevel3','OpiumLevel4','OpiumLevel5','OpiumLevel6'}
