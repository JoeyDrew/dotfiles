local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- -----------------------------------------------------------------
-- Helper: open Oil in a floating window at the current working dir
-- -----------------------------------------------------------------
local function oil_float_cwd()
  -- Grab the cwd once – no side‑effects
  local cwd = vim.fn.getcwd()

  -- Build the command string; `vim.cmd` executes an Ex command
  vim.cmd('Oil --float ' .. vim.fn.fnameescape(cwd))
end

-- Normal‑mode: <leader>w → :w<CR>
vim.keymap.set(
  "n",                     -- mode: normal
  "<leader>w",             -- lhs
  ":w<CR>",                -- rhs (write the file)
  { noremap = true, silent = true, desc = "Save file" }
)

vim.keymap.set(
  "n",                     -- mode: normal
  "<leader>q",             -- lhs
  ":q<CR>",                -- rhs (close the file)
  { noremap = true, silent = true, desc = "Close buffer" }
)

vim.keymap.set(
  "n",                     -- mode: normal
  "<leader>o",    
  oil_float_cwd,               
  { noremap = true, silent = true, desc = "Oil float" }
)

vim.keymap.set('n', '<leader>e',
  function()
    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
    vim.cmd('Oil --float ' .. vim.fn.fnameescape(dir))
  end,
  { noremap = true, silent = true, desc = 'Open Oil (float) at buffer dir' }
)

-- Zellij mappings 
-- vim.keymap.set('n', '<leader>zf',
--   function()
--     local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p:h')
--     vim.fn.system('zellij action new-pane --floating ' .. vim.fn.fnameescape(dir))
--   end,
--   { noremap = true, silent = true, desc = 'Open floating zellij pane (cwd)' }
-- )

-- Barbar / Tab mappings
map('n', '<leader>bc', '<Cmd>BufferClose<CR>', opts)

-- Magic buffer-picking mode
map('n', '<leader>bb',   '<Cmd>BufferPick<CR>', opts)
map('n', '<leader>bx', '<Cmd>BufferPickDelete<CR>', opts)

-- Sort automatically by...
map('n', '<leader>bv', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
