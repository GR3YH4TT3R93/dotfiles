"Plugins {{{
"
call plug#begin()

   Plug 'navarasu/onedark.nvim'
   Plug 'sheerun/vim-polyglot'
   Plug 'preservim/nerdtree'
   Plug 'ryanoasis/vim-devicons'
   Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'honza/vim-snippets'
   Plug 'frazrepo/vim-rainbow'
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'
   Plug 'lukas-reineke/indent-blankline.nvim'
   Plug 'yamatsum/nvim-cursorline'
   Plug 'm4xshen/autoclose.nvim'
"   Plug 'kshenoy/vim-signature' 
   Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
   Plug 'nvim-tree/nvim-web-devicons'
   " LSP Support
"   Plug 'neovim/nvim-lspconfig'             " Required
"   Plug 'williamboman/mason.nvim',          " Optional
"   Plug 'williamboman/mason-lspconfig.nvim' " Optional
   
   " Autocompletion
"   Plug 'hrsh7th/nvim-cmp'     " Required
"   Plug 'hrsh7th/cmp-nvim-lsp' " Required 
"   Plug 'L3MON4D3/LuaSnip'     " Required
   
"   Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
call plug#end()
"}}}

" Theme{{{ 
  set encoding=UTF-8
  set number relativenumber
  set cursorline
  set scrolloff=999
  set syntax=on
  set foldmethod=marker
  set nocompatible
  set listchars=tab:\|\ 
  set list
  set wrap linebreak
  set breakindent
  set breakindentopt=shift:2
  colorscheme onedark
  let g:airline_theme='onedark'
  let g:airline_powerline_fonts = 1
  let g:NERDTreeDirArrowExpandable = ''
  let g:NERDTreeDirArrowCollapsible = ''
  nnoremap <C-n> :NERDTree<CR>

"Coc Lightbulb{{{
" virtual text
hi default LightBulbDefaultVirtualText guifg=#FDD164
hi default link LightBulbQuickFixVirtualText LightBulbDefaultVirtualText
" sign
hi default LightBulbDefaultSignLine guifg=#FDD164
hi default link LightBulbQuickFixSignLine LightBulbDefaultSignLine
" for numhl, you can set LightBulbDefaultSignLine, LightBulbQuickFixSignLine}}}
  "}}}

"COC Volar{{{  
 
"Set File Types{{{ 
au FileType vue let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'vite.config.js', 'vue.config.js', 'nuxt.config.ts']"}}}

"Fix Completions{{{ 
autocmd Filetype vue setlocal iskeyword+=-
"}}}
"}}}

"Coc Tailwind CSS{{{ 
au FileType html let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']
"}}}

" Providers{{{
let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
let g:loaded_perl_provider = 0
"}}}

" Cut, Copy Paste{{{ 
  vnoremap <C-x> :!termux-clipboard-set<CR>
  vnoremap <C-c> :w !termux-clipboard-set<CR><CR>
  inoremap <C-v> <ESC> :read !termux-clipboard-get<CR>
  "}}}

" COC Tab Completions{{{  
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
"}}}

" Write, Quit, eXit{{{
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
  "}}}

" Nvim Space Folding{{{
  nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
  vnoremap <Space> zf
"}}}

" Exit Vim if NERDTree is the only window remaining in the only tab.{{{
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"}}}

"coc :Prettier command {{{
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
"}}}

"Use C to open Coc Config{{{
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
"}}}

"Lua Configs{{{
lua <<EOF

-- TreeSitter Config"{{{

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
--}}}

-- Colored Blank Line"{{{
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
--"}}}

-- Cursor Line
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}

-- Close Symbols"{{{
local config = {
   keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },

      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },

      ['"'] = { escape = true, close = true, pair = '""' },
      ["'"] = { escape = true, close = true, pair = "''" },
      ["`"] = { escape = true, close = true, pair = "``" },
   },
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      pair_spaces = false,
      auto_indent = true,
   },
}
--}}}

EOF
"}}}
