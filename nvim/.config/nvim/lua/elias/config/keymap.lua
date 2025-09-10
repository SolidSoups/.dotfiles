local keymap = vim.keymap

vim.g.mapleader = " "

-- config editing
keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Source file' })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down"})
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up"})

-- Esc for Ctrl-C
vim.keymap.set("i", "<C-c>", "<Esc>")

-- options TODO: I DONT LIKE THIS
local opts = { noremap = true, silent = true }
local opts_desc = function(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

-- Pane and Window Navigation
keymap.set("n", "<C-h>", [[<Cmd>wincmd h<CR>]], opts) -- Navigation Left
keymap.set("n", "<C-j>", [[<Cmd>wincmd j<CR>]], opts) -- Navigation Down
keymap.set("n", "<C-k>", [[<Cmd>wincmd k<CR>]], opts) -- Navigation Up
keymap.set("n", "<C-l>", [[<Cmd>wincmd l<CR>]], opts) -- Navigation Right

-- Quick fix
keymap.set("n", "qn", "<CMD>cnext<CR>", { silent = true, desc = "Quick fix next item"})
keymap.set("n", "qp", "<CMD>cprev<CR>", { silent = true, desc = "Quick fix prev item"})

-- tabs
keymap.set("n", "å", ":tabnext<CR>", { silent = true, desc = "Tab next" })
keymap.set("n", "Å", ":tabprevious<CR>", { silent = true, desc = "Tab prev" })

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR><C-w>l", { silent = true, desc = "Split Vertically"})
keymap.set("n", "<leader>sh", ":split<CR><C-w>j", { silent = true, desc = "Split Horizontally"})

-- Window size management
keymap.set("n", "<A-.>", ":vertical resize +5<CR>", { desc = "Resize left +5"})
keymap.set("n", "<A-+>", ":res +5<CR>", { desc = "Resize up +5"})
keymap.set("n", "<A-,>", ":vertical resize -5<CR>", { desc = "Resize right -5"})
keymap.set("n", "<A-->", ":res -5<CR>", { desc = "Resize down -5"})

-- chmod
keymap.set("n", "<leader>cx", ":!chmod +x %<CR>", { desc = "make file executable" })
