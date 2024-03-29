" MUSTDO {
    "Make CapLock == Escape
    "Key repleat rate high
    "Do vimtutor: last at 4.1
" }

" TIL {
    " registers -- http://www.brianstorti.com/vim-registers/
    " remote vimdiff a file
    "     vimdiff /path/to/file scp://remotehost//path/to/file
    " :81,91y<enter>  // copy from line to line range
    " vim scp://remoteuser@server.tld/relative/path/to/document
    "
    " :h quickref -- vim quick reference
" }


" basics {
    " Rebind <Leader> key
    " easy access
    let mapleader = ","

    " gvim gui font
    set guifont=Monospace\ 11

    " syntax colors
    colorscheme Tomorrow-Night-Eighties "dark gray bg
    "enable mouse... a small kitten will die when everytime the mouse is used
    "set mouse=a

    " Automatic reloading of .vimrc
    autocmd! bufwritepost .vimrc source %
    " Auto Save files when focus lost.
    "   update will only save changed files
    autocmd FocusLost * silent! update
    " Remove trailing whitespace on save 'w:'
    "autocmd BufWritePre *.vimrc,*.py,*.jinja,*.java,*.c,*.cpp,*.sls :%s/\s\+$//e
	" kill trailing whitespaces automatically for all files
	autocmd BufWritePre * :%s/\s\+$//e
	"   highlight trailing whitespace
	match ErrorMsg '\s\+$'
    autocmd VimResized * exe "normal! \<c-w>="
    syntax on
    " search highlight
    set hlsearch
    " Do not wrap lines
    set nowrap
    " break on space not words
    set linebreak
    " required
    set nocompatible

    " line numbers
    set number
    if v:version >= 703
        set relativenumber
    endif

    " required vundle, csv vim, p
    filetype off

    " *required for pyflakes, vundle
    filetype plugin indent on

    " stay 10 lines from the ends
    set scrolloff=4

    " VimDiff ugly and readability fixes
    if &diff
        " Ignore whitespace
        "set diffopt+=iwhite  " ignore white space
        " Always use vertical diffs
        set diffopt+=vertical
        " diff colors
        colorscheme monokai  "a pretty good coloring diff
        " turn off syntax highlighting because ugly
        syntax off
    endif

    " Copy Paste with ctrl+c and ctrl+v {
        vmap <C-c> "+yi
        vmap <C-x> "+c
        vmap <C-v> c<ESC>"+p
        imap <C-v> <C-r><C-o>+
    " }

    " toggle numbers and set list {
        noremap <F4> :set number! <bar> set relativenumber! <bar> set list! <CR>
    " }

    " fixCopyAndPaste {
        " paste toggle
        noremap <F2> :set paste!<CR>
        " skip named paste buffers.
        set clipboard=unnamed
    " }
    " search visual highlighted selected {
        vnoremap // y/<C-R>"<CR>
    " }
    " centeredSearching{
        """
        " n, *, # will be centered
        " so it's easy to find the stupid thing
        """
        nnoremap n nzz
        nnoremap N Nzz
        nnoremap * *zz
        nnoremap # #zz
        nnoremap g* g*zz
        nnoremap g# g#zz
    " }

    " ColumnLimit(80) {
        """
        " OldFart rule to stay under 80 columnss.
        " I like to keeps everyting in view
        " and as a side effect, funcions / methods tend to be smaller
        """
        if (&ft!='') " filetype not blank like logs
            if v:version >= 703
                " if vim version 7.3 or more
                " draws a vertical line at column 76
                set colorcolumn=76
            else
                " highlights lines after column 76
                syntax match Search /\%<81v.\%>77v/
                syntax match ErrorMsg /\%>80v.\+/
                autocmd BufRead,BufNewFile * syntax match Search /\%<81v.\%>77v/
                autocmd BufRead,BufNewFile * syntax match ErrorMsg /\%>80v.\+/
            endif
        endif
    " }

    " set_utf-8_encoding {
        if has("multi_byte")
            if &termencoding == ""
                let &termencoding = &encoding
            endif
            set encoding=utf-8
            setglobal fileencoding=utf-8
            "setglobal bomb
            set fileencodings=ucs-bom,utf-8,latin1
        endif
    " }

    " tabs {
        " see http://vim.wikia.com/wiki/Converting_tabs_to_spaces
        " use 4 spaces for tabs
        "   tabstop : tabs == number of spaces
        "   softtabstop: tabs == number of spaces while editing
        "                        backspace will tread 4 spaces as 1 tab
        "   shiftwidth: number of space to move when hitting tab-key
    " default tab settings
        set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

        function! Tab_stop4_noexpand()
            "spaces to tabs
            set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab | retab! 4
        endfunction

        function! Tab_stop4_expand()
            "tabs to spaces
            set tabstop=4 softtabstop=4 shiftwidth=4 expandtab | retab! 4
        endfunction

        if &filetype =~ 'python\|c\|c++\|java\|shell\|ruby\|javascript\|perl'
            autocmd! bufreadpost * call Tab_stop4_noexpand()
        endif

        function! Tab_stop2_noexpand()
            "spaces to tabs
            " exit if code type
            if &filetype =~ 'python\|c\|c++\|java\|shell\|ruby\|javascript\|perl'
                return
            endif
            set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab | retab! 2
        endfunction

        function! Tab_stop2_expand()
            "tabs to spaces
            " exit if code type
            if &filetype =~ 'python\|c\|c++\|java\|shell\|ruby\|javascript\|perl'
                return
            endif
            set tabstop=2 softtabstop=2 shiftwidth=2 expandtab | retab! 2
        endfunction

        " this replaces invisible chars
        "   display indentation guides.. looks like  |   |    |
        set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:␣,eol:¬
        " convert spaces to tabs when reading file
        " code only this will cause errors when reading readonly files
        autocmd! bufreadpost  *py.jinja,*.py,*.c,*.cpp,*.java,*.conf call Tab_stop4_noexpand()
        " convert tabs to spaces before writing file (save spaces only)
        autocmd! bufwritepre  *py.jinja,*.py,*.c,*.cpp,*.java,*.conf call Tab_stop4_expand()
        " convert spaces to tabs after writing file (to show guides again)
        autocmd! bufwritepost *py.jinja,*.py,*.c,*.cpp,*.java,*.conf call Tab_stop4_noexpand()
        " for SLS and Jinja files -----------------------------------------
        "   set ts=2 sts=2 sw=2  "TabStop SoftTabStop ShiftWidth
        " tab to space on read this should not be needed
        autocmd! bufreadpost  grains,*(?!.*(py)).jinja,*.sls call Tab_stop2_noexpand()
        " convert tabs to spaces before writing file (save spaces only)
        autocmd! bufwritepre  grains,*(?!.*(py)).jinja,*.sls call Tab_stop2_expand()
        " convert spaces to tabs after writing file (to show guides again)
        autocmd! bufwritepost grains,*(?!.*(py)).jinja,*.sls call Tab_stop2_noexpand()
        "
    " }
" }

" python {
    """
    let $PYTHONPATH='/opt/spot:/some/other/dir'
" }

" Functions {
    " put functions here

    " Swaps windows
    "     https://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
    " Usage
    "    Move to the window to mark for the swap via ctrl-w movement
    "    Type \mw
    "    Move to the window you want to swap
    "    Type \pw
    function! MarkWindowSwap()
        let g:markedWinNum = winnr()
    endfunction
    function! DoWindowSwap()
        "Mark destination
        let curNum = winnr()
        let curBuf = bufnr( "%" )
        exe g:markedWinNum . "wincmd w"
        "Switch to source and shuffle dest->source
        let markedBuf = bufnr( "%" )
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' curBuf
        "Switch to dest and shuffle source->dest
        exe curNum . "wincmd w"
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' markedBuf
    endfunction
    " wc - Window Cut
    nmap <silent> <leader>wc :call MarkWindowSwap()<CR>
    " wp - Window Cut
    nmap <silent> <leader>wp :call DoWindowSwap()<CR>

" }

" mapping {
    " force close no save
    nnoremap <leader>q :qa!<CR>
    " remove trailing white space at end of lines
    nnoremap <leader>sp :%s/\s\+$//e<CR>
    " remove trailing white space with button
	nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>


    " Bind nohl
    " Removes highlight of your last search
    " ``<C>`` stands for ``CTRL`` and therefore
    "   ``<C-n>`` stands for ``CTRL+n``
    noremap <C-n> :nohl<CR>
    vnoremap <C-n> :nohl<CR>
    inoremap <C-n> :nohl<CR>

    " visual search - searchs for thing highlighted
    vnoremap // y/<C-R>"<CR>"

    " Toggle line numbers
    nnoremap <leader>n :setlocal number!<cr>
    " Toggle relative line numbers
    nnoremap <leader>r :setlocal relativenumber!<cr>

    " set conf file to logstash syntax
    nnoremap <leader>l :set syn=logstash<cr>

    " set yaml syntax
    nnoremap <leader>y :set syn=yaml<cr>

    " VISUAL sort
    " map sort function to 's' key
    vnoremap <leader>s :sort<CR>
" }

"usability {
    " Convenient things to have
    "
    " When creating new *.py files add this to the top
    autocmd BufNewfile *.py call append(0,'#! /usr/bin/env python')
    autocmd BufNewfile *.py call append(1,'# -*- coding: utf-8 -*-')
    "
    " When creating new *.sh files add this to the top
    autocmd BufNewfile *.sh call append(0,'#! /bin/bash')
    autocmd BufNewfile *.sh call append(1,'# logging _this_ script to syslog')
    autocmd BufNewfile *.sh call append(2,'exec 1> >(logger -s -t $(basename $0)) 2>&1')
    "
    " When switching buffers, preserve window view.
    if v:version >= 700
        "vim 700 and up
        autocmd BufLeave * if !&diff | let b:winview = winsaveview() | endif
        autocmd BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | endif
    endif

    " for compiling only 1 file mash F10
    autocmd FileType python nnoremap <F10> :w <bar> exec '!python '.shellescape('%')<CR>
    autocmd FileType sh     nnoremap <F10> :w <bar> exec '!bash -c ./'.shellescape('%')<CR>
    autocmd FileType c      nnoremap <F10> :w <bar> exec '!gcc    '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
    autocmd FileType cpp    nnoremap <F10> :w <bar> exec '!g++    '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
    "autocmd FileType java ... TODO

    "
    " Set PowerShell syntax for ps1 files
    augroup powershell
        au!
        autocmd BufNewFile,BufRead *.ps1,*.ps1.jinja set syntax=ps1
        autocmd BufNewFile,BufRead *.psd1 set syntax=ps1
        autocmd BufNewFile,BufRead *.psm1 set syntax=ps1
    augroup END

    " jinja syntax
    autocmd BufNewFile,BufRead *.py.jinja set syntax=python
    autocmd BufNewFile,BufRead *.tf.jinja set syntax=terraform

	" terraform
    autocmd BufNewFile,BufRead *.tf set syntax=terraform
"}


" VundlePlugins {
    " Vundle Plugins and options
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " GitHub_Plugins {
        " fugitive is a Git plugin for git pull / push etc
        "   see https://github.com/tpope/vim-fugitive
        Plugin 'tpope/vim-fugitive'

        "==== JAVA section ==============================
        "if v:version >= 703
        "    " for Java: ultisnips are java / python snippets
        "    "    see https://github.com/SirVer/ultisnips
        "    "    uses <tab> by default to activate
        "    Plugin 'SirVer/ultisnips.git'
        "endif
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
        " C++ syntax <<< in syntastick TODO confirm
        "Plugin 'octol/vim-cpp-enhanced-highlight'
        "
        " rhysd/vim-clang-format C++ auto formater
        "  TODO setup
        Plugin 'rhysd/vim-clang-format'
        "
        " C++ vim.A - E.g. if you are editing foo.c
        "     and need to edit foo.h simply execute :A
        "     and you will be editting foo.h, to switch back to foo.c execute :A again.
        Plugin 'vim-scripts/a.vim'
        "
        " Syntax highlighting for PowerShell
        Plugin 'PProvost/vim-ps1'
        "
        " === Python ===
        " syntastic - syntax checking for lots of stuff - https://vimawesome.com/plugin/syntastic
        Plugin 'vim-syntastic/syntastic'
        "
        " Python auto complete
        "Plugin 'davidhalter/jedi-vim'
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
        " vim-yaml linter
        Plugin 'avakhov/vim-yaml'
        "
		" Terraform for vim
		Plugin 'hashivim/vim-terraform'
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
        " vim_markdown_composer - uses Rust
        Plugin 'euclio/vim-markdown-composer'
        " riv.vim rST reStructuredText
        Plugin 'Rykka/riv.vim'
        Plugin 'Rykka/InstantRst'
        "
        " Repeat vim - make . work better
        Plugin 'tpope/vim-repeat'
        "
        " Make using the clipboard and pastbuffers easier
        Plugin 'svermeulen/vim-easyclip'
        "
        " CSV Editing
        Plugin 'chrisbra/csv.vim'
        "
        if v:version >= 703
            " Airline status bar
            Plugin 'vim-airline/vim-airline'
            " Airline themes
            Plugin 'vim-airline/vim-airline-themes'
            " PowerLine status -- not sure how to use. and too heavy
            "Plugin 'powerline/powerline'
            " PowerLine fonts for use in airline
            Plugin 'powerline/fonts'
        endif
        "
        " AutoFormat Python code
        Plugin 'tell-k/vim-autopep8'
        "
        " Logstash syntax highlighing
        Plugin 'robbles/logstash.vim'
        " nerdtree
        Plugin 'scrooloose/nerdtree'
    " }

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required TODO: find what this does?
    " To ignore plugin indent changes, instead use:
    "filetype plugin on

    " Brief help
        " :PluginList         lists configured plugins
        " :PluginInstall      installs plugins; append `!` to update or just :PluginUpdate
        " :PluginSearch foo   searches for foo; append `!` to refresh local cache
        " :PluginClean        confirms removal of unused plugins; append `!` to auto-approve removal
        "
        " see :h vundle for more details or wiki for FAQ
        " Put your non-Plugin stuff after this line
" }


" PluginConfigs {


    " SuperTab {
        " tab completion - <ctrl+p>
        " context    ctrl+p
        " cycle      ctrl+n
        " context works great!
        let g:SuperTabDefaultCompletionType = 'context'
    " }

    " Undo tree {
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
    " }

    " TagBar {
        nmap <F8> :TagbarToggle<CR>
    " }

    " anyFold {
        " folding plugin
        " active for all filetypes, old on indent   see :h anyfold

        " fold only python c cpp java
        autocmd FileType python,c,cpp,java AnyFoldActivate
        "
        " zf#j      creates a fold from the cursor down # lines.
        " zf/string creates a fold from the cursor to string .
        " zj        moves the cursor to the next fold.
        " zk        moves the cursor to the previous fold.
        " zo        opens a fold at the cursor.
        " zO        opens all folds at the cursor.
        " zc        close a fold at the cursor.
        " zm        increases the foldlevel by one.
        " zM        closes all open folds.
        " zr        decreases the foldlevel by one.
        " zR        decreases the foldlevel to zero -- all folds will be open.
        " zd        deletes the fold at the cursor.
        " zE        deletes all folds.
        " [z        move to start of open fold.
        " ]z        move to end of open fold.
        "
    " }

    " cycleFolding {
    "   usage:
    "       tab tab : open
    "        tab+shift tab+shift : close
    "
        set modifiable
        let g:fold_cycle_default_mapping = 0 "disable default mappings
        nmap <Tab><Tab> <Plug>(fold-cycle-open)
        nmap <S-Tab><S-Tab> <Plug>(fold-cycle-close)"
    " }

    " easyClip {
       " TODO test this... not sure we need it
       " - easy clipboad usage (needs repate.vim)
       " NOTE: m is now cut (text) and dd will 'naturaly' delete
       "      usage: <motion> then mm - to cut (or move)
       "             p - to put
       "
       " gm to add mark instead m
       nnoremap gm m
    " }

    " repeatVim {}

    " csvVim{
    " 'chrisbra/csv.vim'
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
    " }

    " ropevim {
        """
        " for refactoring
        " https://github.com/python-rope/ropevim
        " :help ropevim
        "    setup needed:
        "      python setup.py install
        "      or yum install python-rope
        "      and/or pip install ropevim
        """
            " Docs
            "find occurrences command (C-c f by default)
            "
            " use vim's complete function in insert mode
            let ropevim_vim_completion=1
            " AutoImport
            "    add the name of modules you want to autoimport
            let g:ropevim_autoimport_modules = ["os", "shutil", "sys"]
            "
    " }

    " ExuberantCtags {
        """
        " VimTags
        "    to index run to following command in cwd:
        "
        "    ctags -R -f ./.git/tags .
        "        then do :set tags+=/opt/edfman
        "
        "    this places the tags file in the .git folder
        """
    " }
    " OmniComplete {
        """
        " run the ctags thing above to make this work
        " ctrl-p to match
        " ctrl-p to match
        " ctrl-p to match
    " }

    " Airline status bar themes {
        """
        " https://github.com/vim-airline/vim-airline/wiki/Screenshots
        " deleted sym link:
        "     /etc/fonts/conf.d/70-no-bitmaps.conf
        "     * this works
        " Install fonts:
        "     wget  https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf  https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
        "     sudo mv PowerlineSymbols.otf /usr/share/fonts/
        "     sudo fc-cache -vf
        "     sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
        """
        if v:version >= 703
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
        endif
    " }

    " AutoPep8 {
        " keyboard shortcut Autopep8
        autocmd FileType python noremap <buffer> <F7> :call Autopep8()<CR>
    " }

    " ultisnips{
    "  help UltiSnips
    "    if v:version >= 703
    "        " Trigger configuration. Do not use <tab> if you use YouCompleteMe, fold-cycle
    "        let g:UltiSnipsExpandTrigger="<c-~>" " default is <tab>
    "        let g:UltiSnipsJumpForwardTrigger="<c-b>"
    "        let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    "    endif
    " }

    " flake8 {
        " TODO: get description
    " }

    " syntastic {
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 0  " shows bottom list?
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
    " }
    "
    " vim_markdown_composer {
        " install rust:
        " then in plugin directory
        "   cargo build --release --no-default-features --features json-rpc
    " }
    "
    " riv.vim {
        " You can add projects with command  ` g:riv_projects: `
        "     see http://www.youtube.com/watch?v=sgSz2J1NVJ8
        "
        "let proj1 = { 'path': '~/Dropbox/rst',}
        "let g:riv_projects = [proj1]
        "
        " More options see the :RivInstruction
    " }
    "
    " nerdtree {
        " open a NERDTree automatically when vim starts opening a directory
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
        " ctrl-e to open tree
        map <C-e> :NERDTreeToggle<CR>
        " tab thing does not behave
        " open files in new tab
        "let NERDTreeMapOpenInTab='<ENTER>'
    " }
    "
    " jedi-vim {
      "for vim split
      " This options could be 'left', 'right', 'top', 'bottom' or 'winwidth'.
      " It will decide the direction where the split open.
      "let g:jedi#use_splits_not_buffers = "left"
      " example str. <pop>
      "let g:jedi#popup_on_dot = 0
      " select the first item
      "let g:jedi#popup_select_first = 0

    " }

    " TODO test
    " octol/vim-cpp-enhanced-highlight ??? <<< Does Syntastick already cover this?
" }

" NOTES {
    " split window { -------------------------------------------------------------
    "
    "   Basic split window commaands
    "     ctrl+W +/-: increase/decrease height (ex. 20<C-w>+)
    "     ctrl+W >/<: increase/decrease width (ex. 30<C-w><)
    "     ctrl+W _: set height (ex. 50<C-w>_)
    "     ctrl+W |: set width (ex. 50<C-w>|)
    "     ctrl+W =: equalize width and height of all windows
    "     See also: :help CTRL-W
    "
    "   Rotating windows
    "     To change two vertically split windows to horizonally split
    "        ctrl-w t ctrl-w K
    "
    "     Horizontally to vertically:
    "        ctrl-w t ctrl-w H
    "
    "     Open vertical 10 with len char
    "       :10sp ~/.zshrc
    "
    "   Resizing splits
    "     Vim’s defaults are useful for changing split shapes:
    "
    "     Max out the height of the current split
    "       ctrl + w _
    "
    "     Max out the width of the current split
    "       ctrl + w |
    "
    "     Normalize all split sizes, which is very handy when resizing terminal
    "       ctrl + w =
    "
    "     To change two vertically split windows to horizonally split
    "       Ctrl-w t Ctrl-w K
    "
    "     Horizontally to vertically:
    "       Ctrl-w t Ctrl-w H
    "
    "       Explanations
    "         Ctrl-w t makes the first (topleft) window current
    "         Ctrl-w K moves the current window to full-width at the very top
    "         Ctrl-w H moves the current window to full-height at far left
    "
    " }
    "
    "
    "
    "
    " --------------------------------------------------------------------
    " Explanations -------------------------------------------------------
    " --------------------------------------------------------------------
    "
    " Ctrl-w t makes the first (topleft) window current Ctrl-w K moves the current
    " window to full-width at the very top Ctrl-w H moves the current window to
    " full-height at far left
    "
    " some vimrc links
    " https://github.com/mscoutermarsh/dotfiles/blob/master/vimrc
    " https://github.com/thoughtbot/dotfiles/blob/master/vimrc
    "
    " change word in
    " ci) - Change Inside )-parens
    " ci" - Change Inside "-quotes
    " ci} - Change Inside }-braces
    " de - delete till end.
    " ce - change word: deletes to end and sets insert
    " line line line line
    "   \ <<<   coninuation char
    "
    "
    " ~     Toggle case of the character under the cursor,
    "       or all visually-selected characters.
    " 3~    Toggle case of the next three characters.
    " g~3w  Toggle case of the next three words.
    " g~iw  Toggle case of the current word (inner word – cursor anywhere in word).
    " g~$   Toggle case of all characters to end of line.
    " g~~   Toggle case of the current line (same as V~).
    "       The above uses ~ to toggle case. In each example,
    "       you can replace ~ with u to convert to lowercase,
    "       or with U to convert to uppercase.
    " For example:
    " U      Uppercase the visually-selected text.
    "        First press v or V then move to select text.
    "        If you don't select text, pressing U will undo all changes to the current line.
    " gUU    Change the current line to uppercase (same as VU).
    " gUiw   Change current word to uppercase.
    " u      Lowercase the visually-selected text.
    "        If you don't select text, pressing u will undo the last change.
    " guu    Change the current line to lowercase (same as Vu).
" }
