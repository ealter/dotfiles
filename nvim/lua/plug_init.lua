local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'lewis6991/impatient.nvim' -- speed up startup time
  use 'wbthomason/packer.nvim'

  use 'FooSoft/vim-argwrap'  -- Format functions between multiline and single line
  use 'airblade/vim-gitgutter'  -- Adds + and - to the gutter depending on which lines have been changed in git
  use 'airblade/vim-rooter'  -- Change directory to the project root
  use 'altercation/vim-colors-solarized'  -- Color scheme
  use 'michaeljsmith/vim-indent-object'  -- Add a text object based on the indent level (ai, ii, aI)
  use 'tpope/vim-commentary'  -- gc to comment or uncomment a block of code
  use 'tpope/vim-fugitive'  -- Git integration
  use 'tpope/vim-rhubarb'  -- Github integration
  use 'tpope/vim-surround'  -- Makes it easy to edit html tags and surround text with tags
  use 'tpope/vim-vinegar'  -- Better netrw file browsing
  use 'vim-scripts/matchit.zip'  -- Match complex things with '%'

  -- Fuzzy finder
  use 'ibhagwan/fzf-lua'
  -- use 'vijaymarupudi/nvim-fzf'

  -- autocomplete
  -- use {'neoclide/coc.nvim', branch = 'release'}
  -- use 'w0rp/ale'
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {'jose-elias-alvarez/null-ls.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use 'ray-x/lsp_signature.nvim'
  use {
    'hrsh7th/nvim-cmp', -- Autocompletion
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-calc'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'},
      {'hrsh7th/cmp-omni'},
    }
  }

  -- Language specific
  use 'fatih/vim-go'
  use 'rodjek/vim-puppet' -- Puppet syntax and formatting
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'hashivim/vim-terraform'  -- Terraform syntax
  use 'jelera/vim-javascript-syntax'  -- Moar js syntax highlighting
  use 'leafgarland/typescript-vim' -- Typescript syntax highlighting
  use 'maxmellon/vim-jsx-pretty' -- Format jsx

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
