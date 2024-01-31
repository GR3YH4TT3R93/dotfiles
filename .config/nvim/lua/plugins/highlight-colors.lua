return {
  "brenoprata10/nvim-highlight-colors",
  event = "BufReadPre",
  config = function()
    require("nvim-highlight-colors").setup({ enable_tailwind = true })
  end,
}
