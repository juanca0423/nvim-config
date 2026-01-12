
return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup({
      render = 'background', -- o 'foreground' o 'tail'
      enable_named_colors = true,
    })
  end,
}
