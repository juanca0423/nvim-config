-- ~/.config/nvim/lua/plugins/vim-test.lua
return {
  "vim-test/vim-test",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("toggleterm").setup({ size = 12, direction = "float" })
    vim.g["test#strategy"] = "toggleterm"
    vim.g["test#go#runner"] = "gotestsum"
  end,
  keys = {
    { "<leader>tt", "<cmd>TestNearest<CR>", desc = "Run nearest" },
  },
}
