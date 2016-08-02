call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'gezpage/pdv'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'StanAngeloff/php.vim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'
Plug 'brookhong/DBGPavim'
Plug 'tobyS/vmustache'
Plug 'SirVer/ultisnips'
Plug 'mileszs/ack.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'alvan/vim-closetag'
Plug 'othree/html5.vim'
Plug 'edsono/vim-matchit'
Plug '~/.vim/neomake'
Plug 'tpope/vim-repeat'
Plug 'nanotech/jellybeans.vim'
Plug 'dbakker/vim-projectroot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/tmux-complete.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-expand-region'
Plug 'thinca/vim-ref'
Plug 'soh335/vim-ref-pman'
Plug 'Valloric/ListToggle'
Plug 'Valloric/YouCompleteMe'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/phpmanual'
Plug 'NLKNguyen/papercolor-theme'
Plug 'scrooloose/nerdcommenter'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'vim-scripts/dbext.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'troydm/zoomwintab.vim'
Plug 'KabbAmine/zeavim.vim'
Plug 'klen/python-mode'
Plug 'mfukar/robotframework-vim'
Plug 'tell-k/vim-autopep8'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'm2mdas/phpcomplete-extended'
Plug 'Shougo/unite.vim'

call plug#end()

" Startify

let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'z': '~/.zshrc'}, {'n': '~/.vim/notes.txt'} ]

" ArgWrap
nnoremap <silent> <leader>pa :ArgWrap<CR>

" ZoomWin
nnoremap <silent> <C-w><C-w> :ZoomWinTabToggle<CR>
nnoremap <silent> <C-w><C-o> :only<CR>

" Vim Notes

let g:notes_directories = ['~/Docs/Notes', '~/Documents/Notes']
let g:notes_suffix = '.txt'

" ListToggle

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 5

" Neomake

autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_php_phpcs_maker = {
    \ 'args': ['--standard=PSR2'],
    \ }
let g:neomake_php_enabled_makers = ['php', 'phpcs', 'phpmd']
let g:neomake_error_sign = {
    \ 'text': 'e❯',
    \ 'texthl': 'ErrorMsg',
    \ }
hi MyWarningMsg ctermbg=3 ctermfg=0
let g:neomake_warning_sign = {
    \ 'text': 'w>',
    \ 'texthl': 'MyWarningMsg',
    \ }

" Vim-ref

let g:ref_phpmanual_path = $HOME.'/Documents/php-chunked-xhtml'

" Supertab

"let g:SuperTabDefaultCompletionType = '\<C-Tab>'
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" YouCompleteMe

" http://0x3f.org/blog/make-youcompleteme-ultisnips-compatible/

"let g:ycm_filetype_blacklist = { 'php': 1 }
let g:ycm_rust_src_path = $HOME ."/Dev/rust/lang/rust-master/src/"
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php =
\ ['->', '::', '(', 'use ', 'namespace ', '\', 'new ']
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_key_list_select_completion = ['\<C-TAB>', '\<Down>']
let g:ycm_key_list_previous_completion = ['\<C-S-TAB>', '\<Up>']

" Ack.vim

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Deoplete

"let g:deoplete#enable_at_startup = 1
"let g:deoplete#omni#input_patterns = {}
"let g:deoplete#omni#input_patterns.php =
"\ '\h\w*\|[^- \t]->\w*'
"let g:deoplete#delimiters = ['/', '.', '::', ':', '#', '->']

" Tmux complete

let g:tmuxcomplete#trigger = 'omnifunc'

" Expand region

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Fzf

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] to customize the options used by 'git log':
let g:fzf_commits_log_options = "--pretty=format:'%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --decorate --color"

" NERDTree

let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 1

" php-cs-fixer

" If php-cs-fixer is in $PATH, you don't need to define line below
" let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "symfony"              " which level ?
let g:php_cs_fixer_config = "default"             " configuration
"let g:php_cs_fixer_config_file = '.php_cs'       " configuration file
let g:php_cs_fixer_php_path = "php"               " Path to PHP
" If you want to define specific fixers:
let g:php_cs_fixer_fixers_list = "short_array_syntax,concat_with_spaces,ordered_use,-phpdoc_short_description,phpdoc_order,align_double_arrow,align_equals"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.

" pdv documentor

let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"

" dbgPavim

let g:dbgPavimPort=9009
let g:dbgPavimBreakAtEntry=1
let g:dbgPavimPathMap = [['/home/gez/Dev/projects/mindtools_website','/var/www'],['/home/gez/Dev/projects/mindtools_auth_user_manager','/var/www/mindtools_auth_user_manager_deploy/current'],]
let g:dbgPavimKeyRun = '<F8>'
let g:dbgPavimKeyStepOver = '<F10>'
let g:dbgPavimKeyStepInto = '<F11>'
let g:dbgPavimKeyStepOut = '<F12>'
let g:dbgPavimKeyPropertyGet = '<F3>'
let g:dbgPavimKeyContextGet = '<F4>'
let g:dbgPavimKeyToggleBp = '<F9>'
let g:dbgPavimKeyToggleBae = '<F5>'
let g:dbgPavimKeyRelayout = '<F2>'

" Ultisnips

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/snippets']

" Tagbar

let g:tagbar_autoshowtag = 0
let g:tagbar_autopreview = 0
let g:tagbar_width = 30
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_show_visibility = 1
let g:tagbar_sort=0
set updatetime=2000

" GutenTags

"let g:gutentags_exclude = ['*.css', '*.pl', '*.html', '*.htm', '*.js', '*.sql', '*.py', 'app', 'bin', 'build', 'files', 'tests', 'vagrant', 'html/amember']
"let g:gutentags_cache_dir = '~/.vim/gutentags'

" PHP Complete

"let g:phpcomplete_parse_docblock_comments = 1
"let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_index_composer_command = '/usr/local/bin/composer'
autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP

" Colour scheme

"set background=dark
colorscheme jellybeans
"colorscheme PaperColor

" Lightline

" hide default mode line
set noshowmode
" always show lightline mode line
set laststatus=2
let g:lightline = {
    \ 'active': {
    \   'left': [['mode', 'paste'], ['readonly', 'absolutepath', 'modified'], ['tagbar']],
    \   'right': [['filetype'], ['lineinfo'], ['fugitive']]
    \ },
    \ 'inactive': {
    \   'left': [['absolutepath']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'component': {
    \   'lineinfo': '%l\%L [%p%%], %c, %n',
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'gutentags': '%{gutentags#statusline("[Generating...]")}',
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ },
    \ }

" Better whitespace

autocmd BufWritePre * StripWhitespace

" Gitgutter

let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0

" Persistent undo

set undodir=~/.vim/undodir
set undofile

" Misc

" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Mappings

"let mapleader = ","
let mapleader = "\<space>"
nnoremap <C-p> :ProjectRootCD<cr>:Files<cr>
"nnoremap <leader>fs :Goyo<cr>
nnoremap <leader>fs :GitGutterToggle<cr>:ZoomWinTabToggle<cr>
" Buffer switching
nnoremap <tab> :bp<cr>
nnoremap <S-tab> :bn<cr>
nnoremap <leader><tab> :Buffers<cr>
" Pane toggles
nnoremap <leader>1 :NERDTreeToggle<cr>
nnoremap <leader>2 :TagbarToggle<cr>
" Startup
nnoremap <leader>ss :Startify<cr>
" Syntax checking
nnoremap <leader>sc :SyntasticCheck<cr>
" .vimrc editing
nnoremap <leader>ve :e ~/.vimrc<cr>
nnoremap <leader>vv :source ~/.vimrc<cr>:PlugInstall<cr>
nnoremap <leader>vr :source ~/.vimrc<cr>
" Leader convenience keys
nnoremap <leader>m :Buffers<cr>
nnoremap <leader>` :NERDTreeFind<cr>
"nnoremap <leader>. :NERDTreeClose<cr>:ProjectRootCD<cr>:NERDTreeCWD<cr>:wincmd p<cr>:NERDTreeFind<cr>:wincmd p<cr>:TagbarOpen<cr>:wincmd =<cr>:redraw<cr>
" Close scratch, location list, change list, no highlight, syntax on - boom!
nnoremap <leader><esc> :pclose<cr>:lcl<cr>:ccl<cr>:noh<cr>:syntax enable<cr>
nnoremap <leader><space> :noh<cr>
" Splits like tmux
nnoremap <C-w>\| :vsplit<cr>
nnoremap <C-w>- :split<cr>
" PHP stuff
nnoremap <leader>fn :call PhpExpandClass()<cr>
nnoremap <leader>u :call PhpInsertUse()<cr>
nnoremap <leader>su :call PhpSortUse()<cr>
nnoremap <leader>pcf :call PhpCsFixerFixFile()<cr><cr>:Neomake<cr>
nnoremap <leader>db :call pdv#DocumentWithSnip()<cr>
" Neomake
nnoremap <leader>sc :Neomake<cr>
"nnoremap <S-j> :lnext<cr>
"nnoremap <S-k> :lprevious<cr>
" Window navigation
if has('nvim')
  "let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " Hack to get C-h working in neovim
  nmap <BS> <C-W>h
  tnoremap <Esc> <C-\><C-n>
endif

nnoremap <leader>nn :set relativenumber!<cr>:set number!<cr>

silent! nmap <silent> <unique> <leader>k <Plug>(ref-keyword)
silent! vmap <silent> <unique> <leader>k <Plug>(ref-keyword)

nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Stuff

set mouse=
autocmd BufEnter * set mouse=

syntax enable
set ignorecase
"set autochdir
set number
set relativenumber
" http://stackoverflow.com/questions/20975928/moving-the-cursor-through-long-soft-wrapped-lines-in-vim/21000307#21000307
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set wrap
set hidden
set complete-=i
" Reload files on change
set autoread

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Show scratch preview on autocomplete
set completeopt+=preview,menuone
set noswapfile
set directory=~/.vim/swapfiles/
set backupdir=~/.vim/swapfiles/

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END
