
return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Opcional: dependencias para iconos
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true, -- Reemplaza a Netrw
        view_options = {
          show_hidden = true, -- Muestra archivos ocultos (como .gitignore)
        },
      })
      -- Atajo rápido para abrir Oil
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir explorador Oil" })
    end
  },
}
