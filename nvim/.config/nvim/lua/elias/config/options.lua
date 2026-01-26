local opt = vim.opt

opt.nu = true
opt.relativenumber = true
opt.cursorline = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.cindent = true

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

-- Custom tabline to show just filenames
function _G.custom_tabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local filename = vim.fn.fnamemodify(bufname, ':t')

    if filename == '' then
      filename = '[No Name]'
    end

    -- Highlight
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    -- Tab number and filename
    s = s .. ' ' .. i .. ': ' .. filename .. ' '
    s = s .. '%#TabLineFill#'
  end

  return s
end

vim.o.tabline = '%!v:lua.custom_tabline()'
