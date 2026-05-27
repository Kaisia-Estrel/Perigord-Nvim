local text_header =
{ "                                                                                   ",
  "                                                                                   ",
  "                                                                                   ",
  "                                                                                   ",
  "                                                                                   ",
  "         -╲         '-                                                             ",
  "       -' :╲        │ '-                                                           ",
  "     -'   : ╲       │   '-                           ████                          ",
  "   -'·    :  ╲      │     '-                         ████                          ",
  "  '.-.·   :   ╲     │       │                                                      ",
  "  │. .-·  :    ╲    │       │    ▄▄▄          ▗▄▄▄   ▅▅▅▅   ▄▄▄  ▗▄▄▖   ▗▄▄▄▄▄▖    ",
  "  │ . .-· :     ╲   │       │    ▜███▙       ▟███▛   ████   ███▙▟████▙▄▟███████▙   ",
  "  │. . .-·;      ╲  │       │     ▜███▙     ▟███▛    ████   ████████████████████▙  ",
  "  │ . . .-│       ╲ │       │      ▜███▙   ▟███▛     ████   ███▛    ▜████▛    ▜██▌ ",
  "  │. . . .│╲       ╲│       │       ▜███▙ ▟███▛      ████   ███      ▐███     ▐██▌ ",
  "  │ . . . │ ╲       ;-      │        ▜███▇███▛       ████   ███       ██▌      ██▌ ",
  "  │. . . .│  ╲      :·-     │         ▜█████▛        ████   ███       ██▌      ██▌ ",
  "  │ . . . │   ╲     : .-    │          ▜███▛         ████   ███       ██▌      ██▌ ",
  "  │. . . .│    ╲    :. .-   │           ▜█▛          ████   ███       ██▌      ██▌ ",
  "  `- . . .│     ╲   : . .- -'                                                      ",
  "    `- . .│      ╲  :. ..-'                                                        ",
  "      `-. │       ╲ :..-'                                                          ",
  "         `│        ╲;-'                                                            ",
  "                                                                                   ",
  "                                                                                   " }



return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    event = 'User',
    lazy = true,
    config = function()

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()


          local stats = require('lazy').stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100


          require('dashboard').setup {
            theme = 'doom',
            config = {
              header = text_header,
              center = {
                {
                  icon = '󰪺 ',
                  icon_hl = 'Title',
                  desc = 'Open Recent Files           ',
                  desc_hl = 'String',
                  key = 'r',
                  keymap = 'SPC o',
                  key_hl = 'Number',
                  key_format = ' %s',
                  action = 'lua require("telescope.builtin").oldfiles()',
                },
                {
                  icon = '󱋡 ',
                  icon_hl = 'Title',
                  desc = 'Open Most Recent File       ',
                  desc_hl = 'String',
                  key = 'R',
                  keymap = 'SPC o',
                  key_hl = 'Number',
                  key_format = ' %s',
                  action = "execute 'edit' fnameescape(v:oldfiles[0])",
                },
                {
                  icon = '󰈞 ',
                  icon_hl = 'Title',
                  desc = 'Find Text                   ',
                  desc_hl = 'String',
                  key = 't',
                  keymap = 'g',
                  key_hl = 'Number',
                  key_format = ' %s',
                  action = 'lua require("telescope.builtin").live_grep()',
                },
              },
              footer = {
                "Last Opened File: " .. vim.v.oldfiles[1],
                "Current Directory: " .. vim.fn.getcwd(),
                "",
                "Loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
              }
            }
          }
        end
      })
    end,
  }
}
