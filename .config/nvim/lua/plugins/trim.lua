return {
  "cappyzawa/trim.nvim",
  event = "BufWritePre",
  config = function()
    require("trim").setup({
      -- disable = { "markdown" },
    })
  end,
}
