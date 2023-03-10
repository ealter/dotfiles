-- A lot of this lua structure is inspired by https://git.corp.stripe.com/jbrown/dotfiles/tree/main/nvim

vim.o.cmdheight = 2 -- avoid 'Press Enter to continue'
vim.o.incsearch = true
vim.o.number = true -- show line numbers
vim.o.showmatch = true -- show matching brackets
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.title = true -- show title in console bar
vim.o.wildignore='*.o,*.ui,*.uo,*.exe,.git,*.pdf,*.hi,*.pyc,*/build/*,*/htdocs/*'
vim.o.wildmode = 'longest,list,full'

-- Setup persistent undo
vim.opt.undodir = os.getenv( "HOME" ) .. '/.nvim/undodir'
vim.opt.undofile = true

-- Setup backups
vim.opt.backup = true
vim.opt.backupdir = os.getenv( "HOME" ) .. '/.nvim/backups'

 -- go to last loc when opening a buffer
vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function() vim.o.paste = false end,
})

vim.api.nvim_command('filetype plugin on')
vim.api.nvim_command('filetype indent plugin on')

vim.o.completeopt = 'menuone,longest,preview'
-- set complete-=i


-- Spaces are better than tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.g.mapleader = ','
-- remap kj to escape insert mode (since you'll probably never type this)
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {noremap = true})

-- Swap ; and : Convinient
vim.api.nvim_set_keymap('n', ';', ':', {noremap = true})
vim.api.nvim_set_keymap('n', ':', ';', {noremap = true})

-- quick insertion of a newline by pressing enter
vim.api.nvim_set_keymap('n', '<CR>', ":put=repeat([''],v:count)<CR>", {noremap = true, silent=true})

-- shortcuts for copying to the clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>Y', '"+yy', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>Y', '"+yy', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true})

-- visual shifting (does not exit Visual mode)
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})

-- Shortcut to turn off highlighting with
vim.api.nvim_set_keymap('n', '<leader><Space>', ':silent noh<CR>', {noremap = true, silent = true})

-- shortcut to toggle spelling
vim.api.nvim_set_keymap('n', '<leader>s', ':setlocal spell! spelllang=en_us<CR>', {noremap = true})

-- Makes splits easier (since s is pretty useless anyway)
vim.api.nvim_set_keymap('n', 's', '<C-W>', {noremap = true})

-- cd to the current directory and then print where you are
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>r', ':ArgWrap<CR>', {noremap = true})

-- Replace the current word with the first spelling suggestion
vim.api.nvim_set_keymap('n', 'z-', 'z=1<CR><CR>', {noremap = true})

-- Use 'g' flag by default with :s/foo/bar
vim.o.gdefault = true

require('plug_init')
require('plugins')
-- require('lsp')
