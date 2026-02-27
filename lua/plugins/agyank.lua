return {
  "gbprod/yanky.nvim",
  config = function()
    require("yanky").setup({
      ring = {
        history_length = 50,
        storage = "shada", -- Guarda el historial de copiado al cerrar Neovim
      },
      system_clipboard = {
        sync_with_ring = true, -- Sincroniza con el portapapeles de Android/Termux
      },
    })

    -- Atajos de pegado
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

    -- Ciclar entre lo copiado (muy útil)
    vim.keymap.set("n", "<C-p>", "<Plug>(YankyCycleForward)")
    vim.keymap.set("n", "<C-m>", "<Plug>(YankyCycleBackward)")
  end
}
