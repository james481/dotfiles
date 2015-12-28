"-------------------------------------------------------------------------------
"
" Leader

let mapleader="\<Space>"

"-------------------------------------------------------------------------------
"
" Vundle Bundle Config

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Custom bundles go here

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'Shougo/neocomplete.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'evidens/vim-twig'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'rking/ag.vim'
Plugin 'groenewege/vim-less'
Plugin 'shawncplus/phpcomplete.vim'

call vundle#end()
filetype plugin indent on


" Bundle Config

let g:syntastic_auto_loc_list = 1
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" Neocomplete

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2

" <CR>: Close NC popup and expand snippet
" unless in comment (^(*|\/\/))

let g:ulti_expand_res = 0
function! s:BindCrSnippetExpand()
    if pumvisible()
        call neocomplete#close_popup()
    endif
    if getline(".") !~ '\v^(\s)*(*|\/\/)'
        call UltiSnips#ExpandSnippet()
        return (g:ulti_expand_res) ? "" : "\<CR>"
    endif
    return "\<CR>"
endfunction
inoremap <silent> <CR> <C-r>=<SID>BindCrSnippetExpand()<CR>

" <TAB>: completion.

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-d>"
let g:UltiSnipsEditSplit="vertical"
let g:snips_author="James Watts"

" Nerd Commenter

let g:NERDSpaceDelims=1

" NerdTree

let g:NERDTreeWinSize=40

"-------------------------------------------------------------------------------
"
" Colors

syntax on
set background=dark
colorscheme anotherdark
highlight Pmenu ctermfg=black ctermbg=248 guibg=248
set colorcolumn=81

"-------------------------------------------------------------------------------
"
" Set options.

" Search Options

set incsearch " Incremental search
set hlsearch " Highlight search matches
set showmatch " Show matching parens and braces
set smartcase " Use smart case (capitals override case-insensitive search)
set ignorecase " Case-insensitive search

" Indent Options

set autoindent " Indent next line
set expandtab " Always use spaces, not tabs
set shiftwidth=4
set tabstop=4

" File I/O Options

set hidden " Don't whine about buffers not being saved when jumping around
set modeline " Allow custom configurations per file
set modelines=5 " Number of lines to check for file settings
set noswapfile " Don't save a .swp file when editing
set nobackup " Don't save a ~ backup file when editing
set updatecount=0 " Don't create .swp files

" UI Options

set laststatus=2 " Always show status
set statusline=%<%f " Filename
set statusline+=\ %w%h%m%r " Flags
set statusline+=%{fugitive#statusline()} " Git Info
set statusline+=\ [%Y] " Filetype
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Info

" Command / Other Options

set wildmode=list:longest,full " Bash-like completion using <Tab>
set showmode " Show mode in footer
set showcmd " Show command in footer
set backspace=eol,start,indent " Backspace over line breaks, insertion, indent
set history=100 " Increase history of searches and commands
set wildmenu " Allow tab completion of filenames
set wildmode=longest:full " Look for longest match
set wildignore+=*/.git/*,*/vendor/*,*/puphpet/*,*/docs/api/*,*/data/*,*/node_modules/* " Ignore git, vendor, PuPHPet VM, NPM files
set magic " Regular expression magic
set pastetoggle=<F4> " Toggle paste mode

"-------------------------------------------------------------------------------
"
" Define key mappings.
"

" File Writing / Quit

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>

" Window / Tab Navigation

nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>t :tabedit<CR>
nnoremap <Leader>v :vnew<CR>

" Line numbers

nnoremap <Leader>n :set invnumber<CR>
nnoremap <Leader>N :set invrnu<CR>

" Bundle Mappings

nnoremap <F1> :BufExplorer<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <Leader>T :NERDTreeToggle<CR>
nnoremap <F3> :TagbarOpenAutoClose<CR>
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Git (Fugitive) Mappings

nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gd :Gdiff<CR>

" Formatting Mappings

nnoremap <Leader>Fh :%! tidy -iq -f /dev/null --tidy-mark n --doctype omit <CR>
nnoremap <Leader>Fj :%! python -m json.tool <CR>

" Misc

nnoremap <Leader>u <C-r>
nnoremap <Leader>r :reg<CR>
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>U :UltiSnipsEdit<CR>

"-------------------------------------------------------------------------------
"
" Misc
"

" Remove trailing whitespace

autocmd BufWritePre * :%s/\s\+$//e

" Drupal code style mode

let s:is_drupal_mode = 0
function! DrupalMode()
    if (s:is_drupal_mode)
        setlocal shiftwidth=4
        setlocal tabstop=4
        let s:is_drupal_mode=0
    else
        setlocal shiftwidth=2
        setlocal tabstop=2
        setlocal ft=php
        let s:is_drupal_mode=1
    endif
endfunction
nnoremap <Leader>D :call DrupalMode()<CR>
