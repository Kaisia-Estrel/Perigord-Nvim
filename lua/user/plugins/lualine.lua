return {
  { "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      vim.o.laststatus = 3
    end,
    opts = function()
      local function cur_macro()
        local recording = vim.fn.reg_recording()
        if recording ~= '' then
          return "Recording Macro: '" .. recording .. "'"
        else
          return ""
        end
      end

      local wordcount = ''
      local lettercount = ''
      vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter', 'BufWinEnter', 'BufWritePost', 'TextChanged' }, {
        pattern = '*.tex',
        callback = function()
          local file = os.tmpname()
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          local fd = vim.loop.fs_open(file, 'w', 438)
          if fd then
            vim.loop.fs_write(fd, table.concat(lines, '\n'), -1)
            vim.loop.fs_close(fd)
            vim.system({ "texcount", "-nosub", "-sum", "-letter", "-template={SUM}", file },
              { text = true, timeout = 2000, stdout = function(_, data)
                if data then
                  for line in data:gmatch("[^\r\n]+") do
                    if line:match('!!!') ~= nil then
                      goto continue
                    end
                    lettercount = line
                    ::continue::
                  end
                end
              end }):wait()
            vim.system({ "texcount", "-nosub", "-sum", "-template={SUM}", file },
              { text = true, timeout = 2000, stdout = function(_, data)
                if data then
                  for line in data:gmatch("[^\r\n]+") do
                    if line:match('!!!') ~= nil then
                      goto continue
                    end
                    wordcount = line
                    ::continue::
                  end
                end
              end }):wait()
            os.remove(file)
          else
            error("Failed to write to /tmp/" .. file)
          end
        end
      })

      return {
        options = {
          theme = "catppuccin",
          disabled_filetypes = { "dashboard", "TelescopePrompt" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filetype", "filename", "diagnostics" },
          lualine_c = { "branch", "diff", function() return ToggletermStatus() end },
          -- Lambda that returns ToggletermStatus() since it's defined later in the program

          lualine_x = { cur_macro },
          lualine_y = { { "encoding", fmt = function(str)
            if vim.bo.filetype == 'tex' then
              return wordcount .. " Words, " .. lettercount .. " Characters"
            else
              return str
            end
          end }, "location", "progress" },
          lualine_z = { "os.date('%I:%M %p')" }
        }
      }
    end
  }
}
