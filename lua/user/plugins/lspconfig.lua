return {
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", opts = {}, name = 'lsp_lines',
    dependencies = { 'neovim/nvim-lspconfig' } },
  { "folke/trouble.nvim", opts = {
    warn_no_results = false,
    open_no_results = true,
    preview = {
      type = "float",
      border = "rounded",
      title = "Preview",
      title_pos = "center",
      position = { 3, 4 },
      size = { width = 0.7, height = 0.4 },
      zindex = 200,
    }
  } },
  { "neovim/nvim-lspconfig",
    dependencies = { "kevinhwang91/nvim-ufo" },
    lazy = true,
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        callback = vim.lsp.codelens.refresh
      })
      vim.lsp.inlay_hint.enable()


      local group = vim.api.nvim_create_augroup("no_inlay_hints_in_insert", { clear = true })
      local prevInlayHintStatus = vim.lsp.inlay_hint.is_enabled()
      vim.api.nvim_create_autocmd("InsertEnter", { group = group,
        callback = function()
          prevInlayHintStatus = vim.lsp.inlay_hint.is_enabled()
          vim.lsp.inlay_hint.enable(false)
        end
      })
      vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, { group = group,
        callback = function()
          vim.lsp.inlay_hint.enable(prevInlayHintStatus)
        end
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      opts.setup.bashls = {}

      for lsp, lsp_opts in pairs(opts.setup) do
        lspconfig[lsp].setup(vim.tbl_deep_extend('keep', lsp_opts, capabilities))
      end
    end
  }
}
