-- ~/.config/nvim/lua/plugins/00-my-queries.lua
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- 1. mini-plugin local que solo aporta las queries
    { dir = vim.fn.stdpath("config") .. "/queries", name = "my-go-queries" },
  },
  opts = {
    highlight = { enable = true },
  },
}
