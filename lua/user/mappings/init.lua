vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal" })
vim.keymap.set("v", "<C-c>", "\"+y", { desc = "Copy to system clipboard", silent = false })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard", silent = false })

local smart_splits = require('smart-splits')
vim.keymap.set("n", "<C-Up>", smart_splits.resize_up, { noremap = true, silent = true, desc = "Resize Up" })
vim.keymap.set("n", "<C-Down>", smart_splits.resize_down, { noremap = true, silent = true, desc = "Resize Down" })
vim.keymap.set("n", "<C-Left>", smart_splits.resize_left, { noremap = true, silent = true, desc = "Resize Left" })
vim.keymap.set("n", "<C-Right>", smart_splits.resize_right, { noremap = true, silent = true, desc = "Resize Right" })

vim.keymap.set("n", "<cs-Up>", smart_splits.swap_buf_up, { noremap = true, silent = true, desc = "Swap Buffer Up" })
vim.keymap.set("n", "<cs-Down>", smart_splits.swap_buf_down, { noremap = true, silent = true, desc = "Swap Buffer Down" })
vim.keymap.set("n", "<cs-Left>", smart_splits.swap_buf_left, { noremap = true, silent = true, desc = "Swap Buffer Left" })
vim.keymap.set("n", "<cs-Right>", smart_splits.swap_buf_right,
  { noremap = true, silent = true, desc = "Swap Buffer Right" })

-- vim.keymap.set("n", "<C-w>w", smart_splits.start_resize_mode, { noremap = true, silent = true, desc = "Resize Mode" })

vim.keymap.set({ "n", "o", "x", "v" }, "gh", "^", { noremap = true, silent = true, desc = "Go to line start" })
vim.keymap.set({ "n", "o", "x", "v" }, "gl", "$", { noremap = true, silent = true, desc = "Go to line end" })
vim.keymap.set("n", "<C-l>", "<cmd>nohl<CR>", { noremap = true, silent = true, desc = "Toggle Terminal" })
vim.keymap.set("n", "U", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle undotree" })
vim.keymap.set("n", "w", "<Plug>(smartword-w)", { noremap = true, silent = true, desc = "Next Word" })
vim.keymap.set("n", "<A-k>", "<Plug>GoNSMUp", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("n", "<A-j>", "<Plug>GoNSMDown", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("x", "<A-k>", "<Plug>GoVSMUp", { noremap = true, silent = true, desc = "Move up" })
vim.keymap.set("x", "<A-j>", "<Plug>GoVSMDown", { noremap = true, silent = true, desc = "Move down" })
vim.keymap.set("v", "x", "x", { noremap = true, silent = true })

vim.keymap.set('n', '<A-.>', "<cmd>BufferLineCycleNext<cr>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set('n', '<A-,>', "<cmd>BufferLineCyclePrev<cr>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set('n', '<A-x>', function() require("bufdelete").bufdelete(0, true) end,
  { noremap = true, silent = true, desc = "Close Buffer" })
vim.keymap.set('n', '<A-1>', "<cmd>BufferLineGoToBuffer 1<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 1" })
vim.keymap.set('n', '<A-2>', "<cmd>BufferLineGoToBuffer 2<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 2" })
vim.keymap.set('n', '<A-3>', "<cmd>BufferLineGoToBuffer 3<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 3" })
vim.keymap.set('n', '<A-4>', "<cmd>BufferLineGoToBuffer 4<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 4" })
vim.keymap.set('n', '<A-5>', "<cmd>BufferLineGoToBuffer 5<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 5" })
vim.keymap.set('n', '<A-6>', "<cmd>BufferLineGoToBuffer 6<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 6" })
vim.keymap.set('n', '<A-7>', "<cmd>BufferLineGoToBuffer 7<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 7" })
vim.keymap.set('n', '<A-8>', "<cmd>BufferLineGoToBuffer 8<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 8" })
vim.keymap.set('n', '<A-9>', "<cmd>BufferLineGoToBuffer 9<cr>",
  { noremap = true, silent = true, desc = "Go to Buffer 9" })
vim.keymap.set('n', '<C-.>', "<cmd>BufferLineMoveNext<cr>", { noremap = true, silent = true, desc = "Move Buffer Right" })
vim.keymap.set('n', '<C-,>', "<cmd>BufferLineMovePrev<cr>", { noremap = true, silent = true, desc = "Move Buffer Left" })

local wk = require("which-key")
local telescope = require("telescope.builtin")

local function oldestFile()
  local oldest_file = vim.v.oldfiles[1]
  if oldest_file ~= nil then
    vim.cmd("edit " .. oldest_file)
  end
end

vim.diagnostic.config({
  virtual_text = false,
})
-- vim.keymap.set("t", "<leader>ot", "<cmd>ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal"})

local toggleterms = require("user.util.toggleterms")

vim.keymap.set("t", "<A-.>", toggleterms.nextTerminal, { noremap = true, silent = true, desc = "Next Terminal" })
vim.keymap.set("t", "<A-,>", toggleterms.prevTerminal, { noremap = true, silent = true, desc = "Previous Terminal" })
vim.keymap.set("t", "<C-.>", toggleterms.swapNext, { noremap = true, silent = true, desc = "Swap With Next Terminal" })
vim.keymap.set("t", "<C-,>", toggleterms.swapPrev,
  { noremap = true, silent = true, desc = "Swap With Previous Terminal" })
vim.keymap.set("t", "<C-A-.>", toggleterms.createNextTerminal,
  { noremap = true, silent = true, desc = "Create Next Terminal" })
vim.keymap.set("t", "<C-A-,>", toggleterms.createPrevTerminal,
  { noremap = true, silent = true, desc = "Create Previous Terminal" })
vim.keymap.set("t", "<A-1>", function() toggleterms.getTerminal(1) end,
  { noremap = true, silent = true, desc = "Go To Terminal 1" })
vim.keymap.set("t", "<A-2>", function() toggleterms.getTerminal(2) end,
  { noremap = true, silent = true, desc = "Go To Terminal 2" })
vim.keymap.set("t", "<A-3>", function() toggleterms.getTerminal(3) end,
  { noremap = true, silent = true, desc = "Go To Terminal 3" })
vim.keymap.set("t", "<A-4>", function() toggleterms.getTerminal(4) end,
  { noremap = true, silent = true, desc = "Go To Terminal 4" })
vim.keymap.set("t", "<A-5>", function() toggleterms.getTerminal(5) end,
  { noremap = true, silent = true, desc = "Go To Terminal 5" })
vim.keymap.set("t", "<A-6>", function() toggleterms.getTerminal(6) end,
  { noremap = true, silent = true, desc = "Go To Terminal 6" })
vim.keymap.set("t", "<A-7>", function() toggleterms.getTerminal(7) end,
  { noremap = true, silent = true, desc = "Go To Terminal 7" })
vim.keymap.set("t", "<A-8>", function() toggleterms.getTerminal(8) end,
  { noremap = true, silent = true, desc = "Go To Terminal 8" })
vim.keymap.set("t", "<A-9>", function() toggleterms.getTerminal(9) end,
  { noremap = true, silent = true, desc = "Go To Terminal 9" })
vim.keymap.set("t", "<leader>ot", toggleterms.toggleTerminal, { noremap = true, silent = true, desc = "Toggle Terminal" })

local function format()
  if not require('conform').format({ async = true }) then
    vim.lsp.buf.format({ async = true })
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  callback = function(ev)
    if vim.bo.filetype == 'help' then
      vim.keymap.set('n', "<CR>", "<C-]>", {
        noremap = true,
        silent = true,
        buffer = ev.buf,
        desc = "Go to tag"
      })
    end
  end
})

vim.keymap.set('n', 'zO', require('ufo').openAllFolds, { desc = "Open all folds" })
vim.keymap.set('n', 'zC', require('ufo').closeAllFolds, { desc = "Close all folds" })
vim.keymap.set('n', 'zK', require('ufo').peekFoldedLinesUnderCursor, { desc = "Preview Fold" })

vim.keymap.set('i', '<C-p>', '<C-x><C-p>', { noremap = true, silent = true })

wk.add({

  { "<leader><leader>", telescope.find_files, desc = "Find Files" },
  { "<leader>x", require('notify').dismiss, desc = "Dismiss Notifications" },
  { "<leader>o", group = "open" },
  { "<leader>or", telescope.oldfiles, desc = "Recent File" },
  { "<leader>ot", toggleterms.toggleTerminal, desc = "Terminal" },
  { "<leader>on", "<cmd>Telescope notify<cr>", desc = "Notifications" },
  { "<leader>op", "<cmd>NvimTreeToggle<cr>", desc = "File Browser", icon = { icon = "", hl = "WhichKeyIconYellow" } },
  { "<leader>oR", oldestFile, desc = "Most Recent" },
  { "<leader>h", group = "help" },
  { "<leader>l", group = "lang" },
  { "<leader>c", group = "comment" },
  { "<leader>ll", require('lsp_lines').toggle, desc = "Toggle Diagnostics" },
  { "<leader>lf", format, desc = "Format Document" },
  { "<leader>li", "<CMD>LspInfo<CR>", desc = "LSP Clients Info" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "Rename Variable" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Run Code Action" },
  { "<leader>le", vim.lsp.codelens.run, desc = "Run Codelens" },
  { "<leader>ls", require("nvim-navbuddy").open, desc = "Symbols" },
  { "<leader>lS", "<cmd>Trouble lsp toggle win={position=right}<cr>", desc = "Toggle LSP References" },
  { "<leader>lt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Diagnostics" },
  { "<leader>lT", function() require('neotest').summary.toggle() end, desc = "Toggle Test Summary" },
  { "<leader>l?", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    desc = "Toggle Inline Hints" },
  { "g", group = "go to" },
  { "gd", vim.lsp.buf.definition, desc = "Definition" },
  { "gD", vim.lsp.buf.declaration, desc = "Declaration" },
  { "gi", vim.lsp.buf.implementation, desc = "Implementation" },
  { "gr", vim.lsp.buf.references, desc = "References" },
  { "g[", function() vim.diagnostic.jump({ count = -1 }) end, desc = "Previous Diagnostic" },
  { "g]", function() vim.diagnostic.jump({ count = 1 }) end, desc = "Next Diagnostic" },
  { "gt", telescope.live_grep, desc = "Text" },
  { 'vi<tab>', require('user.util.select-indentline').select, desc = "Select Indent" },
  { 'di<tab>', require('user.util.select-indentline').delete, desc = "Select Indent" },
})

local Hydra = require("hydra")
local gitsigns = require('gitsigns')

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

Hydra({
  name = 'Git',
  hint = hint,
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = {
      float_opts = {
        border = 'rounded'
      }
    },
    on_enter = function()
      vim.cmd 'mkview'
      vim.cmd 'silent! %foldopen!'
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd 'loadview'
      vim.api.nvim_win_set_cursor(0, cursor_pos)
      vim.cmd 'normal zv'
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.preview_hunk_inline()
    end,
  },
  mode = { 'n', 'x' },
  body = '<leader>g',
  heads = {
    { 'J',
      function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.nav_hunk('next') end)
        return '<Ignore>'
      end,
      { expr = true, desc = 'next hunk' } },
    { 'K',
      function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.nav_hunk('prev') end)
        return '<Ignore>'
      end,
      { expr = true, desc = 'prev hunk' } },
    { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
    { 'u', gitsigns.stage_hunk, { desc = 'undo last stage' } },
    { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
    { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
    { 'd', gitsigns.preview_hunk_inline, { nowait = true, desc = 'toggle deleted' } },
    { 'b', gitsigns.blame_line, { desc = 'blame' } },
    { 'B', function() gitsigns.blame_line { full = true } end, { desc = 'blame show full' } },
    { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
    { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
  }
})
