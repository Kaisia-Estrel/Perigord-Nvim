return {
  recommended = {
    ft = "idris2",
    root = { "*.ipkg" }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "idris")
    end
  },

  { 'ShinKage/idris2-nvim',
    opts = {},
    dependencies = { 'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim' } },

}
