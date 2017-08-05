set nocompatible                " be iMproved, required
"filetype off                   " required
filetype plugin indent on       " needed for eclim
syntax on                       " syntax highlighting

"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" VUNDLE
"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"
" GitHub repo
" fugitive is a Git plugin for git pull / push etc
"   see https://github.com/tpope/vim-fugitive
Plugin 'tpope/vim-fugitive'
"
"==== JAVA section ==============================
" for Java: ultisnips are java snippets 
"    see "https://github.com/SirVer/ultisnips
"    uses <tab>
Plugin 'SirVer/ultisnips.git'
"
" for Java:  keeps a vertical line for indents
"Plugin 'Yggdroot/indentLine.git'
Plugin 'nathanaelkane/vim-indent-guides'
"
" for Java: autocopmlete code
"    https://github.com/artur-shaik/vim-javacomplete2
Plugin 'artur-shaik/vim-javacomplete2'
"Plugin 'dansomething/vim-eclim'   " to heavy
"= end JAVA section =
"
"==== Syntax stuff ==============================
" Theme - need high color - $ tmux -2
Plugin 'sickill/vim-monokai'
Plugin 'vim-scripts/vibrantink'
Plugin 'd11wtq/tomorrow-theme-vim'
"
" Syntax hilighting for salt
Plugin 'saltstack/salt-vim'
"
" Syntax hilighting for Cisco and network - enable with :set ft=cisco
Plugin 'CyCoreSystems/vim-cisco-ios'
"
" for Bracket and quote completion
Plugin 'Raimondi/delimitMate'
"
" tab complettion
Plugin 'ervandew/supertab'
"
" syntastic - syntax checking for lots of stuff not java
Plugin 'vim-syntastic/syntastic'
"
"================================================
"
" TagBar shows project structures like methods... 
Plugin 'majutsushi/tagbar'
" Vim Tags needed for TagBar -- this needs ctags installed
Plugin 'szw/vim-tags'
" undo tree
Plugin 'mbbill/undotree'
"
"
"
"
"
"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" All of your Plugins must be added before the following line
"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList         lists configured plugins
" :PluginInstall      installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo   searches for foo; append `!` to refresh local cache
" :PluginClean        confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


"""""""""""""""""""""""""""""""""""""""""""""
" My stuf below this line
"""""""""""""""""""""""""""""""""""""""""""""
" line numbers
set number
set relativenumber
" syntax colors
"colorschem monokai
"colorschem vibrantink
"colorscheme Tomorrow-Night-Bright  "black bg
colorscheme Tomorrow-Night-Eighties "dark gray bg
"colorscheme Tomorrow "white bg
" search highlight
set hls
"
"""""""""""""""""""""""""""""""""""""""""""""
" For utf-8 encoding
"""""""""""""""""""""""""""""""""""""""""""""
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

"""""""""""""""""""""""""""""""""""""""""""""
" TABs
                                            
"""""""""""""""""""""""""""""""""""""""""""""
" use 4 spaces for tabs
set tabstop=4 softtabstop=4 shiftwidth=4
" display indentation guides.. looks like  |---|---
"set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:×
" convert spaces to tabs when reading file
autocmd! bufreadpost * set noexpandtab | retab! 4
" convert tabs to spaces before writing file
autocmd! bufwritepre * set expandtab | retab! 4
" convert spaces to tabs after writing file (to show guides again)
autocmd! bufwritepost * set noexpandtab | retab! 4
"
"""""""""""""""""""""""""""""""""""""""""""""
" nathanaelkane/vim-indent-guides
"""""""""""""""""""""""""""""""""""""""""""""
set background=dark
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
"
"""""""""""""""""""""""""""""""""""""""""""""
" SuperTab - tab completion - <ctrl+p>
"   context    ctrl+p
"   cycle      ctrl+n
"""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = 'context'
"
"""""""""""""""""""""""""""""""""""""""""""""
" Undo tree
"""""""""""""""""""""""""""""""""""""""""""""
":UndotreeToggle     #hit: <F5>
nnoremap <F5> :UndotreeToggle<cr>
"   Persistent undo
"     It is highly recommend to enable the persistent undo. If you don't like your
"     working directory be messed up with the undo file everywhere, you may add
"     the following line to your vimrc in order to make them stored together.
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
"""""""""""""""""""""""""""""""""""""""""""""
" TagBar
"""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""
" javacomplete2
" see https://github.com/artur-shaik/vim-javacomplete2
"""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
nmap <leader>jii <Plug>(JavaComplete-Imports-Add
imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
imap <C-j>ii <Plug>(JavaComplete-Imports-Add)
nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)
imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)
nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)
imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)
vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <silent> <buffer> <leader>jn <Plug>(JavaComplete-Generate-NewClass)
nmap <silent> <buffer> <leader>jN <Plug>(JavaComplete-Generate-ClassInFile)
"""""""""""""""""""""""""""""""""""""""""""""

