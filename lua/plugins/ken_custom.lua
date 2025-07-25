return {
  { "tpope/vim-surround", lazy = false },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,
  -- },
  {
    "klen/nvim-test",
    event = "VeryLazy",
    config = function()
      require("nvim-test").setup {
        run = true, -- run tests (using for debug)
        commands_create = true, -- create commands (TestFile, TestLast, ...)
        filename_modifier = ":p:.", -- modify filenames before tests run(:h filename-modifiers)
        silent = false, -- less notifications
        term = "terminal", -- a terminal to run ("terminal"|"toggleterm")
        termOpts = {
          direction = "vertical", -- terminal's direction ("horizontal"|"vertical"|"float")
          width = 128, -- terminal's width (for vertical|float)
          height = 24, -- terminal's height (for horizontal|float)
          go_back = false, -- return focus to original window after executing
          stopinsert = "auto", -- exit from insert mode (true|false|"auto")
          keep_one = true, -- keep only one terminal for testing
        },
        runners = {
          -- setup tests runners
          cs = "nvim-test.runners.dotnet",
          go = "nvim-test.runners.go-test",
          haskell = "nvim-test.runners.hspec",
          javascriptreact = "nvim-test.runners.jest",
          javascript = "nvim-test.runners.jest",
          lua = "nvim-test.runners.busted",
          python = "nvim-test.runners.pytest",
          ruby = "nvim-test.runners.rspec",
          rust = "nvim-test.runners.cargo-test",
          typescript = "nvim-test.runners.jest",
          typescriptreact = "nvim-test.runners.jest",
        },
      }
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<C-[>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<C-;>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<C-p>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<C-]>", require("smart-splits").resize_right)
    end,
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function() require("chatgpt").setup() end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      shell = "/usr/bin/fish",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = {
          position = "right", -- | top | left | right | horizontal | vertical
          ratio = 0.4
        },
      },
      suggestion = {
        keymap = {
          accept = false, -- handled by completion engine
        },
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              -- set the ai_accept function
              ai_accept = function()
                if require("copilot.suggestion").is_visible() then
                  require("copilot.suggestion").accept()
                  return true
                end
              end,
            },
          },
        },
      },
    },
  },
  {
    "Saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      if not opts.keymap then
        opts.keymap = {}
      end
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function()
          if vim.g.ai_accept then
            return vim.g.ai_accept()
          end
        end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
