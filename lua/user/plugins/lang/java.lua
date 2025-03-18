return {
  recommended = { ft = "java", root = "pom.xml" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "java")
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
        pattern = { "*.java" },
        callback = function()
          require("jdtls").start_or_attach({
            cmd = { "jdtls" },
            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          })
        end
      })
    end,
  },
}
