"Plugins  {{{
call plug#begin()
  Plug 'navarasu/onedark.nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'honza/vim-snippets'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'yamatsum/nvim-cursorline'
  Plug 'm4xshen/autoclose.nvim'
  Plug 'kshenoy/vim-signature'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'HiPhish/rainbow-delimiters.nvim'
  Plug 'farmergreg/vim-lastplace'
  Plug 'ThePrimeagen/vim-be-good'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'fedepujol/move.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'rcarriga/nvim-notify'
  Plug 'romgrk/barbar.nvim'
  Plug 'MunifTanjim/nui.nvim'
  Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
  Plug 'ntpeters/vim-better-whitespace'
call plug#end()
"}}}

" Run PlugInstall if there are missing plugins {{{
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
"}}}

" Theme {{{
set encoding=UTF-8
set number relativenumber
set cursorline
set scrolloff=999
set foldmethod=marker
set nocompatible
set list listchars=tab:\⎸\ 
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
let g:strip_whitespace_confirm=0
let g:strip_only_modified_lines=1
let g:strip_whitelines_at_eof=1
let g:show_spaces_that_precede_tabs=1
nnoremap <silent><C-n> :Neotree toggle<CR>

" autocmd VimLeave * wshada!


"Coc Lightbulb {{{
" virtual text
hi default LightBulbDefaultVirtualText guifg=#FDD164
hi default link LightBulbQuickFixVirtualText LightBulbDefaultVirtualText
" sign
hi default LightBulbDefaultSign guifg=#FDD164
hi default link LightBulbQuickFixSign LightBulbDefaultSignLine
" numhl
"hi default LightBulbDefaultSignLine guifg=#FDD164
"hi default link LightBulbQuickFixSignLine LightBulbDefaultSignLine
  "}}}
"}}}

" Providers {{{
let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
let g:loaded_perl_provider = 0
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
  \'coc-python',
  \'coc-explorer',
  \'coc-json',
  \'coc-git',
  \'coc-tsserver',
  \'coc-sh',
  \'coc-lua',
  \'coc-vimlsp',
  \'coc-ultisnips',
  \'coc-ultisnips-select',
  \'coc-typos',
  \'coc-snippets',
  \'coc-marketplace',
  \'coc-node_modules',
  \'coc-html',
  \'coc-html-css-support',
  \'coc-eslint',
  \'coc-emmet',
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

"CoC Tailwind CSS {{{
au FileType html let b:coc_root_patterns = ['.git', '.env', 'tailwind.config.js', 'tailwind.config.cjs']
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

"Use :C to open CoC Config {{{
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
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

" Write, Quit, eXit {{{
" Control-W Save
nnoremap <C-W> :w<CR>
vnoremap <C-W> <esc> :w<CR>
"imap <C-W> <esc>:w<CR>
" Save + back into insert
" inoremap <M-W> <esc> :w<CR>a

" Control-Q Quit without save
nnoremap <C-Q> :q!<CR>
vnoremap <C-Q> <esc> :q!<CR>
inoremap <C-Q> <esc> :q!<CR>

" Control-X Exit
nnoremap <C-X> :wq<CR>
vnoremap <C-X> <esc> :wq<CR>
inoremap <C-X> <esc> :wq<CR>
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

" Navigate to the previous or next trailing whitespace{{{
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>
"}}}

" Nvim Space Folding {{{
  nnoremap <nowait><silent>  <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
  vnoremap <nowait><silent> <Space> zf
"}}}

" Telescope Keymaps {{{
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>
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

-- Rainbow Blank Line" {{{
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

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
--"}}}

-- Cursor Line" {{{
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 225,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
--}}}

-- Close Symbols" {{{
require("autoclose").setup({
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
})
--}}}

-- Vim Notify" {{{
vim.notify = require("notify")
--}}}

-- NeoTree" {{{
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
      untracked = "",
      ignored   = "",
      unstaged  = "󰄱",
      staged    = "",
      conflict  = "",
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
  width = 24,
  mapping_options = {
    noremap = true,
    nowait = true,
  },
  mappings = {
    ["<leader>"] = {
"toggle_node",
nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
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
  hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
  -- in whatever position is specified in window.position
-- "open_current",  -- netrw disabled, opening a directory opens within the
  -- window like netrw would, regardless of window.position
-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
  use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
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

EOF
"}}}
