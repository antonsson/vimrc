filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Shougo/deoplete.nvim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/fzf.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'nvie/vim-flake8'
Plugin 'rhysd/vim-clang-format'
Plugin 'tell-k/vim-autopep8'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'udalov/kotlin-vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

let mapleader = ','
color molokai
syntax on

" General stuff
set nocompatible
set laststatus=2
set mouse=a
set backspace=2
set smartcase
set ruler
set scrolloff=4
set conceallevel=0

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set cindent

" Search
set hlsearch
set incsearch
set ignorecase

" Undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Swaps
set backupdir=~/.vim/swaps,$TMP
set directory=~/.vim/swaps,$TMP

" deoplete startup
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#file#enable_buffer_path = 1

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

" EditorConfig
autocmd FileType javascript noremap <buffer><Leader>cf :call JsBeautify()<cr>
autocmd FileType json noremap <buffer><Leader>cf :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer><Leader>cf :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer><Leader>cf :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer><Leader>cf :call CSSBeautify()<cr>

" Python - autopep8
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <buffer><Leader>cf :call Autopep8()<cr>

" CPP
autocmd FileType cpp setlocal shiftwidth=2 tabstop=2

" Makefiles should use tabulators
autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab

" Logcat syntax files
autocmd BufRead,BufNewFile *.logcat setfiletype logcat

" Gitgutter
nmap <Leader>u :GitGutterToggle<cr>

" YouCompleteMe
let g:ycm_log_level = 'debug'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
highlight YcmWarningLine cterm=none
highlight YcmWarningSection cterm=none
nmap <Leader>g :YcmCompleter GoTo <cr>
nmap <F4> :YcmCompleter GoTo <CR>

" Navigation
nmap . .`[
nmap j gj
nmap k gk
nmap <c-j> :tjump 
nmap <Leader>j :tjump 
nmap <c-h> :call SwitchSourceHeader() <CR>
nmap <F3> :cclose <CR> :YcmCompleter FixIt <CR>
nmap <F11> :tjump <C-R><C-W> <CR>
nmap <F12> <C-]>

" Generate new ctags for project
nmap <F8> :!ctags -R --c++-kinds=+p --fields=+ilaS --extras=+q+f .<CR>
nmap <C-F8> :!ctags -R --language-force=java --extras=+f --exclude=*.class .<CR>

" Change between indentation settings
nmap <F9> :set tabstop=4<CR>:set shiftwidth=4<CR>:set expandtab<CR>:set cinoptions=<CR>
nmap <F10> :set tabstop=2<CR>:set shiftwidth=2<CR>:set expandtab<CR>:set cinoptions=<CR>

" terminal remaps
tnoremap <Esc> <C-\><C-n>

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

" clang-format
let g:clang_format#detect_style_file = 1
let g:clang_format#style_options = {
            \ "Standard" : "C++11"}
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType typescript noremap <buffer><Leader>cf :ClangFormat<cr>

