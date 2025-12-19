return {
  recommended = {
    ft = { "vb", "vbnet" },
    root = {
      "*.vbproj",
    },
  },
  { "CoolCoderSuper/vbnet.nvim", config = function()
    require("vbnet").setup()

    local cmd = {}
    if vim.fn.executable("vb-ls") == 1 then
      cmd = { "vb-ls" }
    else
      cmd = { "dotnet", "tool", "run", "vb-ls" }
    end

    vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'BufWinEnter' }, {
      pattern = { '*.vb' },
      callback = function()
        vim.lsp.start({
          name = "vb-ls",
          cmd = cmd,
          root_markers = { '*.sln', '*.vbproj' },
          filetypes = { 'vbnet' },
          init_options = {
            AutomaticWorkspaceInit = true,
          },
        })
      end
    })

  end },
}
