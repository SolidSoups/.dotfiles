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

-- rebind quickfix (to free up q)
keymap.set("n", "qn", ":cnext<CR>", { silent = true, desc = "Quick fix next item"})
keymap.set("n", "qp", ":cprevious<CR>", { silent = true, desc = "Quick fix previous item"})
keymap.set("n", "qd", ":cdo s/", { silent = false, desc = "Quick fix begin replace"})
keymap.set("n", "qc", ":cclose<CR>", { silent = true, desc = "Quick fix close"})
keymap.set("n", "qx", ":cdelete<CR>", { silent = true, desc = "Quick fix remove"})
keymap.set("n", "qa", ":QFAdd<CR>", { silent = true, desc = "Quick fix add"})

-- Pane and Window Navigation
keymap.set("n", "<C-h>", [[<Cmd>wincmd h<CR>]], opts) -- Navigation Left
keymap.set("n", "<C-j>", [[<Cmd>wincmd j<CR>]], opts) -- Navigation Down
keymap.set("n", "<C-k>", [[<Cmd>wincmd k<CR>]], opts) -- Navigation Up
keymap.set("n", "<C-l>", [[<Cmd>wincmd l<CR>]], opts) -- Navigation Right

-- tabs
keymap.set("n", "<leader>tn", ":tabnext<CR>", { silent = true, desc = "Tab next" })
keymap.set("n", "<leader>tp", ":tabprevious<CR>", { silent = true, desc = "Tab previous" })
keymap.set("n", "<leader>to", ":tabnew<CR>", { silent = true, desc = "Tab open new" })
keymap.set("n", "<leader>tc", ":tabclose<CR>", { silent = true, desc = "Tab close" })
keymap.set("n", "<leader>tl", ":tablast<CR>", { silent = true, desc = "Tab last" })
keymap.set("n", "<leader>tf", ":tabfirst<CR>", { silent = true, desc = "Tab first" })

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

-- formatting (conform.nvim)
keymap.set("n", "<leader>lf", function()
  require("conform").format({ timeout_ms = 500, lsp_fallback = false })
end, { desc = "Format buffer" })
