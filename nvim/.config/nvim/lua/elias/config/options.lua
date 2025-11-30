local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.cursorline = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"

opt.updatetime = 50

-- Better split separators
opt.fillchars = { horiz = '─', horizup = '┴', horizdown = '┬', vert = '│', vertright = '├', vertleft = '┤', verthoriz = '┼' }
