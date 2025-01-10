vim.o.iskeyword = vim.o.iskeyword .. ",-"
vim.o.tabstop = 4
vim.o.timeoutlen = 300
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.smarttab = true

vim.o.undofile = true
vim.o.undodir = "/tmp/nvim-undos"

vim.opt.scrolloff = 8
vim.o.wrap = false
vim.o.splitbelow = true
vim.o.mouse = 'a'
vim.o.cmdheight = 0
vim.g.termguicolors = true
vim.cmd [[set clipboard+=unnamed]]

vim.opt.list = true
vim.opt.listchars = {
  space = '·',
  eol = '↴',
}

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.g.mapleader = " "

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.o.relativenumber = false
    vim.o.number = true
  end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.o.relativenumber = true
    vim.o.number = true
  end
})

vim.api.nvim_create_autocmd('RecordingEnter', {
  pattern = '*',
  callback = function()
    vim.notify("Recording Macro: '" .. vim.fn.reg_recording() .. "'")
  end
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  pattern = '*',
  callback = function()
    vim.defer_fn(function()
      vim.notify("Finished Recording Macro: '" .. vim.fn.reg_recorded() .. "'")
    end, 200)
  end
})

vim.api.nvim_create_autocmd({ 'Filetype' }, {
  callback = function(ev)
    if vim.bo.filetype == 'notify'
        or vim.bo.filetype == 'help'
        or vim.bo.filetype == 'qf'
        or vim.bo.filetype == 'trouble'
        or vim.bo.filetype == 'dap-repl'
    then
      vim.defer_fn(function()
        vim.o.number = false
        vim.o.relativenumber = false
        pcall(vim.keymap.set, 'n', '<ESC>', '<cmd>q<cr>', {
          noremap = true, silent = true, buffer = ev.buf
        })

        pcall(vim.keymap.set, 'n', 'q', '<cmd>q<cr>', {
          noremap = true, silent = true, buffer = ev.buf
        })
      end, 20)
    end
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
  end,
})

vim.fn.sign_define("DiagnosticSignError", { text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})

vim.cmd([[au BufReadCmd *.jar,*.xpi,*.cbz call zip#Browse(expand("<amatch>"))]])
