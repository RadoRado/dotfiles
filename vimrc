set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

set hidden

" Better command-line completion
set wildmenu

"enable 256-color mode
set t_Co=256

" Show partial commands in the last line of the screen
set showcmd

set nohlsearch
set incsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F12> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F12>

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Watch for file changes.
set autoread

" Don't redraw while executing commands from macros and registers.
set lazyredraw
set ttyfast

" Start scrolling when you reach three lines before the end of the screen.
" Helps with the neck pain.
set scrolloff=3

" Make you keyboard actually do something while you are switched to Cyrillic
" layout. Ripped off @StanAngeloff.
set langmap+=чявертъуиопшщасдфгхйклзьцжбнмЧЯВЕРТЪУИОПШЩАСДФГХЙКЛЗѝЦЖБНМ;`qwertyuiop[]asdfghjklzxcvbnm~QWERTYUIOP{}ASDFGHJKLZXCVBNM,ю\\,Ю\|,

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Map <C-c> to yank the current selection into buffer
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>

" Map <C-a> to select the entire content of the file
nnoremap <C-a> ggVG

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

nnoremap <silent> <C-Right> :vsp<CR>
nnoremap <silent> <C-Up> :sp<CR>

" Open and close NerdTree with <C-n>
map <silent> <C-n> :NERDTreeToggle<CR>
map <C-z> <NOP>

let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'node_modules', 'bower_components']

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Close preview split when completion is done
if exists('#CompleteDone')
    autocmd CompleteDone <buffer> pclose
endif

"------------------------------------------------------------"

" Remove trailing whitespaces on save for specific file types
autocmd FileType c,cpp,python,ruby,javascript,jsx autocmd BufWritePre <buffer> :%s/\s\+$//e

" Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let mapleader=","

autocmd FileType python setlocal completeopt-=preview

" Enable folding
set foldmethod=indent
set foldlevel=99

nnoremap <space> za


" Recommended syntastic features
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic rules. Mostly taken from
" https://github.com/gsamokovarov/.files/blob/master/.vimrc#L382-L404

let g:syntastic_enable_signs=1

" Try to optimize syntastic in terminal Vim as its already 0 on MacVim.
let syntastic_full_redraws=0
let g:syntastic_enable_highlighting=0

" Add some fancy symbols for the error and warning messages.
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol='✠'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_warning_symbol='≈'

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['flake8']

" ctrl-p settings
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|build|yarn\.lock)|(\.(swp|ico|git|svn))$'

let g:jsx_ext_required = 0

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Have _ to be keyword for Ruby development
set iskeyword-=_

" Region expand settings
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

xmap fjson !python -m json.tool<CR>

" Prettier
let g:prettier#autoformat = 0
let g:prettier#config#trailing_comma = 'none'
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 80
" number of spaces per indentation level
let g:prettier#config#tab_width = 2
" use tabs over spaces
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#single_quote = 'true'


inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" To map your shortcut for autofilling import for the word under the cursor
nnoremap <C-@> :call PythonDomainKnowledgeFillImport()<CR>

" To map your shortcut for global searching
noremap <C-m> :call PythonDomainKnowledgeSearch()<Cr>

execute pathogen#infect()

" Vundle "
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'leshill/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'indenthtml.vim'
Plugin 'tpope/vim-markdown'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/syntastic'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'derekwyatt/vim-scala'
Plugin 'leafgarland/typescript-vim'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'kana/vim-textobj-user'
Plugin 'bps/vim-textobj-python'
Plugin 'davidhalter/jedi-vim'
Plugin 'mxw/vim-jsx'
Plugin 'isRuslan/vim-es6'
Plugin 'rust-lang/rust.vim'
Plugin 'prettier/vim-prettier'
Plugin 'HackSoftware/vim-python-domain-knowledge'

call vundle#end()

colorscheme obsidian

call expand_region#custom_text_objects('python', {
      \ 'af' :1,
      \ 'if' :1,
      \ 'ac' :1,
      \ 'ic' :1,
      \ })
