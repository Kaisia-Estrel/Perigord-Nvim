return {
  recommended =
  {
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root = {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac", -- AutoTools
    },
  },

  -- Add C/C++ to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cpp" } },
  },

  {
    "p00f/clangd_extensions.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = false,
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },
        },
      })

      require('lspconfig').clangd.setup(
        {
          on_attach = function(_, bufnr)
            local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

            vim.keymap.set('n', "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>",
              { buffer = bufnr, desc = "Switch header/source" })
            vim.keymap.set("n", "<leader>l?", function()
              if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
                vim.api.nvim_create_autocmd("InsertEnter", { group = group, buffer = bufnr,
                  callback = require("clangd_extensions.inlay_hints").disable_inlay_hints
                })
                vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, { group = group, buffer = bufnr,
                  callback = require("clangd_extensions.inlay_hints").set_inlay_hints
                })
              else
                vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
              end
            end, { buffer = bufnr, desc = "[l]sp [h]ints toggle" })
          end,
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        }
      )
    end,
  },

  {
    "nvim-cmp",
    opts = function(_, opts)
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = opts.sorting.comparators or {}
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
    end,
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["codelldb"] then
        require("dap").adapters["codelldb"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = {
              "--port",
              "${port}",
            },
          },
        }
      end
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
