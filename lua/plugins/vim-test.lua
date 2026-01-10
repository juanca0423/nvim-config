-- ~/.config/nvim/lua/plugins/vim-test.lua
return {
  "vim-test/vim-test",
  event = "VeryLazy",
  config = function()
    vim.g["test#go#recognize_tests"] = 1
    vim.g["test#strategy"] = "basic"      -- usa solo :!go test
  end,
  keys = {
    { "<leader>tt", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
  },
}
