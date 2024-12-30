vim.g.mapleader = " "
local keymap = vim.keymap

-- defaults
keymap.set("n", "<leader>pv", "<cmd>Neotree toggle<CR>")
keymap.set("n", "<leader><leader>dd", function()
	print("Today is", os.date("%Y-%m-%d"))
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up"})

-- lsp 
keymap.set("n", "grn", vim.lsp.buf.rename)
keymap.set("n", "gra", vim.lsp.buf.code_action)
keymap.set("n", "grr", vim.lsp.buf.references)

-- telescope
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = 'Project files' })

-- config editing
keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Source file' })

-- Esc for Ctrl-C
vim.keymap.set("i", "<C-c>", "<Esc>")

