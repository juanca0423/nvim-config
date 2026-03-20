return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown" },
  opts = {
    latex = {
      enabled = true,
      -- Especifica el ejecutable que encontraste
      converter = 'latex2text',
      -- O la ruta completa si es necesario:
      -- converter = '/data/data/com.termux/files/usr/bin/latex2text',
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
