filetype off                  " required

" Vundle
" run :PluginInstall or vim +PluginInstall +qall
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'koron/minimap-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let mapleader = ','
color molokai
syntax on

set nocompatible
set laststatus=2

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
" Search
set hlsearch
set incsearch
set ignorecase
set conceallevel=3
set concealcursor=nivc

" Undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

set backspace=2
set smartcase
set ruler
set scrolloff=4
set backupdir=~/.swapfiles,$TMP
set directory=~/.swapfiles,$TMP

" For better completion
set completeopt=longest,menuone,preview

autocmd FileType java,cpp,h setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab
au BufRead,BufNewFile *.logcat setfiletype logcat

" Fix whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
au InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Navigation
nmap . .`[
map j gj
map k gk
map <c-j> :tjump 
map <c-h> :call SwitchSourceHeader() <CR>
map <F1> :bprev <CR>
map <F2> :bnext <CR>

map <s-c-F> :vimgrep <C-R><C-W>
map <s-c-h> :cscope find c <C-R><C-W><CR>
map <F4> :cscope find g <C-R><C-W><CR>
map <F9> :syntax match Eol "\r$" conceal cchar= <CR>
map <F11> :tjump <C-R><C-W> <CR>
map <F12> <C-]>


" Generate new ctags for project
map <F7> :!ctags -R --language-force=java --extra=+f --exclude=*.class .<CR>
map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q+f .<CR>

" Change between indentation settings
map <C-F9> :set tabstop=4<CR>:set shiftwidth=4<CR>:set expandtab<CR>:set cinoptions=<CR>
map <C-F10> :set tabstop=2<CR>:set shiftwidth=2<CR>:set expandtab<CR>:set cinoptions=<CR>

" Magically fold from search result
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

"Added ! to overwrite on reload
function! SwitchSourceHeader()
  let extension = expand("%:e")
  if extension ==? "cpp"
    let extension = ".h"
  else
    let extension = ".cpp"
  endif
  let file = expand("%:t:r").extension
  if bufexists(bufname(file))
    execute "buffer ".file
  else
    execute "tjump ".file
  endif
endfunction

set mouse=a

" Fix cursor
let &t_SI = "\<Esc>[6 q"
"let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;white\x7"
  silent !echo -ne "\033]12;white\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif

