set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:python_host_prog = '/home/carlosap256/Development/Python/venv/venv_3.12/bin/python3.12'
let g:python3_host_prog = '/home/carlosap256/Development/Python/venv/venv_3.12/bin/python3.12'

let g:ruby_host_prog = '/home/carlosap256/.rbenv/versions/3.1.2/bin/ruby'


set encoding=UTF-8    " For the dev icons


call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'   " Status bar
Plug 'https://github.com/preservim/nerdtree'  " File tree
Plug 'https://github.com/ryanoasis/vim-devicons'  
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/preservim/tagbar'   " Tagbar for code navigation  (requires  apt install exuberant-ctags ) 


Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

call plug#end()

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>

:colorscheme jellybeans

