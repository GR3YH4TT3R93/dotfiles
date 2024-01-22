return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*",  -- Use the latest tagged version
  opts = {},  -- This causes the plugin setup function to be called
  keys = {
    {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
    {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>"},
    {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
    {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>"},
    {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
    {"<Leader>a", "<Cmd>MultipleCursorsAddBySearch<CR>", mode = {"n", "x"}},
    {"<Leader>A", "<Cmd>MultipleCursorsAddBySearchV<CR>", mode = {"n", "x"}},
  }
}
