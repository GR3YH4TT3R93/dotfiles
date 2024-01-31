return {
  "brenoprata10/nvim-highlight-colors",
  lazy = true,
  event = "BufReadPre",
  config = function()
    require("nvim-highlight-colors").setup({ enable_tailwind = true })
  end,
}
