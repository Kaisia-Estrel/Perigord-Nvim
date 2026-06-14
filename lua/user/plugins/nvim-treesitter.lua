return {
  -- { "nvim-treesitter/playground" },
  { "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local ts = require("nvim-treesitter")
      local already_installed = ts.get_installed()
      local to_install = vim.iter(opts.ensure_installed):filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end):totable()
      ts.install(to_install)
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = function()
      return { mode = "cursor", max_lines = 3 }
    end,
  },
  -- { "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {
  --     select = {
  --       enable = true,
  --       keymaps = {
  --         ["af"] = "@function.outer",
  --         ["if"] = "@function.inner",
  --         ["ac"] = "@class.outer",
  --         ["ic"] = "@class.inner",
  --         ["i,"] = "@parameter.inner",
  --         ["a,"] = "@parameter.outer",
  --         ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
  --       },
  --     },
  --     move = {
  --       enable = true,
  --       set_jumps = true,
  --       goto_next_start = {
  --         ["]f"] = "@function.outer",
  --         ["]c"] = { query = "@class.outer", desc = "Next class start" },
  --         ["]o"] = "@loop.*",
  --         ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
  --         ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
  --       },
  --       goto_next_end = {
  --         ["]F"] = "@function.outer",
  --         ["]C"] = "@class.outer",
  --       },
  --       goto_previous_start = {
  --         ["[f"] = "@function.outer",
  --         ["[c"] = "@class.outer",
  --       },
  --       goto_previous_end = {
  --         ["[F"] = "@function.outer",
  --         ["[C"] = "@class.outer",
  --       },
  --       goto_next = {
  --         ["]d"] = "@conditional.outer",
  --       },
  --       goto_previous = {
  --         ["[d"] = "@conditional.outer",
  --       }
  --     },
  --     swap = {
  --       enable = true,
  --       swap_next = {
  --         ["<A-l>"] = "@parameter.inner",
  --       },
  --       swap_previous = {
  --         ["<A-h>"] = "@parameter.inner",
  --       },
  --     },
  --   } }
}
