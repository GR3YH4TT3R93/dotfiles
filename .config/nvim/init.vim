call plug#begin()

   Plug 'one-dark/onedark.nvim'
   Plug 'sheerun/vim-polyglot'
   Plug 'preservim/nerdtree'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'frazrepo/vim-rainbow'
   Plug 'itchyny/lightline.vim'
   Plug 'nvimdev/dashboard-nvim'
   Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
   Plug 'nvim-tree/nvim-web-devicons'
   Plug 'nvim-lua/plenary.nvim'
   Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
   Plug 'nvim-telescope/telescope-file-browser.nvim'
   " LSP Support
   Plug 'neovim/nvim-lspconfig'             " Required
   Plug 'williamboman/mason.nvim',          " Optional
   Plug 'williamboman/mason-lspconfig.nvim' " Optional
   
   " Autocompletion
   Plug 'hrsh7th/nvim-cmp'     " Required
   Plug 'hrsh7th/cmp-nvim-lsp' " Required 
   Plug 'L3MON4D3/LuaSnip'     " Required
   
   Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
call plug#end()

  set number
  set nocompatible
  colorscheme onedark
  nnoremap <C-n> :NERDTree<CR>
  vnoremap <C-x> :!termux-clipboard-set<CR>
  vnoremap <C-c> :w !termux-clipboard-set<CR><CR>
  inoremap <C-v> <ESC>:read !termux-clipboard-get<CR>
  inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<CR>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<CR>'
  " Control-W Save
  nnoremap <C-W> :w<CR>
  vnoremap <C-W> <esc>:w<CR>
  "imap <C-W> <esc>:w<CR>
  " Save + back into insert 
  inoremap <C-W> <esc>:w<CR>a
  
  " Control-Q exit
  nnoremap <C-Q> :q!<CR>
  vnoremap <C-Q> <esc>:q!<CR>
  inoremap <C-Q> <esc>:q!<CR>

  " force exit
  
  nnoremap <C-X> :wq<CR>
  vnoremap <C-X> <esc>:wq<CR>


lua <<EOF
  local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
EOF


