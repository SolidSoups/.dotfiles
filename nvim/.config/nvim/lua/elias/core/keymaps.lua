vim.g.mapleader = " "
local keymap = vim.keymap

-- config editing
keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Source file' })
keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'Lua Source Current Line'})
keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'Lua Source Selected Lines'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up"})



-- Esc for Ctrl-C
vim.keymap.set("i", "<C-c>", "<Esc>")

-- optiosn
local opts = { noremap = true, silent = true }
local opts_desc = function(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

-- remap ever
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank selection" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank entire line" })

-- stop lsp
-- vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<CR>")


-- Pane and Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigation Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigation Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigation Up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigation Right
keymap.set("n", "<C-h>", [[<Cmd>wincmd h<CR>]], opts) -- Navigation Left
keymap.set("n", "<C-j>", [[<Cmd>wincmd j<CR>]], opts) -- Navigation Down
keymap.set("n", "<C-k>", [[<Cmd>wincmd k<CR>]], opts) -- Navigation Up
keymap.set("n", "<C-l>", [[<Cmd>wincmd l<CR>]], opts) -- Navigation Right
keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts) -- Navigation Left
keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts) -- Navigation Down
keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts) -- Navigation Up
keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts) -- Navigation Right

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts_desc("Split Vertically")) -- Split Vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts_desc("Split Horizontally")) -- Split Horizontally
--keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts_desc("Toggle Maximizer")) -- Toggle Maximizer


