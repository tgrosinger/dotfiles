" vim: foldmethod=marker
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin()

" Plug packages without settings {{{1
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'reedes/vim-wordy'
Plug 'scrooloose/syntastic'
Plug 'idanarye/vim-merginal'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-gitgutter'

" Undo {{{1
Plug 'simnalamburt/vim-mundo'
nnoremap <leader>u :GundoToggle<CR>

" NERDTree {{{1
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', 'node_modules']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1
map  <C-e> :NERDTreeToggle<CR>
map  <leader>e :NERDTreeFind<CR>

" Ctrl-p {{{1
Plug 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
        \ },
    \ 'fallback': 'find %s -type f'
    \ }

" YouCompleteMe {{{1
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
let g:ycm_complete_in_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

" JSON Support {{{1
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Tmux Integration {{{1
Plug 'christoomey/vim-tmux-navigator'
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>

" Tab Completion {{{1
Plug 'ervandew/supertab'
Plug 'sirver/ultisnips'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>""

" Color Scheme {{{1
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
set background=dark
colorscheme solarized
highlight ColorColumn ctermbg=0 guibg=#eee8d5


" DelimitMate {{{1
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1

" Airline {{{1
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " Tab bar at top
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
Plug 'fatih/vim-go'
au FileType go nmap <Leader>gb <Plug>(go-doc)
au FileType go nmap <Leader>gd <Plug>(go-def-vertical)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gl <Plug>(go-metalinter)
let g:go_auto_type_info = 0
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'aligncheck', 'ineffassign']
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'varcheck', 'aligncheck', 'dupl', 'ineffassign']

" Python Support {{{1
"Plug 'klen/python-mode'
"au FileType python let g:pymode_doc_bind = "<Leader>gb"
"au FileType python let g:pymode_rope_goto_definition_bind = "<Leader>gd"
"au FileType python let g:pymode_folding = 0

call plug#end()
filetype plugin indent on

" Appearance {{{1
set cursorline                  " Highlight the current line
set showmatch                   " Show matching brackets/parenthesis
set hlsearch                    " Highlight search terms
syntax on                       " Turn on syntax highlighting
set spell                       " Turn on spellchecking
set number                      " Turn on line numbers
set mouse=                      " Disable mouse support

let g:CSApprox_hook_post = ['hi clear SignColumn']
highlight clear CursorLineNr    " Remove highlight color from current line number
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
set textwidth=80
au FileType json setlocal textwidth=150
set colorcolumn=+1

set list                        " Highlight white-space characters
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " but only the ones we don't want

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
set autoindent     " Indent on paste
set smartindent    " Indent intelligently
set nojoinspaces   " Collapse spaces after sentences

" Don't exit visual mode when indenting
vnoremap < <gv
vnoremap > >gv

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

