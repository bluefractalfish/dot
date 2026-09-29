 
local opt = vim.opt
local g = vim.g

opt.clipboard = 'unnamedplus' -- use system keyboard for yank

 
opt.nu = true                 -- set line numbers -- set line numbers
opt.relativenumber = true     -- use relative line numbers
vim.o.cursorline = true
 
-- set tab size to 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
 
opt.wrap = false
 
opt.incsearch = true -- incremental search
 
opt.termguicolors = true

--------------------------------------------------
-- General UI
--------------------------------------------------

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.colorcolumn = "88"

--------------------------------------------------
-- Splits
--------------------------------------------------

opt.splitright = true
opt.splitbelow = true

--------------------------------------------------
-- Tabs / indentation
--------------------------------------------------

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

--------------------------------------------------
-- Search
--------------------------------------------------

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

--------------------------------------------------
-- Completion behavior
--------------------------------------------------

opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

--------------------------------------------------
-- Files / backups / undo
--------------------------------------------------

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

--------------------------------------------------
-- Performance / responsiveness
--------------------------------------------------

opt.updatetime = 200
opt.timeoutlen = 300

--------------------------------------------------
-- Clipboard
--------------------------------------------------


--------------------------------------------------
-- Whitespace / display
--------------------------------------------------

opt.list = true
opt.listchars = {
  tab = "> ",
  trail = "·",
  nbsp = "␣",
}

--------------------------------------------------
-- Better command line
--------------------------------------------------

opt.cmdheight = 1
opt.showmode = false

-- folding?
opt.foldmethod="indent"
opt.foldexpr="nvim_treesitter#foldexpr()"
opt.foldlevel=99
opt.foldlevelstart=99
opt.foldenable=true
