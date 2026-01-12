
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true, -- Si cambias de pestaña, el árbol se mueve al archivo actual
        update_root = true,
      },
      view = {
        width = 30,
        side = "left",
        -- Oculta los números de línea en el árbol para ganar espacio
        number = false,
        relativenumber = false,
      },
      renderer = {
        group_empty = true,
        highlight_git = true, -- Pinta los nombres de archivos según su estado en Git
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true, -- Cierra el árbol al abrir un archivo (ideal para Termux)
          window_picker = { enable = false },
        },
      },
    })
  end,
}
