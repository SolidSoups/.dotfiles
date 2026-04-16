vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")

require("config.options")
require("config.lazy")
require("config.colorscheme")
require("config.keymaps")
require("config.autocmd")
