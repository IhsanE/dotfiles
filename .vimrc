"act similar to mswin applications, Control+C, Control+P, etc.
behave mswin

"its ok to not be vi compatibale
set nocompatible

"don't create ~filename backups, very annoying to leave this on and find dozens of extra files scattered about
set nobackup


"enable the mouse & features
"set mouse=a
set selectmode-=mouse "Use the mouse just like visual mode, so you can use vim commands on mouse selections, eg. 'x' to cut and 'y' to yank

"This is should match your terminal background, white-on-black is the default
"vim setting. For black-on-white choose 'light'
"set background=light


set backspace=2 "backspace works in insert mode, much more user-friendly
set tabstop=4 "set tab width to 4 spaces
set shiftwidth=4 "set (auto)tab's to width of 4 spaces
"Neither of the above actually puts spaces into a file when tabbing, they simply display 4 spaces when a \t is read
set ignorecase "ignore case when searching
set hlsearch "highlight searchs
set smartcase "override ignorecase if any search character is uppercase
set autoindent "turn on auto indent
set smartindent "turn on smart indent
set number "show line numbers
set nowrap "don't wrap lines longer than the screen's width
set guioptions+=b "show bottom scrollbar when in gvim
set foldmethod=indent "fold code based on indents
set nofoldenable "makes sure the code is not folded when first opened, used zi to toggle
set ruler "Show line statistics in bottom left corner
set scrolloff=4 "Keep 4 lines at minimum above & below the cursor when scrolling around a file

"These options are personal preference
"set cursorline "Underline the current line the cursor is on.
"set incsearch "highlight search matches as typed, may jar your mind while it jumps around the file

"Upgrade the status line to give more usefull information
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P
set laststatus=2 "Make statusline always on
set cmdheight=2 "default command line number of lines, 2 makes it easier to read

"Printing (:hardcopy) options
set printoptions=paper:letter,syntax:y,number:y,duplex:off,left:5pc

"Enable filetype's
filetype on
filetype indent on
filetype plugin on

"Wrap visual selections with chars
":vnoremap ( "zdi(<C-R>z)<ESC>
":vnoremap { "zdi{<C-R>z}<ESC>
":vnoremap [ "zdi[<C-R>z]<ESC>
":vnoremap ' "zdi'<C-R>z'<ESC>
":vnoremap " "zdi"<C-R>z"<ESC>

"If your having trouble with the backspace character, try uncommenting these
"imap <C-?> <BS>
"imap <C-H> <BS>
"inoremap <BS>

" Automake using a screen window
function! Automake()
	if !$STY
		"echo "Not in a screen" "for debugging, be silent if no screen
		return
	endif
	let sty = strpart(matchstr($STY,"\\..*"), 1)
	silent! exec "!screen -p 0 -S ".sty."-test -X eval 'stuff make
'" | redraw!
endfunction

" Remap the tab key to select action with InsertTabWrapper
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

if has("autocmd")
    " Have Vim jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

    " Trim Trailing white space on general files
    " autocmd FileType c,cpp,java,php,js,css,xml,xsl,s,go autocmd BufWritePre * :%s/[ \t\r]\+$//e

	"Automake on save
	autocmd BufWritePost * call Automake()
endif

"set colorcolumn=80


"highlight OverLength ctermbg=green ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

set expandtab ts=4 sw=4 ai

"autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
"set colorcolumn=80
autocmd FileType python set tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab|set colorcolumn=80|set nosmartindent
autocmd FileType c set ts=4|set sw=4|set noexpandtab
autocmd FileType java set wrap|set colorcolumn=
autocmd FileType javascript set wrap|set tabstop=4|set shiftwidth=4|set softtabstop=4|set colorcolumn=125|set expandtab
autocmd FileType html set wrap|set tabstop=2|set shiftwidth=2|set softtabstop=2|set colorcolumn=|set expandtab
autocmd BufNewFile,BufRead *.lib set syntax=txt 
autocmd BufNewFile,BufRead *.feature set wrap

noremap cc :norm i
noremap CC :norm ^x<CR> 

func! Linewrap()
  :set wrap
  :set linebreak
  :set nolist
  :set textwidth=0
  :set wrapmargin=0
  match
endfunc

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --no:

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

:imap jj <Esc>

" Delete trailing white space
func! DWS()
	exe "normal mz"
	%s/\s\+$//e
	exe "normal `z"
endfunc
autocmd BufWrite *.c :call DWS()
autocmd BufWrite *.h :call DWS()
autocmd BufWrite *.cc :call DWS()
autocmd BufWrite *.py :call DWS()
autocmd BufWrite *.java :call DWS()
autocmd BufWrite *.js :call DWS()
autocmd BufWrite *.feature :call DWS()
autocmd BufWrite *.scss :call DWS()

" Fix saving issues
:ca WQ wq
:ca Wq wq
:ca W w
:ca Q q
:ca nogl nohl

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <C-N> :bnext<CR> 
nnoremap <C-B> :bprev<CR> 

" Don't need shift for commands
nnoremap ; :
vnoremap ; :

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
set clipboard=unnamed
au BufRead,BufNewFile *.g set syntax=antlr3
au BufRead,BufNewFile *.groovy set wrap

set path=.,/usr/include,/Users/thiago/projects/thm-dev/THM/frontend_v2/js/**,,
ca F find
ca S sort i

" INSTALL VIM-PLUG:
" 1) curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" 2) Restart vim
" 3) Type :PlugInstall
" 4) Things should be installing if you define your plugins as below

call plug#begin('~/.vim/plugged')
Plug 'ap/vim-buftabline'
Plug 'rking/ag.vim'
Plug 'acoustichero/goldenrod.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/neocomplete.vim'
call plug#end()

let g:ag_working_path_mode="r"

syntax on 
set background=dark
colorscheme goldenrod 
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'
let &t_Co=256
" The Silver Searcher
if executable('ag')
  " Use ag over grep
    set grepprg=ag\ --nogroup

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
    endif

let g:ctrlp_map = '\t'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
