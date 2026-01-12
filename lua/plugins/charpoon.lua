
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Atajos básicos
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Marcar archivo" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Menú Harpoon" })

    -- EL BUCLE PARA LOS 9 ARCHIVOS
    -- Esto crea automáticamente Alt-1, Alt-2... hasta Alt-9
    for i = 1, 9 do
      vim.keymap.set("n", "<A-" .. i .. ">", function()
        harpoon:list():select(i)
      end, { desc = "Saltar al archivo " .. i })
    end
  end,
}
