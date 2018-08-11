" Visuals {{{

        colorscheme badwolf
        syntax enable  " syntax processing
        set number      " line numbers
        set showcmd     " show command in bottom bar
        set cursorline  " highlight current line
        filetype indent on " load file-type specific indent files
        set wildmenu " visual autocomplete for command menu
        set lazyredraw " redraw only when need to.
        set showmatch " highlight matching [{()}]
        nnoremap <leader>u :GundoToggle<CR> " Uber Undo

" }}}
" Tabbing {{{

        settabstop=4 " tab to spaces
        setsofttabstop=4 " tab to spaces while editing
        set expandtab " tabs are spaces

" }}}
" Searching {{{

        set incsearch " search as characters are entered
        set hlsearch "  highlight matches
        " Turn off search highlighting with space
        noremap <leader><space> :nohlsearch<CR>

" }}}
" Folding {{{

        set foldenable " enable folding
        set foldlevelstart=10 " open most folds by default
        set foldnestmax=10 " max nested folds
        noremap <space> za " space opens and closes folds
        set foldmethod=indent " fold based on indent level

" }}}
" Movement {{{

        " move vertically by visual line
        noremap j gj
        noremap k gk

        " move to beginning/end of line
        noremap B ^
        noremap E $

        " $/^ do nothing
        noremap $ <nop>
        noremap ^ <nop>

        " highlight last inserted text
        noremap gV `[v`]
        let mapleader="," " leader is comma
        inoremap jj <esc>

        " save session
        nnoremap <leader>s :mksession<CR>
        " open ag.vim silver searcher
        nnoremap <leader>a :Ag

"}}}
" CtrlP settings {{{

        let g:ctrlp_match_window = 'bottom,order:ttb' "match from top to bottom
        let g:ctrlp_switch_buffer = 0 "always open files in new buffers
        let g:ctrlp_working_path_mode = 0 " let us change the working directory during a Vim session and make CtrlP respect that change
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' 

" }}}
" Pathogen {{{

        " call pathogen#infect() " use pathogen
        " call pathogen#runtime_append_all_bundles() " use pathogen

" }}}
" TMUX {{{

        " allows cursor change in tmux mode
        " allows change from block cursor mode to vertical bar cursor mode when using tmux. Without these lines, tmux always uses block cursor mode.
        if exists('$TMUX')
            let $t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
            let $t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        ELSE
            let $t_SI = "\<Esc>]50;CursorShape=1\x7"
            let $t_EI = "\<Esc>]50;CursorShape=0\x7"
        endif

" }}}
" AutoGroups {{{

        " This is a slew of commands that create language-specific settings for certain filetypes/file extensions. It is important to note they are wrapped in an augroup as this ensures the autocmd's are only applied once. In addition, the autocmd! directive clears all the autocmd's for the current group.

        augroup configgroup
            autocmd!
            autocmd VimEnter * highlight clear SignColumn
            autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                        \:call <SID>StripTrailingWhitespaces()
            autocmd FileType java setlocal noexpandtab
            autocmd FileType java setlocal list
            autocmd FileType java setlocal listchars=tab:+\ ,eol:-
            autocmd FileType java setlocal formatprg=par\ -w80\ -T4
            autocmd FileType php setlocal expandtab
            autocmd FileType php setlocal list
            autocmd FileType php setlocal listchars=tab:+\ ,eol:-
            autocmd FileType php setlocal formatprg=par\ -w80\ -T4
            autocmd FileType ruby setlocal tabstop=2
            autocmd FileType ruby setlocal shiftwidth=2
            autocmd FileType ruby setlocal softtabstop=2
            autocmd FileType ruby setlocal commentstring=#\ %s
            autocmd FileType python setlocal commentstring=#\ %s
            autocmd BufEnter *.cls setlocal filetype=java
            autocmd BufEnter *.zsh-theme setlocal filetype=zsh
            autocmd BufEnter Makefile setlocal noexpandtab
            autocmd BufEnter *.sh setlocal tabstop=2
            autocmd BufEnter *.sh setlocal shiftwidth=2
            autocmd BufEnter *.sh setlocal softtabstop=2
        augroup END

" }}}
" Backups {{{

        " if you leave a Vim process open in which you've changed file, Vim creates a "backup" file. Then, when you open the file from a different Vim session, Vim knows to complain at you for trying to edit a file that is already being edited. The "backup" file is created by appending a ~ to the end of the file in the current directory. This can get quite annoying when browsing around a directory, so I applied the following settings to move backups to the /tmp folder.

        set backup
        set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
        set backupskip=/tmp/*,/private/tmp/*
        set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
        set writebackup

" }}}
" Vim Edit/Load Bindings {{{

        " Edit vim/zshrc and load vimrc bindings
        nnoremap <leader>ev :vsp $MYVIMRC<CR>
        nnoremap <leader>ez :vsp ~/.zshrc<CR>
        nnoremap <leader>sv :source $MYVIMRC<CR>

" }}}
" Custom Functions {{{

        " toggle between number and relativenumber
        function! ToggleNumber()
            if(&relativenumber == 1)
                set norelativenumber
                set number
            else
                set relativenumber
            endif
        endfunc

        " strips trailing whitespace at the end of files. this
        " is called on buffer write in the autogroup above.
        function! <SID>StripTrailingWhitespaces()
            " save last search & cursor position
            let _s=@/
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            let @/=_s
            call cursor(l, c)
        endfunction

" }}}
" Plugins {{{

Plug 'pangloss/vim-javascript'  " Syntax Highlighting 
Plug 'mxw/vim-jsx'              " Syntax Highlighting
Plug 'mattn/emmet-vim'          " Build HTML text with CSS Selectors
" Emmet Settings {{{
        let g:user_emmet_leader_key='<Tab>'
        let g:user_emmet_settings = {
          \  'javascript.jsx' : {
            \      'extends' : 'jsx',
            \  },
          \}
        " HowTo {{{
                Give it a try: in insert mode, type p.description, and then hit Tab-, (without leaving insert mode). It will expand as <p className="description"></p>. Note that this is using the JSX className syntax, thanks to the tweak on user_emmet_settings.
        " }}}
" }}}

" Syntastic has been the go-to solution for syntax checking in Vim for a while, but it has the major flaw of being synchronous. That means that you can’t do anything - not even move your cursor - while it is running. For large files, this gets annoying rather quickly. The good news is that Vim now has support for async tasks, and you can switch to Ale, which is short for Asynchronous Lint Engine. You will never be interrupted by your linter again, hurray!
Plug 'w0rp/ale'
" ale/eslint Settings {{{
        "yarn add --dev eslint babel-eslint eslint-plugin-react
        "eslint --init
        let g:ale_sign_error = '●' " Less aggressive than the default '>>'
        let g:ale_sign_warning = '.'
        let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
"}}}

" Prettier
" yarn add --dev prettier eslint-config-prettier eslint-plugin-prettier
" Command --fix src/App.js, and src/App.js
Plug 'skywind3000/asyncrun.vim'
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

" }}}
" Leader Command List {{{

        "line 14 // nnoremap <leader>u :GundoToggle<CR> \\
        "line 27 //  noremap  <leader><space> :nohlsearch<CR> " Turn off search highlighting with space \\
        "line 59 //  nnoremap <leader>s :mksession<CR> " save session \\
        "line 61 // nnoremap <leader>a :Ag " open ag.vim silver searcher \\

" }}}
" .vimrc fold settings {{{

        " tell vim to fold sections by markers, rather than indentation
        foldmethod=marker
        " Then we want it to close every fold by default so that we have this high level view when we open our vimrc.
        foldlevel=0
        " Now, this is a file-specific setting, so we can use a modeline to make Vim only use these settings for this file. Modelines are special comments somewhere in a file that can can declare certain Vim settings to be used only for that file. So we'll tell Vim to check just the final line of the file for a modeline.
        set modelines=1

" }}}

" echo "MY VIMRC LOADED"
" let myVar = "MY VIMRC LOADED"

" vim:foldmethod=marker:foldlevel=0
