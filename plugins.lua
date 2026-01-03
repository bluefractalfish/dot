return {
 {
   "malbertzard/inline-fold.nvim",

   opts = {
     defaultPlaceholder = "…",
     queries = {
       html = {
         { pattern = 'class="([^"]*)"', placeholder = "@" }, -- classes in html
         { pattern = 'href="(.-)"' }, -- hrefs in html
         { pattern = 'src="(.-)"' }, -- HTML img src attribute
        }
       }
   },
 },
  { 
    "slugbyte/lackluster.nvim"
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require'colorizer'.setup({
        '*'; -- Highlight all files, but customize some others below
        css = { rgb_fn = true; };
        html = { names = true; };
      })
    end,
    event = "BufReadPost" -- optional lazy-loading
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },   -- optional, but fine to keep
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lsp = require("lspconfig")

      -- capabilities: safe even if cmp-nvim-lsp is missing
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = ok_cmp and cmp_lsp.default_capabilities()
        or vim.lsp.protocol.make_client_capabilities()

      -- (optional) ask mason-lspconfig to ensure tools exist
      pcall(function()
        require("mason-lspconfig").setup({
          ensure_installed = { "html", "cssls", "emmet_ls" },
          automatic_installation = true,
        })
      end)

      -- Direct setups (no handlers)
      lsp.html.setup({ capabilities = capabilities })
      lsp.cssls.setup({
        capabilities = capabilities,
        settings = {
          css  = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })
      lsp.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "html","css","scss","javascriptreact","typescriptreact",
          "vue","svelte","astro","php","twig","pug",
        },
      })
    end,
  },


  -------------------------------------------------------------------------
  -- Completion
  -------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col == 0 then return false end
        local char = vim.api.nvim_buf_get_text(0, line-1, col-1, line-1, col, {})[1]
        return not char:match("%s")
      end

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Esc>"]     = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            elseif has_words_before() then cmp.complete()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources(
          { { name = "nvim_lsp" }, { name = "luasnip" } },
          { { name = "path" }, { name = "buffer" } }
        ),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -------------------------------------------------------------------------
  -- Autobrackets + auto-tag
  -------------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "html", "css", "javascript", "tsx", "lua" },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascriptreact", "typescriptreact", "svelte", "vue" },
    config = function() require("nvim-ts-autotag").setup() end,
  },
}

