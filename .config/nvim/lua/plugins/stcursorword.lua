return {
  "sontungexpt/stcursorword",
  lazy = true,
  event = "BufReadPre",
  config = function()
    require("stcursorword").setup({})
    -- code
  end,
}
