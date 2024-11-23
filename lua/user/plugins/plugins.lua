return {
  { "anuvyklack/vim-smartword" },
  { "eraserhd/parinfer-rust", build = "cargo build --release" },
  { "farmergreg/vim-lastplace" },
  { "nvim-treesitter/playground" },
  { "terrastruct/d2-vim" },
  { "xuhdev/vim-latex-live-preview" },
  { "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "kylechui/nvim-surround", opts = {} },
  { "xiyaowong/link-visitor.nvim", opts = {} },
  { "booperlv/nvim-gomove", opts = {} },
  { "j-hui/fidget.nvim", opts = {
    notification = {
      window = {
        winblend = 0
      }
    }
  }
  },
  { "DanilaMihailov/beacon.nvim", opts = {
    winblend = 0
  } },
  { "simrat39/symbols-outline.nvim", opts = {} },
  { "SmiteshP/nvim-navic", opts = {
    lsp = { auto_attach = true }
  } },
  { "utilyre/barbecue.nvim", opts = {}, dependencies = { "SmiteshP/nvim-navic" } },
  { "SmiteshP/nvim-navbuddy", opts = {
    lsp = { auto_attach = true }
  }, dependencies = { "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" } },
  { "TimUntersberger/neogit", opts = {} },
  { "stevearc/dressing.nvim", opts = {} },
  { "luukvbaal/statuscol.nvim", opts = {} },
  { "kevinhwang91/nvim-bqf", opts = {
    preview = {
      winblend = 0
    }
  } },
  { "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install"
  },
  { "wakatime/vim-wakatime" },
  { "andweeb/presence.nvim", opts = {} },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  { "jmbuhr/otter.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" }, opts = {} },
  { "mbbill/undotree" },
  { "karb94/neoscroll.nvim", opts = {} },
  { "lukas-reineke/indent-blankline.nvim",
    config = function()
      local hooks = require('ibl.hooks')
      require('ibl').setup({ exclude = {
        filetypes = { 'dashboard' }
      },
        scope = {
          highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
          }
        }
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
    name = 'ibl' },
  { "arp242/undofile_warn.vim" },
  { "nacro90/numb.nvim", opts = {} },
  { "famiu/bufdelete.nvim" },
  { "https://gitlab.com/HiPhish/rainbow-delimiters.nvim" },
  { "ggandor/flit.nvim",
    opts = {},
    dependencies = { "ggandor/leap.nvim", "tpope/vim-repeat" }
  },
  { "ggandor/leap.nvim",
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings()
      require('leap').opts.preview_filter = function() return false end

      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
      vim.api.nvim_set_hl(0, 'LeapMatch', {
        fg = 'white', bold = true, nocombine = true,
      })
    end
  },
  { 'mrjones2014/smart-splits.nvim' },
  { 'max397574/colortils.nvim',
    opts = {
      mappings = {
        replace_default_format = "<CR>",
      }
    }
  },
  { "rcarriga/nvim-notify",
    lazy = false,
    priority = 1000,
    opts = { background_colour = '#00000000', max_width = 100 },
    init = function()
      vim.notify = require('notify')
    end
  },
  { "norcalli/nvim-colorizer.lua", opts = {} },
  { "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "<leader>cc",
        block = "<leader>cb",
      },
      opleader = {
        line = "<leader>cc",
        block = "<leader>cb",
      }
    }
  }
}
