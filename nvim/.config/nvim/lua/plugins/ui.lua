return {
  {
    'lmantw/themify.nvim',
      
    lazy = false,
    priority = 999,

    config = {
      'folke/tokyonight.nvim',
      'catppuccin/nvim',
      'olivercederborg/poimandres.nvim',
    }
  },
  {
    'romgrk/barbar.nvim',
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      icons = {
        filetype = {
          enabled = false,
        }
      }
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'swaits/zellij-nav.nvim',
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab"  } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
      { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
    },
    opts = {},
  }
}
