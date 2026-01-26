-- Configure pyenv for Mason before anything else loads
local pyenv_root = vim.fn.expand('~/.pyenv')
if vim.fn.isdirectory(pyenv_root) == 1 then
    vim.env.PYENV_ROOT = pyenv_root
    vim.env.PATH = pyenv_root .. '/shims:' .. pyenv_root .. '/bin:' .. vim.env.PATH
    vim.env.PYENV_VERSION = '3.13.1'
end

require("elias.config.options")
require("elias.config.keymap")
require("elias.config.autocmd")
require("elias.config.lazy")
require("elias.config.lsp")
require("elias.config.colorscheme")
require("elias.config.functions")

