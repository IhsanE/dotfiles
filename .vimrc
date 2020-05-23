" $$$$$$\ $$\   $$\  $$$$$$\   $$$$$$\  $$\   $$\
" \_$$  _|$$ |  $$ |$$  __$$\ $$  __$$\ $$$\  $$ |
"   $$ |  $$ |  $$ |$$ /  \__|$$ /  $$ |$$$$\ $$ |
"   $$ |  $$$$$$$$ |\$$$$$$\  $$$$$$$$ |$$ $$\$$ |
"   $$ |  $$  __$$ | \____$$\ $$  __$$ |$$ \$$$$ |
"   $$ |  $$ |  $$ |$$\   $$ |$$ |  $$ |$$ |\$$$ |
" $$$$$$\ $$ |  $$ |\$$$$$$  |$$ |  $$ |$$ | \$$ |
" \______|\__|  \__| \______/ \__|  \__|\__|  \__|

"                 2017-07-12

"       $$\    $$\ $$$$$$\ $$\      $$\
"       $$ |   $$ |\_$$  _|$$$\    $$$ |
"       $$ |   $$ |  $$ |  $$$$\  $$$$ |
"       \$$\  $$  |  $$ |  $$\$$\$$ $$ |
"        \$$\$$  /   $$ |  $$ \$$$  $$ |
"         \$$$  /    $$ |  $$ |\$  /$$ |
"          \$  /   $$$$$$\ $$ | \_/ $$ |
"           \_/    \______|\__|     \__|
"

" REQUIREMENT: VIM-PLUG
" INSTALL:
"    (mac/linux)
"
" 1) curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2) Restart vim
" 3) Type :PlugInstall
" 4) Things should be installing if you define your plugins as below

call plug#begin('~/.vim/plugged')
Plug 'ap/vim-buftabline'
Plug 'acoustichero/goldenrod.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'valloric/matchtagalways'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'duganchen/vim-soy'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Ivo-Donchev/vim-react-goto-definition'
call plug#end()


" REQUIREMENT: RipGrep
" INSTALL:
"  (mac)
"  1. brew install ripgrep
"
"  (linux)
"  1. curl https://sh.rustup.rs -sSf | sh
"  2. cargo install ripgrep
if executable('rg')
  " Use rg over grep
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    endif


" COMMAND: \t
" DESCRIPTION: Launches fuzzy searcher
nnoremap <silent> <Leader>t :FZF<CR>

" COMMAND: :Find <Search Query>
" DESCRIPTION: RipGreps across project for search term
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
nnoremap <C-f> :Find <C-R><C-W><CR>:cw<CR>
vnoremap <C-f> y:Find <C-R>"<CR>:cw<CR>

colorscheme goldenrod
let g:airline_theme='cobalt2'
let &t_Co=256
let g:airline_powerline_fonts = 1

"kien/rainbow_parentheses.vim
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
"Keep rainbow_parentheses always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"valloric/matchtagalways
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'js' : 1,
    \ 'javascript' : 1,
    \ 'es6' : 1,
    \}

"act similar to mswin applications, Control+C, Control+P, etc.
behave mswin

"its ok to not be vi compatibale
set nocompatible

"disable swap file creation
set noswapfile

"don't create ~filename backups, very annoying to leave this on and find dozens of extra files scattered about
set nobackup

"enable the mouse & features
set mouse=a
set selectmode-=mouse "Use the mouse just like visual mode, so you can use vim commands on mouse selections, eg. 'x' to cut and 'y' to yank
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
set foldmethod=indent "fold code based on indents
set nofoldenable "makes sure the code is not folded when first opened, used zi to toggle
set ruler "Show line statistics in bottom left corner
set scrolloff=4 "Keep 4 lines at minimum above & below the cursor when scrolling around a file

"Upgrade the status line to give more usefull information
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P
set laststatus=2 "Make statusline always on

"Enable filetype's
filetype on
filetype indent on
filetype plugin on

" Have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif
set expandtab ts=4 sw=4 ai

autocmd FileType python set wrap|set tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab|set colorcolumn=120|set nosmartindent
autocmd FileType c set ts=4|set sw=4|set noexpandtab
autocmd FileType java set wrap|set colorcolumn=120
autocmd FileType javascript set wrap|set tabstop=4|set shiftwidth=4|set softtabstop=4|set colorcolumn=125|set expandtab
autocmd FileType html set wrap|set tabstop=2|set shiftwidth=2|set softtabstop=2|set colorcolumn=|set expandtab
autocmd BufNewFile,BufRead *.lib set syntax=txt
autocmd BufNewFile,BufRead *.feature set wrap
autocmd BufNewFile,BufRead *.es6 set syntax=javascript

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
autocmd BufWrite *.python :call DWS()
autocmd BufWrite *.scss :call DWS()

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <C-N> :bnext<CR>
nnoremap <C-B> :bprev<CR>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set clipboard=unnamed
set noshowmode
syntax on
set background=dark

ca F find
ca S sort i

" neoclide/coc.nvim
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
noremap <leader>D :call ReactGotoDef()<CR>
