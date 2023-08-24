"Plugins
call plug#begin()

   Plug 'one-dark/onedark.nvim'
   Plug 'sheerun/vim-polyglot'
   Plug 'preservim/nerdtree'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'frazrepo/vim-rainbow'
   Plug 'itchyny/lightline.vim'
   Plug 'nvimdev/dashboard-nvim'
   Plug 'kshenoy/vim-signature' 
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

" Save/ Load Folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

" Theme
  set encoding=UTF-8
  set number
  set nocompatible
  colorscheme onedark
  nnoremap <C-n> :NERDTree<CR>

" Cut, Copy Paste
  vnoremap <C-x> :!termux-clipboard-set<CR>
  vnoremap <C-c> :w !termux-clipboard-set<CR><CR>

  inoremap <C-v> <ESC> :read !termux-clipboard-get<CR>

" COC Tab Completions
  inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<TAB>'

"COC Vetur LSP
let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

" Providers
let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
let g:loaded_perl_provider = 0

" C-W C-Q C-X
  " Control-W Save
  nnoremap <C-W> :w<CR>
  vnoremap <C-W> <esc> :w<CR>
  "imap <C-W> <esc>:w<CR>
  " Save + back into insert 
  inoremap <C-W> <esc> :w<CR>a
  
  " Control-Q exit
  nnoremap <C-Q> :q!<CR>
  vnoremap <C-Q> <esc> :q!<CR>
  inoremap <C-Q> <esc> :q!<CR>

  " force exit
  nnoremap <C-X> :wq<CR>
  vnoremap <C-X> <esc> :wq<CR>

" Nvim Space Folding
  nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
  vnoremap <Space> zf

  " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Lua Configs
lua <<EOF
--LSP Zero Config

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

-- TreeSitter Config

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "vue", "typescript", "html", "css", "java", "javascript", "json", "git_config", },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
