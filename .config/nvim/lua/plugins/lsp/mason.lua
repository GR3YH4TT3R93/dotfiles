return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    require("mason").setup({})

    require("mason-null-ls").setup({
      ensure_installed = {
        -- Opt to list sources here, when available in mason.
        "prettierd",
        "eslint_d",
      },
      automatic_installation = { exclude = { "stylua", "gitsigns" } },
      handlers = {},
    })

    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.gitsigns,
      },
      -- Format on save using null-ls instead of lsp server.
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        -- Servers that are installed by default in mason.
        "volar",
        "tsserver",
        "tailwindcss",
        "bashls",
        "jsonls",
      },
      automatic_installation = { exclude = "lua_ls" },
      handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
      },
    })

    -- Servers that are not installed by mason.
    require("lspconfig").lua_ls.setup({
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              diagnostics = {
                globals = { "vim", "bufnr" },
              },
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                },
                -- or pull in all of "runtimepath". NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              },
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end,
    })
  end,
}
