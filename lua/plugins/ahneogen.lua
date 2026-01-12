local function conf()
    require('neogen').setup({
      enabled = true,
        languages = {
          javascript = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
                -- También funciona para Go
          go =  {
            template = {
              annotation_convention = "godoc"
            }
          }
        }
    })
end

return {
 "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = conf
}
