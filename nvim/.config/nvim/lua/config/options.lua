local opt = vim.opt

opt.cursorline = true         -- Enable highlighting of the current line
opt.expandtab = true          -- Use spaces instead of tabs
opt.tabstop = 2               -- Number of spaces tabs count for
opt.shiftround = true         -- Round indent
opt.shiftwidth = 2            -- Size of an indent
opt.smartcase = true          -- Don't ignore case with capitals
opt.smartindent = true        -- Insert indents automatically
opt.copyindent = true         -- copy the previous indentation on autoindenting
opt.number = true             -- Print line number
opt.relativenumber = true     -- Relative line numbers
opt.wrap = false              -- Disable line wrap
opt.clipboard = "unnamedplus" -- use system clipboard
opt.undofile = true           -- persistent undo
opt.termguicolors = true      -- enable 24-bit RGB color in the TUI
opt.timeoutlen = 500          -- shorten key timeout length a little bit for which-key
opt.title = true              -- set terminal title to the filename and path
