return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim', -- Aseguramos que sepa que depende del tema
  },
  config = function()
    -- Intentamos obtener los colores de catppuccin de forma segura
    local cp_status, cp_bufferline = pcall(require, "catppuccin.groups.integrations.bufferline")

    local highlights = {}
    if cp_status then
      highlights = cp_bufferline.get()
    end

    require("bufferline").setup({
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        numbers = "buffer_id",
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorador",
            text_align = "left",
            separator = true
          }
        },
      },
      highlights = highlights -- Usará los de catppuccin si están, o los de defecto si no.
    })
  end
}
