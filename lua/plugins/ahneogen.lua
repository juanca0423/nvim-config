return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require('neogen').setup({
      enabled = true,
      snippet_engine = "luasnip", -- IMPORTANTE: vinculalo con tu motor de snippets
      languages = {
        javascript = { template = { annotation_convention = "jsdoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        go = { template = { annotation_convention = "godoc" } },
        lua = { template = { annotation_convention = "ldoc" } },
      }
    })

    -- ATAJO PARA GENERAR DOCS (Sin esto, el plugin no "despierta")
    vim.keymap.set("n", "<leader>nf", function()
      require('neogen').generate()
    end, { desc = "Generar documentación (Neogen)" })
  end
}
