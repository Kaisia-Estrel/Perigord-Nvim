return {
  recommended = {
    ft = "rust",
    root = { "Cargo.toml", "rust-project.json" }
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "crates" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "rust")
      table.insert(opts.ensure_installed, "ron")
    end
  },

  {
    "mrcjkb/rustaceanvim",
    dependencies = { "mfussenegger/nvim-dap" },
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    opts = function()
      return {
        tools = {
          hover_actions = {
            replace_builtin_hover = false,
            border = 'rounded'
          }
        },
        server = {
          capabilities = vim.lsp.protocol.make_client_capabilities(),
          on_attach = function(_, bufnr)
            -- vim.keymap.set("n", "<leader>la", function()
            --   vim.cmd.RustLsp("codeAction")
            -- end, { desc = "Code Action", buffer = bufnr })
            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({ 'hover', 'actions' })
            end, { desc = "Documentation", buffer = bufnr })
            vim.keymap.set("n", "<f2>", function()
              vim.cmd.RustLsp("runnables")
            end, { desc = "Run", buffer = bufnr })
            vim.keymap.set("n", "<C-K>", function()
              vim.cmd.RustLsp("openDocs")
            end, { desc = "Open in Doc.rs", buffer = bufnr })
            vim.keymap.set("n", "J", function()
              vim.cmd.RustLsp("joinLines")
            end, { desc = "Open in Doc.rs", buffer = bufnr })

            vim.lsp.codelens.refresh()
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust.
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = function()
        local t = opts
        local codelldb_bin = vim.fn.exepath("codelldb")
        local dap = nil

        if codelldb_bin == '' then
          -- vim.notify("**codelldb** not found in PATH", vim.log.levels.ERROR,
          --   { title = "rustaceanvim" }
          -- )
        else
          local extension_path = require('plenary.path'):new(codelldb_bin):parent():parent():joinpath("share")
          local liblldb_path = extension_path:joinpath("lldb"):joinpath("lib"):joinpath("liblldb.so").filename
          dap = {
            adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_bin, liblldb_path),
          }
        end
        t.dap = dap
        return t
      end
      if vim.fn.executable("rust-analyzer") == 0 then
        vim.notify("**rust-analyzer** not found in PATH",
          vim.log.levels.ERROR,
          { title = "rustaceanvim" }
        )
      end
    end,
  },

  -- Correctly setup lspconfig for Rust 🚀
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        taplo = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', "K", require("crates").show_popup, {
              buffer = bufnr,
              desc = "Show Crate Documentation"
            })
          end
        }
      }
    }
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "mrcjkb/rustaceanvim" },
    opts = function(_, opts)
      if opts == nil or vim.tbl_isempty(opts) then
        return {
          adapters = { require('rustaceanvim.neotest') }
        }
      else
        table.insert(opts.adapters, require('rustaceanvim.neotest'))
      end
    end,
  },
}
