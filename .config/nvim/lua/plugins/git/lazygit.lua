return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").load_extension("lazygit")
  end,
  vim.cmd[[autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()]]
}
