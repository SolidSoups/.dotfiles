require("config.options")
require("config.lazy")
require("config.colorscheme")
require("config.keymaps")
require("config.autocmd")

require("oil").setup()

local pipepath = "/tmp/godot.pipe"
if not vim.loop.fs_stat(pipepath) then
	vim.fn.serverstart(pipepath)
end
