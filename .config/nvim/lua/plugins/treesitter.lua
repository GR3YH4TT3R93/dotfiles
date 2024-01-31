return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.2",
  commit = "ba6454783493ac3a5dd209c25e491640b07bd8de",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",
  },
  config = function()
    local configs = require("nvim-treesitter.configs")
    require("Comment").setup()
    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "vue",
        "typescript",
        "html",
        "css",
        "markdown",
        "json",
        "bash",
        "go",
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      highlight = { enable = true },
      indent = { enable = true },
      modules = {},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss",
          node_incremental = "<leader>nn",
          node_decremental = "<leader>np",
          scope_incremental = "<leader>sn",
          scope_dencremental = "<leader>sp",
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      },
    }) -- Remove the trailing comma here
  end,
  build = ":TSUpdate",
}
