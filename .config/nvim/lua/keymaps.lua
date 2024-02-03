-- Locals {{{
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
--}}}

-- Move Commands{{{

-- Normal-mode commands{{{
vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
vim.keymap.set("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
vim.keymap.set("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
-- }}}

-- Visual-mode commands{{{
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
-- }}}

--}}}

-- Neo Tree Commands{{{
vim.keymap.set("n", "<C-n>", ":Neotree toggle<cr>", opts)
-- }}}

-- LazyGit Commands{{{
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", opts)
--}}}

-- Write Quit eXit {{{
vim.keymap.set("n", "<C-w>", ":w<cr>", opts)
vim.keymap.set("v", "<C-w>", "<esc> :w<cr>", opts)
vim.keymap.set("i", "<C-w>", "<esc> :w<cr>", opts)
vim.keymap.set("n", "<C-q>", ":q!<cr>", opts)
vim.keymap.set("v", "<C-q>", "<esc> :q!<cr>", opts)
vim.keymap.set("i", "<C-q>", "<esc> :q!<cr>", opts)
vim.keymap.set("n", "<C-x>", ":x<cr>", opts)
vim.keymap.set("v", "<C-x>", "<esc> :x<cr>", opts)
vim.keymap.set("i", "<C-x>", "<esc> :x<cr>", opts)
--}}}

-- ToggleTerm Commands{{{
vim.keymap.set("n", "<leader>d", ':TermExec cmd="prd"<CR>')
vim.keymap.set("i", "<leader>d", ':TermExec cmd="prd"<CR>i')
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
-- }}}

-- Telescope Commands{{{
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fgg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fgs", builtin.git_stash, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>fdt", builtin.lsp_type_definitions, {})
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fdi", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fqf", builtin.quickfix, {})
vim.keymap.set("n", "<leader>fqfh", builtin.quickfixhistory, {})
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>fy", extensions.neoclip.default, {})
--}}}

-- Nvim Space Folding{{{
vim.keymap.set("n", "<Space>", "@=(foldlevel('.')?'za':'\\<Space>')<CR>", opts)
vim.keymap.set("v", "<Space>", "zf", opts)
-- }}}

-- Close Current Buffer{{{
vim.keymap.set("n", "<leader>bd", ":bd<cr>", opts)
vim.keymap.set("v", "<leader>bd", "<esc> :bd<cr>", opts)
vim.keymap.set("i", "<leader>bd", "<esc> :bd<cr>", opts)
-- }}}

-- Move to Previous and Next Buffer {{{
vim.keymap.set("n", "<C-h>", ":bprev<cr>", opts)
vim.keymap.set("v", "<C-h>", "<esc> :bprev<cr>", opts)
vim.keymap.set("i", "<C-h>", "<esc> :bprev<cr>", opts)

vim.keymap.set("n", "<C-l>", ":bnext<cr>", opts)
vim.keymap.set("v", "<C-l>", "<esc> :bnext<cr>", opts)
vim.keymap.set("i", "<C-l>", "<esc> :bnext<cr>", opts)
-- }}}

-- Run Eslint with Leader lf {{{
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end, opts)
-- }}}

-- Diagnostic Window on CursorHold {{{
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opt = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = "",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opt)
  end,
})
--}}}

-- Replace Current Word {{{
vim.keymap.set("n", "<Leader>cw", "*Ncgn", opts)
--}}}

-- LSP Commands {{{
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local op = { buffer = event.buf }

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", op)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", op)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", op)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", op)
    vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", op)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", op)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", op)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", op)
    vim.keymap.set({ "n", "x" }, "<leader>fm", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", op)
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", op)
  end,
})
--}}}
