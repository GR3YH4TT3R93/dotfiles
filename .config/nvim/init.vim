"Plugins {{{
call plug#begin()
  Plug 'navarasu/onedark.nvim'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'honza/vim-snippets'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'yamatsum/nvim-cursorline'
  Plug 'windwp/nvim-autopairs'
  Plug 'chentoast/marks.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'HiPhish/rainbow-delimiters.nvim'
  Plug 'farmergreg/vim-lastplace'
  Plug 'ThePrimeagen/vim-be-good'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-repeat'
  Plug 'fedepujol/move.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'rcarriga/nvim-notify'
  Plug 'romgrk/barbar.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'kdheepak/lazygit.nvim'
  Plug 'fannheyward/telescope-coc.nvim'
call plug#end()
"}}}

" Run PlugInstall if there are missing plugins {{{
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif
"}}}

" Theme {{{
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=250
set signcolumn=yes
set number relativenumber
set cursorline
set scrolloff=999
set foldmethod=marker
set nocompatible
set wrap linebreak
set breakindent breakindentopt=shift:2
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set clipboard+=unnamedplus

colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:indent_blankline_use_treesitter = v:true
let g:strip_whitespace_on_save = 1
let g:better_whitespace_skip_empty_lines=1
let g:strip_whitespace_confirm=1
let g:strip_only_modified_lines=1
let g:strip_whitelines_at_eof=1
let g:show_spaces_that_precede_tabs=1
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#show_coc_status = 1
let airline#extensions#coc#stl_format_err = '%C(L%L)'
let airline#extensions#coc#stl_format_warn = '%C(L%L)'

" autocmd VimLeave * wshada!
command! UP PlugUpdate | CocUpdate
"}}}

" Providers {{{
let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
let g:loaded_perl_provider = 0
"}}}

" Toggle NeoTree {{{
nnoremap <silent><C-n> :Neotree toggle<CR>
"}}}

" CoC Extensions {{{
let g:coc_global_extensions = [
  \'@statiolake/coc-extension-auto-installer',
  \'@raidou/coc-prettier-v3',
  \'@yaegassy/coc-volar',
  \'@yaegassy/coc-volar-tools',
  \'@yaegassy/coc-vitest',
  \'@yaegassy/coc-typescript-vue-plugin',
  \'@yaegassy/coc-tailwindcss3',
  \'coc-go',
  \'coc-markdownlint',
  \'coc-highlight',
  \'coc-pyright',
  \'coc-json',
  \'coc-git',
  \'coc-tsserver',
  \'coc-sh',
  \'coc-lua',
  \'coc-vimlsp',
  \'coc-typos',
  \'coc-snippets',
  \'coc-marketplace',
  \'coc-node_modules',
  \'coc-html',
  \'coc-html-css-support',
  \'coc-eslint',
  \'coc-emmet',
  \'coc-word',
  \'coc-scssmodules'
\]
"}}}

"CoC Volar {{{

"Set File Types {{{
au FileType vue let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'vite.config.js', 'vue.config.js', 'nuxt.config.ts']
"}}}

"Fix Completions {{{
autocmd Filetype vue setlocal iskeyword+=-
"}}}

vnoremap <f10> :CocCommand volar.action.nuxt<CR>
nnoremap <f10> :CocCommand volar.action.nuxt<CR>
inoremap <f10> :CocCommand volar.action.nuxt<CR>
"}}}

" CoC Tailwind CSS {{{
au FileType vue,html,js let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']
"}}}

" CoC Tab Completions {{{

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

" CoC Multi-Line Cursor{{{
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
"}}}

"Use :C to open CoC Config {{{
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
"}}}

" Use `[g` and `]g` to navigate diagnostics{{{
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"}}}

" GoTo code navigation{{{
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"}}}

" Use K to show documentation in preview window{{{
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
"}}}

" Highlight the symbol and its references when holding the cursor{{{
autocmd CursorHold * silent call CocActionAsync('highlight')
"}}}

" Symbol renaming{{{
nmap <leader>rn <Plug>(coc-rename)
"}}}

" Formatting selected code{{{
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
"}}}

" Apply code actions to the selected code block{{{
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"}}}

" Remap keys for applying code actions at the cursor position{{{
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)"}}}

" Remap keys for applying refactor code actions{{{
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
"}}}

" Run the Code Lens action on the current line{{{
nmap <leader>cl  <Plug>(coc-codelens-action)
"}}}

" Map function and class text objects{{{
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"}}}

" Remap <C-f> and <C-b> to scroll float windows/popups{{{
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
"}}}

" Use CTRL-S for selections ranges{{{
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
"}}}

" Add `:Format` command to format current buffer{{{
command! -nargs=0 Format :call CocActionAsync('format')
"}}}

" Add `:Fold` command to fold current buffer{{{
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"}}}

" Add `:OR` command for organize imports of the current buffer{{{
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"}}}

" Mappings for CoCList {{{
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"}}}

" CoC Notify Integration {{{
function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
   if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif

  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

function! s:StatusNotify() abort
  let l:status = get(g:, 'coc_status', '')
  let l:level = 'info'
  if empty(l:status) | return '' | endif
  call v:lua.coc_status_notify(l:status, l:level)
endfunction

function! s:InitCoc() abort
  " execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
endfunction

" notifications
autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
autocmd User CocStatusChange call s:StatusNotify()"}}}

" setup mapping to call :LazyGit {{{
nnoremap <silent> <leader>gg :LazyGit<CR>
"}}}

" Write, Quit, eXit {{{
" Control-W Save
nnoremap <silent><C-W> :w<CR>
vnoremap <silent><C-W> <esc> :w<CR>
"imap <C-W> <esc>:w<CR>
" Save + back into insert
" inoremap <M-W> <esc> :w<CR>a

" Control-Q Quit without save
nnoremap <silent><C-Q> :q!<CR>
vnoremap <silent><C-Q> <esc> :q!<CR>
inoremap <silent><C-Q> <esc> :q!<CR>

" Control-X Exit
nnoremap <silent><C-X> :x<CR>
vnoremap <silent><C-X> <esc> :x<CR>
inoremap <silent><C-X> <esc> :x<CR>
"}}}

" Move Lines and Blocks {{{

" Normal-mode commands
nnoremap <silent> <A-j> :MoveLine(1)<CR>
nnoremap <silent> <A-k> :MoveLine(-1)<CR>
nnoremap <silent> <A-l> :MoveHChar(1)<CR>
nnoremap <silent> <A-h> :MoveHChar(-1)<CR>
nnoremap <silent> <leader>wf :MoveWord(1)<CR>
nnoremap <silent> <leader>wb :MoveWord(-1)<CR>

" Visual-mode commands
vnoremap <silent> <A-j> :MoveBlock(1)<CR>
vnoremap <silent> <A-k> :MoveBlock(-1)<CR>
vnoremap <silent> <A-l> :MoveHBlock(1)<CR>
vnoremap <silent> <A-h> :MoveHBlock(-1)<CR>
"}}}

" Navigate to the previous or next trailing whitespace {{{
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>
"}}}

" Nvim Space Folding {{{
  nnoremap <nowait><silent>  <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
  vnoremap <nowait><silent> <Space> zf
"}}}

" Telescope Keymaps {{{
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fr <cmd>Telescope lazygit<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fc <cmd>Telescope coc<CR>
nnoremap <leader>fa <cmd>Telescope coc code_actions<CR>
nnoremap <leader>fl <cmd>Telescope coc line_code_actions<CR>
nnoremap <leader>fd <cmd>Telescope coc definitions<CR>

" Track any buffer that is in a git repo
autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()
"}}}

" BarBar Keymaps {{{

" Move to previous/next
nnoremap <silent>    <C-l> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-h> <Cmd>BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <C-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <C->> <Cmd>BufferMoveNext<CR>

" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>

" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Restore buffer
nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>

" Wipeout buffer
"  :BufferWipeout
" Close commands
"  :BufferCloseAllButCurrent
"  :BufferCloseAllButVisible
"  :BufferCloseAllButPinned
"  :BufferCloseAllButCurrentOrPinned
"  :BufferCloseBuffersLeft
"  :BufferCloseBuffersRight

" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
nnoremap <silent> <C-p>    <Cmd>BufferPickDelete<CR>

" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used
"}}}

"use Prettier to format document {{{
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
"}}}

"Lua Configs {{{
lua <<EOF

-- TreeSitter {{{

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "diff",  "query", "vue", "typescript", "html", "css", "java", "javascript", "json", "jsonc", "git_config", "gitcommit", "gitignore", "bash", "python", "go", "rust" },

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
    disable = {},
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
    additional_vim_regex_highlighting = true,
  },
}
--}}}

-- Rainbow Delimiters {{{
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterGreen',
    'RainbowDelimiterCyan',
    'RainbowDelimiterBlue',
    'RainbowDelimiterViolet',
    'RainbowDelimiterPurple',
  },
}
--}}}

-- Web DevIcons {{{
require'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  };
  --globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true;
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = true;
  -- same as `override` but specifically for overrides by filename
  -- takes effect when `strict` is true
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    }
  };
  -- same as `override` but specifically for overrides by extension
  -- takes effect when `strict` is true
  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    }
  };
}
--}}}

-- Rainbow Blank Line {{{
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { indent = { highlight = highlight } }

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
--"}}}

-- Cursor Line {{{
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 225,
    number = false,
  },
  cursorword = {
    enable = false,
    min_length = 3,
    hl = { underline = true },
  }
}
--}}}

-- Autopairs {{{
require("nvim-autopairs").setup {}
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
npairs.setup({
  map_cr=false,
  check_ts = true,
  ts_config = {
    lua = {'string'},-- it will not add a pair on that treesitter node
    javascript = {'template_string'},
    java = false,-- don't check treesitter on java
  }
})
local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
  :with_pair(ts_conds.is_not_ts_node({'function'}))
})
-- skip it, if you use another global object
_G.MUtils= {}

-- new version for custom pum
MUtils.completion_confirm=function()
  if vim.fn["coc#pum#visible"]() ~= 0  then
    return vim.fn["coc#pum#confirm"]()
  else
    return npairs.autopairs_cr()
  end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

-- change default fast_wrap
npairs.setup({
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = '$',
    before_key = 'h',
    after_key = 'l',
    cursor_pos_before = true,
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    manual_position = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
})

function rule2(a1,ins,a2,lang)
  npairs.add_rule(
    Rule(ins, ins, lang)
      :with_pair(function(opts) return a1..a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        return a1..ins..ins..a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
      end)
  )
end

rule2('(','*',')','ocaml')
rule2('(*',' ','*)','ocaml')
rule2('(',' ',')')
rule2('{','*','}')
rule2('{{',' ','}}','vue')
rule2('({',' ','})','vue')
rule2('{',' ','}')
--}}}

-- Vim Notify {{{
vim.notify = require("notify")
--}}}

-- CoC Vim Notify Extension {{{
local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 250, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 250, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end
--}}}

-- CoC Telescope Extension {{{
require("telescope").setup({
  extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  },
})
require('telescope').load_extension('coc')
--}}}

-- LazyGit Telescope Extension {{{
require('telescope').load_extension('lazygit')
--}}}

-- NeoTree {{{
require("neo-tree").setup({
close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
popup_border_style = "rounded",
enable_git_status = true,
enable_diagnostics = true,
enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
sort_case_insensitive = false, -- used when sorting files and directories in the tree
sort_function = nil , -- use a custom function for sorting files and directories in the tree
-- sort_function = function (a,b)
--       if a.type == b.type then
--   return a.path > b.path
--       else
--   return a.type > b.type
--       end
--   end , -- this sorts files and directories descendantly
default_component_configs = {
  container = {
    enable_character_fade = true
  },
  indent = {
    indent_size = 1,
    padding = 1, -- extra padding on left hand side
    -- indent guides
    with_markers = true,
    indent_marker = "│",
    last_indent_marker = "└",
    highlight = "NeoTreeIndentMarker",
    -- expander config, needed for nesting files
    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
    expander_collapsed = "",
    expander_expanded = "",
    expander_highlight = "NeoTreeExpander",
  },
  icon = {
    folder_closed = "󰉋",
    folder_open = "󰝰",
    folder_empty = "󰷏",
    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
    -- then these will never be used.
    default = "*",
    highlight = "NeoTreeFileIcon"
  },
  modified = {
    symbol = "[+]",
    highlight = "NeoTreeModified",
  },
  name = {
    trailing_slash = false,
    use_git_status_colors = true,
    highlight = "NeoTreeFileName",
  },
  git_status = {
    symbols = {
      -- Change type
      added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
      modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
      deleted   = "✖",-- this can only be used in the git_status source
      renamed   = "󰁕",-- this can only be used in the git_status source
      -- Status type
      untracked = "󱪘",
      ignored   = "",
      unstaged  = "󱪗",
      staged    = "󱪝",
      conflict  = "󱪟",
    }
  },
  -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
  file_size = {
    enabled = true,
    required_width = 64, -- min width of window required to show this column
  },
  type = {
    enabled = true,
    required_width = 122, -- min width of window required to show this column
  },
  last_modified = {
    enabled = true,
    required_width = 80, -- min width of window required to show this column
  },
  created = {
    enabled = true,
    required_width = 110, -- min width of window required to show this column
  },
  symlink_target = {
    enabled = false,
  },
},
-- A list of functions, each representing a global custom command
-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
-- see `:h neo-tree-custom-commands-global`
commands = {},
window = {
  position = "left",
  width = "35%",
  mapping_options = {
    noremap = true,
    nowait = false,
  },
  mappings = {
    ["<leader>"] = {
      "toggle_node",
      nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
    },
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
    ["P"] = { "toggle_preview", config = { use_float = true } },
    ["l"] = "focus_preview",
    ["S"] = "open_split",
    ["s"] = "open_vsplit",
    -- ["S"] = "split_with_window_picker",
    -- ["s"] = "vsplit_with_window_picker",
    ["t"] = "open_tabnew",
    -- ["<cr>"] = "open_drop",
    -- ["t"] = "open_tab_drop",
    ["w"] = "open_with_window_picker",
    --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
    ["C"] = "close_node",
    -- ['C'] = 'close_all_subnodes',
    ["z"] = "close_all_nodes",
    --["Z"] = "expand_all_nodes",
    ["a"] = {
      "add",
      -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
      -- some commands may take optional config options, see `:h neo-tree-mappings` for details
      config = {
        show_path = "none" -- "none", "relative", "absolute"
      }
    },
    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
    ["d"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
    -- ["c"] = {
    --  "copy",
    --  config = {
    --    show_path = "none" -- "none", "relative", "absolute"
    --  }
    --}
    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
    ["q"] = "close_window",
    ["R"] = "refresh",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
    --["i"] = "show_file_details",
  }
},
nesting_rules = {},
filesystem = {
  filtered_items = {
    visible = false, -- when true, they will just be displayed differently than normal items
    hide_dotfiles = true,
    show_hidden_count = false,
    hide_gitignored = true,
    hide_hidden = true, -- only works on Windows for hidden files/directories
    hide_by_name = {
      --"node_modules"
    },
    hide_by_pattern = { -- uses glob style patterns
      --"*.meta",
      --"*/src/*/tsconfig.json",
    },
    always_show = { -- remains visible even if other settings would normally hide it
      --".gitignored",
    },
    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
      --".DS_Store",
      --"thumbs.db"
    },
    never_show_by_pattern = { -- uses glob style patterns
      --".null-ls_*",
    },
  },
  follow_current_file = {
    enabled = true, -- This will find and focus the file in the active buffer every time
    --       -- the current file is changed while the tree is open.
    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
  },
  group_empty_dirs = false, -- when true, empty folders will be grouped together
  hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
  -- in whatever position is specified in window.position
-- "open_current",  -- netrw disabled, opening a directory opens within the
  -- window like netrw would, regardless of window.position
-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
  use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
  -- instead of relying on nvim autocmd events.
  window = {
    mappings = {
      ["<bs>"] = "navigate_up",
      ["."] = "set_root",
      ["H"] = "toggle_hidden",
      ["/"] = "fuzzy_finder",
      ["D"] = "fuzzy_finder_directory",
      ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
      -- ["D"] = "fuzzy_sorter_directory",
      ["f"] = "filter_on_submit",
      ["<c-x>"] = "clear_filter",
      ["[g"] = "prev_git_modified",
      ["]g"] = "next_git_modified",
      ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
      --["oc"] = { "order_by_created", nowait = false },
      --["od"] = { "order_by_diagnostics", nowait = false },
      --["og"] = { "order_by_git_status", nowait = false },
      --["om"] = { "order_by_modified", nowait = false },
      --["on"] = { "order_by_name", nowait = false },
      --["os"] = { "order_by_size", nowait = false },
      --["ot"] = { "order_by_type", nowait = false },
    },
    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
      ["<down>"] = "move_cursor_down",
      ["<C-n>"] = "move_cursor_down",
      ["<up>"] = "move_cursor_up",
      ["<C-p>"] = "move_cursor_up",
    },
  },

  commands = {} -- Add a custom command or override a global one using the same function name
},
buffers = {
  follow_current_file = {
    enabled = true, -- This will find and focus the file in the active buffer every time
    --      -- the current file is changed while the tree is open.
    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
  },
  group_empty_dirs = true, -- when true, empty folders will be grouped together
  show_unloaded = true,
  window = {
    mappings = {
      ["bd"] = "buffer_delete",
      ["<bs>"] = "navigate_up",
      ["."] = "set_root",
      ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
      ["oc"] = { "order_by_created", nowait = false },
      ["od"] = { "order_by_diagnostics", nowait = false },
      ["om"] = { "order_by_modified", nowait = false },
      ["on"] = { "order_by_name", nowait = false },
      ["os"] = { "order_by_size", nowait = false },
      ["ot"] = { "order_by_type", nowait = false },
    }
  },
},
git_status = {
  window = {
    position = "float",
    mappings = {
      ["A"]  = "git_add_all",
      ["gu"] = "git_unstage_file",
      ["ga"] = "git_add_file",
      ["gr"] = "git_revert_file",
      ["gc"] = "git_commit",
      ["gp"] = "git_push",
      ["gg"] = "git_commit_and_push",
      ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
      ["oc"] = { "order_by_created", nowait = false },
      --["od"] = { "order_by_diagnostics", nowait = false },
      ["om"] = { "order_by_modified", nowait = false },
      ["on"] = { "order_by_name", nowait = false },
      ["os"] = { "order_by_size", nowait = false },
      ["ot"] = { "order_by_type", nowait = false },
    }
  }
}
})

vim.cmd([[nnoremap <silent> \ :Neotree reveal<cr>]])
--}}}

-- Marks.nvim {{{
require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = {},
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}
--}}}

EOF
"}}}
