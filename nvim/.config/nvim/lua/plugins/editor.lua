return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
	{
	  "max397574/better-escape.nvim",
	  config = function()
	    require("better_escape").setup()
	  end,
	},
	{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      -- Default mappings: s = leap forward, S = leap backward (normal, visual, operator-pending)
      -- gs = remote action (leap then operate from distance)
      vim.keymap.set({ "n", "x", "o" }, "s",  function() require("leap").leap() end,              { desc = "Leap forward" })
      vim.keymap.set({ "n", "x", "o" }, "S",  function() require("leap").leap({ backward = true }) end, { desc = "Leap backward" })
      vim.keymap.set({ "n", "x", "o" }, "gs", function() require("leap.remote").action() end,     { desc = "Leap remote action" })
    end,
  },
}
