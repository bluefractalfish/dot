return {
	{
		"junegunn/goyo.vim",
		keys = {
			{ "<leader>z", ":Goyo<CR>", desc = "Toggle Goyo" },
		},
	},

	{
		"preservim/vim-pencil",
		config = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
			vim.g["pencil#textwidth"] = 80
		end,
	}, 
  -- ============================================================================
  -- colorscheme
  -- ============================================================================
  {
    "slugbyte/lackluster.nvim",
  },

  -- ============================================================================
  -- file explorer
  -- ============================================================================
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },

    keys = {
      -- open neo-tree rooted at home
      { "<leader>e", ":Neotree dir=./<CR> ", desc = "File explorer" },

   },

    config = function()
      require("neo-tree").setup({
        default_component_configs = {
          icon = {
            -- disable icons for a cleaner text-only look
            enabled = false,
          },
          git_status = {
            -- custom git markers
            symbols = {
              added = "+",
              modified = "~",
              deleted = "-",
              renamed = "cw",
              untracked = "ut",
              ignored = "ig",
              unstaged = "ns",
              staged = "s",
              conflict = "xx",
            },
          },
        },

        filesystem = {
          -- do not constantly rebind tree root to cwd
          bind_to_cwd = true,
          cwd_target = {
            sidebar = "global",
          },
          filtered_items = {
            -- show dotfiles
            hide_dotfiles = false,
          },
        },

        window = {
          mappings = {
            -- vim-like navigation inside tree
            ["l"] = "open",
            ["h"] = "close_node",
            ["<space>"] = "toggle_node",
            ["<bs>"] = "navigate_up",
            ["u"] = "navigate_up",
            ["T"] = "open_tab_nofocus",
          },
        },   
        commands = {
          open_tab_nofocus = function(state)
            local node = state.tree:get_node()
            if not node or node.type ~= "file" then
              return
            end

            local path = node:get_id()
            vim.cmd("tabnew " .. vim.fn.fnameescape(path))
            vim.schedule(function()
              vim.cmd("Neotree focus")
            end)
          end,
        },
      })
    end,
  },


  -- ============================================================================
  -- color preview for css/html colors
  -- ============================================================================
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        "*",
        css = { rgb_fn = true },
        html = { names = true },
      })
    end,
  },

  -- ============================================================================
  -- completion
  --
  -- blink.cmp replaces nvim-cmp here.
  -- this setup is intentionally minimal:
  --   - no snippet source
  --   - no super-tab preset
  --   - lsp first, then path, then buffer
  -- ============================================================================
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      -- optional but recommended by blink for nicer icon rendering
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- ------------------------------------------------------------------------
      -- keymaps
      -- ------------------------------------ ------------------------------------
      keymap = {
        -- disable blink's default preset so tab does not get special behavior
        preset = "none",

        -- manual completion
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

        -- navigation inside the completion menu
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        
        -- scroll docs
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },

        -- hide menu
        ["<Esc>"] = { "hide", "fallback" },

        -- confirm only when you explicitly choose an item
        ["<CR>"] = { "accept", "fallback" },

        -- leave tab completely alone so it behaves normally in insert mode
        ["<Tab>"] = { "fallback" },
        ["<S-Tab>"] = { "fallback" },
      },

      -- ------------------------------------------------------------------------
      -- appearance
      -- ------------------------------------------------------------------------
      appearance = {
        -- use default nerd font behavior
        nerd_font_variant = "normal",
      },

      -- ------------------------------------------------------------------------
      -- completion behavior
      -- ------------------------------------------------------------------------
      completion = {
        -- do not auto-insert a completion candidate before you choose it
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },

        -- bordered windows for a cleaner, more separated look
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },

        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind", "source_name", gap = 1 },
            },
          },
        },

        -- turn ghost text off for less visual noise
        ghost_text = {
          enabled = false,
        },
      },

      -- ------------------------------------------------------------------------
      -- sources
      -- ------------------------------------------------------------------------
      sources = {
        -- order matters: lsp suggestions first
        default = { "lsp", "path", "buffer" },

        -- explicitly avoid snippet sources
        per_filetype = {
          -- you can override per filetype later if needed
        },

        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            -- avoid too-eager buffer spam
            min_keyword_length = 3,
          },
        },
      },

      -- ------------------------------------------------------------------------
      -- fuzzy matching
      -- ------------------------------------------------------------------------
      fuzzy = {
        -- default fuzzy matching is one of blink's strengths; keep it enabled
        implementation = "prefer_rust_with_warning",
      },

      -- ------------------------------------------------------------------------
      -- snippets
      -- ------------------------------------------------------------------------
      snippets = {
        -- keep snippet support effectively inert for your workflow
        preset = "default",
      },

      -- ------------------------------------------------------------------------
      -- signature help
      -- ------------------------------------------------------------------------
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- ============================================================================
  -- lsp
  --
  -- blink.cmp provides the completion capabilities to lsp servers through
  -- get_lsp_capabilities().
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },
      "saghen/blink.cmp",
    },
    config = function()
      -- ------------------------------------------------------------------------
      -- build lsp capabilities
      -- ------------------------------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- if blink is available, enhance capabilities for completion
      local ok_blink, blink = pcall(require, "blink.cmp")
      if ok_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- ------------------------------------------------------------------------
      -- ensure lsp servers are installed
      -- ------------------------------------------------------------------------
      pcall(function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "html",
            "cssls",
            "emmet_ls",
            "pyright",
          },
          automatic_installation = true,
        })
      end)

      -- ------------------------------------------------------------------------
      -- html
      -- ------------------------------------------------------------------------
      vim.lsp.config("html", {
        capabilities = capabilities,
      })

      -- ------------------------------------------------------------------------
      -- css
      -- ------------------------------------------------------------------------
      vim.lsp.config("cssls", {
        capabilities = capabilities,
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })

      -- ------------------------------------------------------------------------
      -- emmet
      -- ------------------------------------------------------------------------
      vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
        filetypes = {
          "python",
          "html",
          "css",
          "scss",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
          "php",
          "twig",
          "pug",
        },
      })

      -- ------------------------------------------------------------------------
      -- python
      -- ------------------------------------------------------------------------
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      -- ------------------------------------------------------------------------
      -- enable the servers you actually want running
      -- ------------------------------------------------------------------------
      vim.lsp.enable("pyright")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      -- vim.lsp.enable("emmet_ls")
    end,
  },

  -- ============================================================================
  -- autopairs
  -- ============================================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})

    end,
  },

  -- ============================================================================
  -- treesitter
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "python",
        "html",
        "css",
        "javascript",
        "tsx",
        "lua",
      },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },

  -- ============================================================================
  -- autotag
  -- ============================================================================
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "python",
      "html",
      "xml",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}

