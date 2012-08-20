" ================================================================
"   Pathogen specific
" ================================================================
call pathogen#infect()
call pathogen#helptags()


" ================================================================
" Minimal settings 
" ================================================================

set nocompatible             " sanely reset when resourcing
filetype off                 " required!

syntax on                    " syntax highlighting
filetype plugin indent on    " enable file type detection and do language-dependent indenting.
set autoindent               " auto indenting
set nowrap                   " don't wrap long lines
set number                   " line numbers
colorscheme desert           " colorscheme desert
set nobackup                 " get rid of annoying ~file
set encoding=utf8            " set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac         " use Unix as the standard file type
set title                    " show title in console title bar
set autoread                 " set to auto read when a file is changed from the outside
set ruler                    " always show current position

" ================================================================
" General Settings
" ================================================================

set history=700                 " Sets how many lines of history VIM has to remember

if has('persistent_undo')
    set undofile                "so is persistent undo
    set undolevels=1000         "maximum number of changes that can be undone
    set undoreload=10000        "maximum number lines to save for undo on a buffer reload
endif


" Keyboard mappings to edit vimrc file and source it
" use comma as <Leader> key instead of backslash
let mapleader = ","
let g:mapleader = ","


" Keyboard mappings
nmap <F1> :previous<CR>                   " map F1 to open previous buffer
nmap <F2> :next<CR>                       " map F2 to open next buffer
 
nmap <leader>ev :sp ~/.vimrc<cr>          " edit my .vimrc file in a split
nmap <leader>sv :source ~/.vimrc<cr>      " update the system settings from my vimrc file

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.log,__init__.py,*.DS_Store

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>


" ================================================================
" VIM UI
" ================================================================

set wildmenu                    " turn on the WiLd menu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all... 
set gcr=n:blinkon0              " turn off the blinking cursor in normal mode:
set cmdheight=2                 " height of the command bar
set hid                         " a buffer becomes hidden when it is abandoned

set so=7                        " set 7 lines to the cursor - when moving vertically using j/k
set linespace=0                 " no extra spaces between rows

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" Searching
set ignorecase                  " ignore case when searching
set smartcase                   " when searching try to be smart about cases 
set hlsearch                    " highlight search results
set incsearch                   " makes search act like search in modern browsers

" Highlight search results
highlight Search term=reverse cterm=reverse
highlight IncSearch term=reverse cterm=reverse

" Clear highlight searches
nmap <silent> ,/ :nohlsearch<CR>

set lazyredraw                  " don't redraw while executing macros (good performance config)
set magic                       " for regular expressions turn magic on
set showmatch                   " show matching brackets when text indicator is over them
set mat=2                       " how many tenths of a second to blink when matching brackets


" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldenable                  " auto fold code

"" Whitespace highlighting
set list listchars=tab:\ \ ,trail:· " how the whitespaces look like
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

" ================================================================
" Colors and Fonts
" ================================================================

" Enable syntax highlighting
syntax enable
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t

    set lines=60           " height = 50 lines
    set columns=150        " width = 100 columns

    " Change colorscheme
    colorscheme desert

    " Change the font for GUI
    set guifont=Inconsolata\ 11

    " highlight current line in active window
    set cursorline
    hi CursorLine term=bold cterm=bold guibg=Grey40     " highlight bg color of current line
    hi CursorColumn term=bold cterm=bold guibg=Grey40   " highlight cursor   

    " Turns on the tab bar always
    set showtabline=2

endif


" ================================================================
" Files, backups and undo
" ================================================================
" Turn backup off, since most stuff is in SVN, git
set nobackup
set nowb
set noswapfile


" ================================================================
" Text, tab and indent related
" ================================================================
set expandtab			" use spaces instead of tabs
set smarttab                    " be smart when using tabs

set shiftwidth=4		" 1 tab == 4 spaces
set tabstop=4

set lbr				" linebreak on 500 characters
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


" ================================================================
" Moving around, tabs, windows and buffers
" ================================================================
map <leader>bd :Bclose<cr>	" Close the current buffer
map <leader>ba :1,1000 bd!<cr>  " Close all the buffers

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


" ================================================================
" Status line
" ================================================================
" Always show the status line
if has('cmdline_info')
    set ruler                   " show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif


" ================================================================
" Spell checking
" ================================================================
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" ================================================================
" Misc
" ================================================================
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" ================================================================
" Matching pairs
" ================================================================
" Map the auto-close for non-quotes
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
autocmd Syntax html,vim inoremap < <lt>><Left>

" Function to check next character
function! ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
else
return a:char
endif
endf

" Map closing characters
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>


" Map the auto-close for quotes
function! QuoteDelim(char)
let line = getline('.')
let col = col('.')
if line[col - 2] == "\\"
"Inserting a quoted quotation mark into the string
return a:char
elseif line[col - 1] == a:char
"Escaping out of the string
return "\<Right>"
else
"Starting a string
return a:char.a:char."\<Left>"
endif
endf 

inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

" ================================================================
" Plug-in specific changes
" ================================================================

" NERDTree config
nmap <leader>nt :NERDTree<cr>

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
