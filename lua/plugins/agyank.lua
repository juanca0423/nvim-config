return{
  "gbprod/yanky.nvim",
  config = function()
    require("yanky").setup({})
    -- Atajos sugeridos
    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)") -- Ciclar entre lo copiado
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
  end
}
