return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "AndreM222/copilot-lualine" },
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "onedark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "neo-tree" },
          winbar = { "neo-tree" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 0 } },
        lualine_x = {
          {
            "copilot",
            -- Default values
            symbols = {
              status = {
                icons = {
                  enabled = " ",
                  sleep = " ", -- auto-trigger disabled
                  disabled = " ",
                  warning = " ",
                  unknown = " ",
                },
                hl = {
                  enabled = "#98c379",
                  sleep = "#848b98",
                  disabled = "#5c6370",
                  warning = "#d19a66",
                  unknown = "#848b98",
                },
              },
              spinners = require("copilot-lualine.spinners").dots,
              spinner_color = "#5c6370",
            },
            show_colors = true,
            show_loading = true,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 0 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = { { "buffers", mode = 2 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
      extensions = { "lazy", "neo-tree", "toggleterm" },
    })
  end,
}
