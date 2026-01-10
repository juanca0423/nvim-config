return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux", -- o "akinsho/toggleterm.nvim"
  },
  config = function()
    vim.g["test#strategy"] = "vimux" -- o "toggleterm"
  end,
}
