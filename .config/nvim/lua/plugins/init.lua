local colors = require("base46").get_theme_tb "base_30"

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    cmd = "Oil",
    config = function()
      require("oil").setup()
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      require("rainbow-delimiters.setup").setup {
        query = {
          javascript = "rainbow-parens",
          typescriptreact = "rainbow-parens",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
      local colours = {
        RainbowDelimiterRed = colors.red,
        RainbowDelimiterYellow = colors.yellow,
        RainbowDelimiterBlue = colors.blue,
        RainbowDelimiterOrange = colors.orange,
        RainbowDelimiterGreen = colors.teal,
        RainbowDelimiterViolet = colors.purple,
        RainbowDelimiterCyan = colors.cyan,
      }

      for name, code in pairs(colours) do
        vim.api.nvim_set_hl(0, name, { fg = code })
      end
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
