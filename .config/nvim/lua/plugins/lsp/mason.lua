return {
  "williamboman/mason.nvim",
  dependencies = {
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  -- { "VonHeikemen/lsp-zero.nvim", branch = 'v3.x', }
  },
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason").setup({})
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Opt to list sources here, when available in mason.
        "prettier",
        "eslint-lsp"
      },
      automatic_installation = false,
      handlers = {},
    })
    require("null-ls").setup({
      sources = {
        -- Anything not supported by mason.
        "stylua"
      }
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "volar", "tailwindcss", "tsserver" },
      automatic_installation = { excludes = "lua_ls" },
    })

    require("mason-lspconfig").setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities
        })
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      -- ["rust_analyzer"] = function ()
      --     require("rust-tools").setup {}
      -- end
    })

    require("lspconfig").lua_ls.setup({
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path.."/.luarc.json") and not vim.loop.fs_stat(path.."/.luarc.jsonc") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              diagnostics = {
                globals = { "vim", "bufnr" }
              },
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT"
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end
    })
  end
}
