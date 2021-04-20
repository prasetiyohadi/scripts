" my bundles
" icons for nerdtree
Plug 'ryanoasis/vim-devicons'

" dracula colorscheme
Plug 'dracula/vim'

" asynchronous completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" completion for golang
Plug 'deoplete-plugins/deoplete-go', {'do': 'make'}
