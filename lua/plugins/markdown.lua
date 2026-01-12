
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    file_types = { 'markdown' },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)
  end
}
