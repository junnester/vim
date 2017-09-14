" basics 
set nocompatible                " be iMproved, required
filetype off                    " required
                                " required vundle "filetype
                                " required csv vim , this will ignore 
                                "      'plugin indent on'
filetype plugin on              " needed for csv.vim
filetype plugin indent on       " required for pyflakes, vundle
syntax on                       " syntax highlighting
set mouse=a                     " enable mouse
set colorcolumn=78              " draws a vertical line at column 78

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
    " for Java: ultisnips are java / python snippets 
    "    see "https://github.com/SirVer/ultisnips
    "    uses <tab> by default to activate
    Plugin 'SirVer/ultisnips.git'
    "
    " for Java: autocopmlete code
    "    https://github.com/artur-shaik/vim-javacomplete2
    "Plugin 'artur-shaik/vim-javacomplete2'
    "Plugin 'dansomething/vim-eclim'
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
    " C++ syntax 
    Plugin 'octol/vim-cpp-enhanced-highlight'
    "
    " rhysd/vim-clang-format C++ auto formater
    "  TODO setup
    Plugin 'rhysd/vim-clang-format'
    "
    " C++ vim.A - E.g. if you are editing foo.c and need to edit foo.h simply execute :A
    "     and you will be editting foo.h, to switch back to foo.c execute :A again. 
    Plugin 'vim-scripts/a.vim'
    "
    " === Python ===
    " syntastic - syntax checking for lots of stuff not java
    Plugin 'vim-syntastic/syntastic'
    "
    " Python auto complete  
    Plugin 'davidhalter/jedi-vim'
    "
    " Python Error highlighting - linter -- NOTE this is merged in Syntastic
    "Plugin 'kevinw/pyflakes-vim'
    "
    " Pep8 linter - highlighing  - wrapper for pyflakes
    Plugin 'nvie/vim-flake8'
    " 
    " Python rope a refactoring library
    Plugin 'python-rope/rope'
    " Python ropevim for refactoring - needs rope
    Plugin 'python-rope/ropevim'
    "
    "==== Project Structure stuff ===========================
    " Project - for managing projects
    "    see help project
    Plugin 'vimplugin/project.vim'
    "
    " TagBar shows code structures like methods... 
    Plugin 'majutsushi/tagbar'
    "
    " Vim Tags needed for TagBar -- this needs ctags installed
    Plugin 'szw/vim-tags'
    "
    " undo tree
    Plugin 'mbbill/undotree'
    "
    " any fold - folds code by indent
    Plugin 'pseewald/vim-anyfold'
    "
    " cycle folding -- like togle instead of vim default 
    Plugin 'arecarn/vim-fold-cycle'
    "
    "
    "==== Utilities and Tools =======================
    "
    " Repeat vim - make . better
    Plugin 'tpope/vim-repeat'
    "
    " Make using the clipboard and pastbuffers easier
    Plugin 'svermeulen/vim-easyclip'
    "
    " CSV Editing 
    Plugin 'chrisbra/csv.vim'
    "
    " Airline status bar
    Plugin 'vim-airline/vim-airline'
    " Airline themes
    Plugin 'vim-airline/vim-airline-themes'
    "
    " PowerLine status -- not sure how to use. and too heavy
    "Plugin 'powerline/powerline'
    " PowerLine fonts for use in airline
    Plugin 'powerline/fonts'
    "
    " AutoFormat Python code
    Plugin 'tell-k/vim-autopep8'
    "
    " for Java:  keeps a vertical line for indents
    "Plugin 'Yggdroot/indentLine.git'
    "Plugin 'nathanaelkane/vim-indent-guides' " <<  no like
    "
    " Logstash syntax highlighing
    Plugin 'robbles/logstash.vim'
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
    "
    " diff mode conitions
    " if &diff
    "     set diffopt+=iwhite  " ignore white space
    " endif
    " 
    " syntax colors
    "colorschem monokai
    "colorschem vibrantink
        colorscheme Tomorrow-Night-Bright  "black bg
    "colorscheme Tomorrow-Night-Eighties "dark gray bg
    "colorscheme Tomorrow "white bg
    "
    " search highlight
        set hls
    
    " do not wrap lines
        set wrap!
    "
    " remove trailing whitespace on save 'w:'
    "     could be dangerous
        "autocmd BufWritePre * %s/\s\+$//e
        " pytthon only
        autocmd BufWritePre *.py %s/\s\+$//e
    " function to remove trailing white space
        function StripTrailingWhitespace()
          if !&binary && &filetype != 'diff'
            normal mz
            normal Hmy
            %s/\s\+$//e
            normal 'yz<CR>
            normal `z
          endif
        endfunction
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
    "
"""""""""""""""""""""""""""""""""""""""""""""
" TABs
" TODO: needs work.  see http://vim.wikia.com/wiki/Converting_tabs_to_spaces
" elimiate tab conversion for non python files
"                                           
"""""""""""""""""""""""""""""""""""""""""""""
    " use 4 spaces for tabs
    "   tabstop : tabs == number of spaces
    "   softtabstop: tabs == number of spaces while editing
    "   shiftwidth: number of space to move when hitting tab-key
    set tabstop=4 softtabstop=4 shiftwidth=4

    " display indentation guides.. looks like  |---|---
    "set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
    set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:×

    " convert spaces to tabs when reading file
    "     _i think_ this causes errors when displaying readonly files
    "autocmd! bufreadpost * set noexpandtab | retab! 4

    " convert tabs to spaces before writing file
    autocmd! bufwritepre * set expandtab | retab! 4

    " convert spaces to tabs after writing file (to show guides again)
    autocmd! bufwritepost * set noexpandtab | retab! 4
    "
"""""""""""""""""""""""""""""""""""""""""""""
" nathanaelkane/vim-indent-guides
" IS duplicate.  Not Needed
"""""""""""""""""""""""""""""""""""""""""""""
"    set background=dark
"    let g:indent_guides_auto_colors = 0
"    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=red   ctermbg=black
"    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey
"    let g:indent_guides_start_level = 1
"    let g:indent_guides_guide_size = 1
"    "
"""""""""""""""""""""""""""""""""""""""""""""
" SuperTab - tab completion - <ctrl+p>
"   context    ctrl+p
"   cycle      ctrl+n
"""""""""""""""""""""""""""""""""""""""""""""
" context wors great!
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
"
"
"""""""""""""""""""""""""""""""""""""""""""""
" anyfold active for all filetypes
"   see :h anyfold
"""""""""""""""""""""""""""""""""""""""""""""
" enable anyfold and auto-fold for everything
"let g:anyfold_activate=1 
" fold only file type.  1 == True, 0 == False
autocmd Filetype python let b:anyfold_activate=0
" Identify (and ignore) comment lines
"let g:anyfold_identify_comments = 1
" Fold multiline comments
"let anyfold_fold_comments=1 
"
"""""""""""""""""""""""""""""""""""""""""""""
" cycle folding
"""""""""""""""""""""""""""""""""""""""""""""
set modifiable
let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <Tab><Tab> <Plug>(fold-cycle-open)
nmap <S-Tab><S-Tab> <Plug>(fold-cycle-close)"
"""""""""""""""""""""""""""""""""""""""""""""
" vim-easyclip - easy clipboad usage (needs repate.vim)
"""""""""""""""""""""""""""""""""""""""""""""
   " NOTE: m is now cut (text) and dd will 'naturaly' delete 
   "      usage: <motion> then mm - to cut (or move)
   "             p - to put
   " 
   " gm to add mark instead m
   nnoremap gm m
"""""""""""""""""""""""""""""""""""""""""""""
" repeat.vim
"
"""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
" CSV Editing 'chrisbra/csv.vim'
"""""""""""""""""""""""""""""""""""""""""""""
   " make csv files readonly
   "autocmd BufWinEnter *.csv set buftype=nowrite | :%s/, /,/g
   " filetype highlighting need this for  auto locoading
   filetype plugin on
   " no folding
   let g:csv_disable_fdt = 1
   " comments line
   let g:csv_comment = '#'
   " no commas in the field.  not even escaped comma
   let g:csv_strict_columns = 1
   " highlight COLUMN
   "let g:csv_highlight_column = 'y'
   " set column width increments
   "let b:csv_fixed_width="1,5,9,13,17,21"
   "
   " visuall arrange all columns
   "let g:csv_autocmd_arrange = 1
   " visually arrage for files smaller than 1 MB
   "let g:csv_autocmd_arrange_size = 1024*1024
   "
"""""""""""""""""""""""""""""""""""""""""""""
" ropevim for refactoring
"    https://github.com/python-rope/ropevim
"    :help ropevim
"    setup needed: 
"        python setup.py install
"        or yum install python-rope
"        and/or pip install ropevim
"""""""""""""""""""""""""""""""""""""""""""""
    " Docs
    ""find occurrences command (C-c f by default)
    ""
    " use vim's complete function in insert mode 
    let ropevim_vim_completion=1
    " AutoImport
    "    add the name of modules you want to autoimport
    "let g:ropevim_autoimport_modules = ['os', 'shutil'] <usedToBe doubleQuote
    "
"""""""""""""""""""""""""""""""""""""""""""""
" Exuberant Ctags - VimTags
"    to index run to following command in cwd:
"
"    ctags -R -f ./.git/tags .
"   
"    this places the tags file in the .git folder
"
"""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
" Airline status bar themes
"   https://github.com/vim-airline/vim-airline/wiki/Screenshots
"   deleted sym link:
"        /etc/fonts/conf.d/70-no-bitmaps.conf
"        * this works
"   Install fonts:
"        wget  https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf  https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
"        sudo mv PowerlineSymbols.otf /usr/share/fonts/
"        sudo fc-cache -vf
"        sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
"""""""""""""""""""""""""""""""""""""""""""""
    " Enable power line fonts
    let g:airline_powerline_fonts=1

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_symbols.space = "\ua0"
    "
    " set AirlineTheme 
    "let g:airline_theme='tomorrow'
    let g:airline_solarized_dark_inactive_border = 1
    let g:airline_theme='ubaryd'
    "
"""""""""""""""""""""""""""""""""""""""""""""
" AutoPep8
"""""""""""""""""""""""""""""""""""""""""""""
" keyboard shortcut Autopep8
autocmd FileType python noremap <buffer> <F7> :call Autopep8()<CR>
"
"
"""""""""""""""""""""""""""""""""""""""""""""
" SirVer/ultisnips
"     help UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""
    " Trigger configuration. Do not use <tab> if you use YouCompleteMe, fold-cycle
    let g:UltiSnipsExpandTrigger="<c-~>" " default is <tab> 
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
"
"""""""""""""""""""""""""""""""""""""""""""""
" nvie/vim-flake8  TODO: get description
"""""""""""""""""""""""""""""""""""""""""""""
    "
"""""""""""""""""""""""""""""""""""""""""""""
" Syntastic 
"""""""""""""""""""""""""""""""""""""""""""""
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0  " shows bottom list?
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
"
"""""""""""""""""""""""""""""""""""""""""""""
" octol/vim-cpp-enhanced-highlight ??? <<< Does Syntastick already cover this?
"
"
"""""""""""""""""""""""""""""""""""""""""""""
" Macros
" NOTE: 
" for compiling only 1 file
autocmd filetype python nnoremap <F10> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c      nnoremap <F10> :w <bar> exec '!gcc    '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp    nnoremap <F10> :w <bar> exec '!g++    '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
"
"""""""""""""""""""""""""""""""""""""""""""""
""""NOTES on BASICS""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""
" To change two vertically split windows to horizonally split
" 
" Ctrl-w t Ctrl-w K
" 
" Horizontally to vertically:
" 
" Ctrl-w t Ctrl-w H
" 
" Explanations:
" 
" Ctrl-w t makes the first (topleft) window current Ctrl-w K moves the current
" window to full-width at the very top Ctrl-w H moves the current window to
" full-height at far left
