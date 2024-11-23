return {
  recommended = {
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root = { "tsconfig.json", "package.json", "jsconfig.json" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "javascript")
      table.insert(opts.ensure_installed, "typescript")
    end
  },


  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "yioneko/nvim-vtsls" },
    opts = function(_, opts)
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      return vim.tbl_deep_extend('keep', opts, {
        setup = {
          vtsls = {
            cmd = { "vtsls", "--stdio" },
            on_attach = function(client, _)
              vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
                local locations = command.arguments[3]
                if locations and #locations > 0 then
                  local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
                  vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
                  vim.api.nvim_command("lopen")
                end
              end
            end,
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
            settings = {
              complete_function_calls = true,
              vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                  completion = {
                    enableServerSideFuzzyMatch = true,
                  },
                },
              },
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCalls = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
          },
        },
      })
    end,
  },

  -- { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" },
  --   opts = {
  --     adapters = { 'pwa-node' },
  --     -- adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  --     debugger_cmd = { "js-debug" }
  --   },
  -- },
  --
  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local configurations = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require 'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
        }
      }

      return vim.tbl_deep_extend('keep', opts, {
        adapters = {
          ["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = 'js-debug',
              args = { "${port}", },
            },
          }
        },
        configurations = {
          javascript = configurations,
          typescript = configurations
        }
      })
    end
  },

  -- Filetype icons
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
