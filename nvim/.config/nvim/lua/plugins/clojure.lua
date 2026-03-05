return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "clojure" })
    end,
  },
  {
    "Olical/conjure",
    ft = { "clojure", "clojurescript", "edn" },
    init = function()
      -- Show eval results inline as virtual text rather than the floating HUD
      vim.g["conjure#log#hud#enabled"] = false

      -- Disable auto-REPL (babashka fallback) — connect manually instead
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = nil

      -- Don't auto-(require) the current ns on connect
      vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false

      -- Test runner: "clojure" | "clojurescript" | "kaocha"
      vim.g["conjure#client#clojure#nrepl#test#runner"] = "clojure"
    end,
  },
  {
    "gpanders/nvim-parinfer",
    ft = { "clojure", "clojurescript", "edn" },
    config = function()
      vim.g.parinfer_force_balance = true
      vim.g.parinfer_comment_chars = ";;"
      vim.g.parinfer_mode = "smart"
    end,
  },
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "clojurescript", "edn" },
    config = function()
      require("nvim-paredit").setup({
      })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        clojure = { ";; %s", "; %s" },
      },
    },
  },
}
