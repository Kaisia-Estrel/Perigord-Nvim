return {
  { "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      { "saadparwaiz1/cmp_luasnip", dependencies = {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets"
      } },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "chrisgrieser/cmp-nerdfont" },
      { "kdheepak/cmp-latex-symbols" },
      { "FelipeLema/cmp-async-path" },
      { "lukas-reineke/cmp-rg" },
      { "hrsh7th/cmp-emoji" },
      { "uga-rosa/cmp-dictionary", },
      { "Exafunction/codeium.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
      { "onsails/lspkind.nvim" },
      { "amarakon/nvim-cmp-fonts" },
      { "ray-x/cmp-treesitter" },
      { "SergioRibera/cmp-dotenv" },
      { "hrsh7th/cmp-cmdline" },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      require("codeium").setup({
        tools = {
          language_server = vim.fn.exepath("codeium_language_server");
        }
      })

      require("luasnip.loaders.from_vscode").lazy_load()
      local format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        if entry.source.name == "codeium" then
          strings[1] = ""
          strings[2] = "AI"
        elseif entry.source.name == "calc" then
          strings[1] = ''
          strings[2] = 'Calc'
        elseif entry.source.name == "dotenv" then
          strings[1] = '$'
          strings[2] = 'Envvar'
        elseif entry.source.name == "dictionary" then
          strings[1] = ''
          strings[2] = 'Word'
        elseif entry.source.name == "nvim_lsp_signature_help" then
          strings[1] = '󰡱'
          strings[2] = ''
        end
        if strings[1] == "String" then
          strings[1] = "󰉿"
          strings[2] = "String"
        end

        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    " .. (strings[2] or "") .. ""
        return kind
      end



      require('cmp').setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = (require("user.util").union_with(nil, opts.sources, cmp.config.sources({
          { name = 'nvim_lsp', priority = 10 },
          { name = 'nvim_lsp_signature_help', priority = 10 },
          { name = 'codeium', priority = 9 },
          { name = 'luasnip', priority = 8, option = { show_autosnippets = true } },
          { name = 'treesitter', priority = 8, keyword_length = 2 },
          { name = 'buffer', priority = 7, keyword_length = 3 },
          { name = 'rg', priority = 5, keyword_length = 4 },
          { name = 'dictionary', priority = 3, keyword_length = 5 },
          { name = 'async_path' },
          { name = 'dotenv', option = { eval_on_confirm = true } },
          { name = 'calc' },
          { name = 'nerdfont' },
          { name = 'emoji' },
          { name = "fonts", option = { space_filter = "-" } },
          { name = 'latex_symbols' },
        }))),
        sorting = {
          priority_weight = 1.0,
          comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.order,
          }
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText'
          }
        },

        window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            border = 'rounded',
            col_offset = -3,
            side_padding = 0,
          },
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = format
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        })
      })

      local cmd_mapping = cmp.mapping.preset.cmdline()
      cmd_mapping["<C-k>"] = cmd_mapping["<C-P>"]
      cmd_mapping["<C-P>"] = nil
      cmd_mapping["<C-j>"] = cmd_mapping["<C-N>"]
      cmd_mapping["<C-N>"] = nil

      cmp.setup.cmdline("/", {
        sources = cmp.config.sources({
          { name = "treesitter" },
          { name = "nvim_lsp_document_symbol" },
          { name = "buffer" }
        }),
        mapping = cmd_mapping,
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = format
        },
      })

      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "cmdline", priority = 10 },
          { name = "treesitter", priority = 5 },
          { name = "nvim_lsp_document_symbol", priority = 5 },
          { name = "buffer", priority = 5 },
        }),
        mapping = cmd_mapping,
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = format
        },
      })

      local dict_path = os.getenv("XDG_DATA_HOME") .. "/dict"
      require('cmp_dictionary').setup({
        paths = { dict_path .. "/wamerican.txt", dict_path .. "/wbritish.txt" },
        exact_length = 5,
        first_case_insensitive = true
      })
    end,
  }
}
