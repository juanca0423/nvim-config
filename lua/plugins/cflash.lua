
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
    -- Esto hace que al buscar con "/" también se use Flash
      multi_window = true,
    },
    modes = {
      search = {
        enabled = true, -- ¡Pruébalo, es genial!
      },
    },
    labels = "asdfghjklqwertyuiopzxcvbnm", -- Letras que aparecerán para saltar
  },
  keys = {
    -- El comando principal que me pediste con 'x'
    { "x", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Saltar con Flash" },
    { "X", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Selección inteligente con Flash" },
  },
}
