return {
  recommended = {
    ft = { "haskell", "lhaskell" },
    root = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "haskell")
    end
  },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^10",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    lazy = false,
    dependencies = {
      { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
    },
    config = function()
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("ht")
      end
      vim.g.haskell_tools = {
        tools = {
          repl = {
            handler = 'toggleterm',
            auto_focus = true
          }
        },
        hls = {
          on_attach = function(_, bufnr, ht)
            local opts = function(extra)
              return vim.tbl_extend('force', { noremap = true, silent = true, buffer = bufnr, }, extra or {})
            end
            vim.keymap.set('n', "<leader>lp", function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end,
              opts({ desc = "Toggle Repl" }))
            vim.keymap.set('n', "<leader>lh", "<cmd>Telescope ht hoogle_signature<cr>", opts({ desc = "Hoogle Search" }))
          end
        }

      }
      -- vim.treesitter.start
    end
    --
    --   vim.g.haskell_tools = {
    --     tools = {
    --       repl = {
    --         handler = 'toggleterm',
    --         auto_focus = true
    --       }
    --     },
    --   }
    -- end,
  },
  --
  --   {
  --     "mfussenegger/nvim-dap",
  --   },
  --
  --   {
  --     "nvim-neotest/neotest",
  --     dependencies = {
  --       { "mrcjkb/neotest-haskell", "nvim-neotest/nvim-nio" },
  --     },
  --     opts = function(_, opts)
  --       if opts == nil or vim.tbl_isempty(opts) then
  --         return {
  --           adapters = { require('neotest-haskell') }
  --         }
  --       else
  --         table.insert(opts.adapters, require('neotest-haskell'))
  --       end
  --     end,
  --   },
  --
  --   {
  --     "mrcjkb/haskell-snippets.nvim",
  --     dependencies = { "L3MON4D3/LuaSnip" },
  --     ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  --     config = function()
  --       local haskell_snippets = require("haskell-snippets").all
  --       require("luasnip").add_snippets("haskell", haskell_snippets, { key = "haskell" })
  --     end,
  --   },
  --
  --   {
  --     "luc-tielen/telescope_hoogle",
  --     ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  --     dependencies = {
  --       { "nvim-telescope/telescope.nvim" },
  --     },
  --     config = function()
  --       local ok, telescope = pcall(require, "telescope")
  --       if ok then
  --         telescope.load_extension("hoogle")
  --       end
  --     end,
  --   },
}
