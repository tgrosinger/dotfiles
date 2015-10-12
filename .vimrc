" vim: foldmethod=marker

"NeoBundle Setup {{{1
if has('vim_starting')
  set nocompatible               " Be iMproved
  filetype off          " turn this off for a minute

  " Required:
  set runtimepath+=/home/tgrosinger/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/tgrosinger/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" NeoBundle Packages without settings {{{1
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'reedes/vim-wordy'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'idanarye/vim-merginal'
NeoBundle 'godlygeek/tabular'
NeoBundle 'airblade/vim-gitgutter'

" Ctrl-p {{{1
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }

" YouCompleteMe {{{1
NeoBundle 'Valloric/YouCompleteMe', {
\ 'build' : {
\     'unix'  : './install.sh --gocode-completer',
\     'linux' : './install.sh --gocode-completer',
\    },
\ }
let g:ycm_complete_in_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

" JSON Support {{{1
NeoBundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Tmux Integration {{{1
NeoBundle 'christoomey/vim-tmux-navigator'
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>

" Tab Completion {{{1
NeoBundle 'ervandew/supertab'
NeoBundle 'sirver/ultisnips'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>""

" Color Scheme {{{1
NeoBundle 'altercation/vim-colors-solarized'

" DelimitMate {{{1
NeoBundle 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1

" Airline {{{1
NeoBundle 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " Tab bar at top
set t_Co=256
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
if has('statusline')
    set laststatus=2
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Golang Support {{{1
NeoBundle 'fatih/vim-go'
au FileType go nmap <Leader>gb <Plug>(go-doc)
au FileType go nmap <Leader>gd <Plug>(go-def-vertical)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gl <Plug>(go-metalinter)
let g:go_auto_type_info = 0
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'aligncheck', 'dupl', 'ineffassign']

" Python Support {{{1
"NeoBundle 'klen/python-mode'
"au FileType python let g:pymode_doc_bind = "<Leader>gb"
"au FileType python let g:pymode_rope_goto_definition_bind = "<Leader>gd"
"au FileType python let g:pymode_folding = 0

" NeoBundle Cleanup {{{1
" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Appearance {{{1
set background=dark
set cursorline                  " Highlight the current line
set showmatch                   " Show matching brackets/parenthesis
set hlsearch                    " Highlight search terms
syntax on                       " Turn on syntax highlighting
set spell                       " Turn on spellchecking
set number                      " Turn on line numbers

let g:CSApprox_hook_post = ['hi clear SignColumn']
highlight clear CursorLineNr    " Remove highlight color from current line number
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
set textwidth=80
au FileType json setlocal textwidth=150
set colorcolumn=+1

set list                        " Highlight white-space characters
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " but only the ones we don't want

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized
endif
highlight ColorColumn ctermbg=0 guibg=#eee8d5

" Tabs {{{1
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tt :tabnext<cr>

" Splits {{{1
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

" Whitespace {{{1
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent

" Search {{{1
set ignorecase
set smartcase
set incsearch

" Metadata {{{1
set backup
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
set undodir=$HOME/.vim/undo

if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" Git {{{1

au FileType gitcommit set tw=72 " Override the line length for git commits

" Always start the cursor at the top left corner in a commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Other Settings {{{1

set history=1000          " Greatly increase the size of the history (from 20)
set iskeyword-=.          " '.' is an end of word designator
set iskeyword-=#          " '#' is an end of word designator
set iskeyword-=-          " '-' is an end of word designator


let g:clang_user_options='|| exit 0'

set wildmenu                    " Show a menu rather than auto-completing
let mapleader = ","
let g:mapleader = ","

" <Leader>e: Fast editing of the .vimrc
nnoremap <Leader>e :e! ~/.dotfiles/.vimrc<cr>
nnoremap <Leader>r :so ~/.dotfiles/.vimrc<cr>

" autocompletion
:inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

