return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown" },
  opts = {},
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- ⬅️  activamos treesitter en markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
