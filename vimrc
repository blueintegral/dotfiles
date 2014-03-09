"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                 ""
""  General stuff                                                  ""
""                                                                 ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't emulate vi bugs!
set nocompatible

" do backups
set backup
set backupdir=~/.vim/backup//

" do undo files
if exists("undofile")
    set undofile 
    set undodir=~/.vim/undo//
endif

" do swap files
set dir=~/.vim/swap//,/var/tmp//,/tmp//,.

" load libraries
execute pathogen#infect()
filetype plugin indent on


set ts=4
set shiftwidth=4
set noexpandtab		" spaces suck, use tabs
set ai				" auto-indent

filetype indent on	" filetype-specific indenting
filetype plugin on	" filetype-specific plugins

" scons
autocmd BufReadPre,BufNewFile SConstruct set filetype=python
autocmd BufReadPre,BufNewFile SConscript set filetype=python

set ignorecase		" case-insensitive search
set incsearch		" when searching, highlight as you type

" prevent 'cheating'
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" sublime
au BufNewFile,BufRead *.sublime-settings set filetype=json
au BufNewFile,BufRead *.sublime-project set filetype=json

" JSON
let g:vim_json_syntax_conceal = 0

noremap :bb ddk$





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                 ""
""  Appearance                                                     ""
""                                                                 ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do syntax highlighting
syntax enable

" always show at least three lines before and after the cursor
set scrolloff=3

" use a visual bell instead of beeping
set visualbell

" show line numbers to the left - 3 characters, relative offset
set number " show line numbers to the left
set numberwidth=3
if exists("+relativenumber")
    set relativenumber
endif
set ruler			" show line number in bottom bar

syntax enable
set background=dark
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                 ""
""  Behavior                                                       ""
""                                                                 ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" do indentation
set autoindent
set smartindent

" can background buffers without saving them
set hidden 

" better tab-completion in commands
set wildmenu 
set wildmode=list:longest " complete using the longest common string in the cmd

" use four spaces for tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" backspace goes over indents, EOLs, and starts.
set backspace=indent,eol,start 

" tell vim that we're using a really fast terminal
set ttyfast 

" better searching
set incsearch
set ignorecase
set smartcase
set hlsearch

" configure Ctrl-P
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                                                 ""
""  Keybindings                                                    ""
""                                                                 ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" go by visible line rather than file line
nmap j gj
nmap k gk

" keybinding to remove highlighting
nmap \q :nohlsearch<CR>

" better buffer switching
nmap <C-e> :e#<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" control-p
nmap ; :CtrlPBuffer<CR>
