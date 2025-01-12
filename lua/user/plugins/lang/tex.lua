return {
  recommended = {
    ft = { "tex" }
  },
  {
    "f3fora/nvim-texlabconfig",
    opts = {},
    build = 'go build'
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local nvim_texlabconfig = vim.fn.stdpath("data") .. "/lazy/nvim-texlabconfig/nvim-texlabconfig"
      local executable = 'zathura'
      local args = {
        '--synctex-editor-command',
        nvim_texlabconfig .. [[-file '%%%{input}' -line %%%{line} -server ]] .. vim.v.servername,
        '--synctex-forward',
        '%l:1:%f',
        '%p',
      }
      opts.setup.texlab = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>lC", "<cmd>VimtexCompile<cr>", { desc = "Compile", buffer = bufnr })
          vim.keymap.set("n", "<leader>l3", "<cmd>VimtexCountWords!<cr>",
            { desc = "Detailed Word Count", buffer = bufnr })
          vim.keymap.set("n", "<leader>l#", "<cmd>VimtexCountLetters!<cr>",
            { desc = "Detailed Letter Count", buffer = bufnr })
          vim.keymap.set("n", "<leader>lp", "<cmd>VimtexTocToggle<cr>",
            { desc = "Toggle Table of Contents", buffer = bufnr })
        end,
        setting = {
          texlab = {
            forwardSearch = {
              executable = executable,
              args = args,
            },
          },
        },
      }
    end
  },
}
