if filereadable(expand("~/.vim/vimrc.plugins"))
     source ~/.vim/vimrc.plugins
endif


set encoding=utf-8
set history=1000
set clipboard=unnamed
set clipboard+=unnamedplus
set scrolloff=5
syntax enable
set backspace=indent,eol,start
let mapleader = ','
set nonumber 
set noshowmode
set autoindent
set smarttab
set tabstop=4 " Set tabstop to tell vim how many columns a tab counts for. Linux kernel code expects each tab to be eight columns wide.
set expandtab " When expandtab is set, hitting Tab in insert mode will produce the appropriate number of spaces.
set softtabstop=4 " Set softtabstop to control how many columns vim uses when you hit Tab in insert mode. If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.
set shiftwidth=4 " Set shiftwidth to control how many columns text is indented with the reindent operations (<< and >>) and automatic C-style indentation.
set wildmenu
set hidden
set nocompatible
set showcmd



"set ls=2 " This makes Vim show a status line even when only one window is shown
"filetype plugin on " This line enables loading the plugin files for specific file types
"setlocal foldmethod=indent " Set folding method
"set nocp " This changes the values of a LOT of options, enabling features which are not Vi compatible but really really nice
"set cindent " This turns on C style indentation
"set si " Smart indent
"set nowrap " Don't Wrap lines!
"set showmatch " Show matching brackets
"set noswapfile " Avoid swap files
"set mouse= " Mouse Integration

"-------------------- Visuals --------------------"
if !has('gui_running')
  set t_Co=256
endif
set background=dark
colorscheme solarized8_high 
if (has("termguicolors"))
    set termguicolors
endif
let base16colorspace=256
let g:solarized_termcolors=256
let g:solarized_diffmode = 'high'
let g:solarized_old_cursor_style = 1

set guifont=Fira_Code:h17
set linespace=15

set guioptions-=e

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

hi LineNr guibg=bg
set foldcolumn=2
hi foldcolumn guibg=bg

hi vertsplit guifg=bg guibg=bg


"-------------------- Search --------------------"
set hlsearch
set incsearch
set ignorecase
set smartcase


"-------------------- Split Management --------------------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"-------------------- Mappings --------------------"
nmap <Leader>ev :tabedit ~/.vim/vimrc<cr>
nmap <Leader><space> :nohlsearch<cr>

nnoremap <Up> :echomsg "use k"<cr>
nnoremap <Down> :echomsg "use j"<cr>
nnoremap <Left> :echomsg "use h"<cr>
nnoremap <Right> :echomsg "use l"<cr>

nnoremap <silent> #3 :tabprevious<cr> " switch to previous tab with F3
nnoremap <silent> #2 :tabnext<cr> " switch to next tab with F2

nmap <Leader>f :tag<space>

noremap x "_x
vnoremap p "_dP

nmap Y y$
nmap 0 ^
"-------------------- Plugins --------------------"
"/
"/ LiteLine 
"/
"let g:lightline = {
"  \   'colorscheme': 'solarized',
"  \   'active': {
"  \     'left':[ [ 'mode', 'paste' ],
"  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
"  \     ]
"  \   },
"	\   'component': {
"	\     'lineinfo': ' %3l:%-2v',
"	\   },
"  \   'component_function': {
"  \     'gitbranch': 'fugitive#head',
"  \   }
"  \ }
"let g:lightline.separator = {
"	\   'left': '', 'right': ''
"  \}
"let g:lightline.subseparator = {
"	\   'left': '', 'right': '' 
"  \}
"let g:lightline.tabline = {
"  \   'left': [ ['tabs'] ],
"  \   'right': [ ['close'] ]
"  \ }
"set showtabline=2  " Show tabline
"/
"/ Aireline
"/
let g:airline#extensions#tabline#enabled = 1 " showing tabs 
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme='luna'
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#clock#format = '%H:%M:%S'
let g:airline#extensions#clock#updatetime = 1000

let g:airline#extensions#tabline#left_sep = "\ue0b0 "
let g:airline#extensions#tabline#left_alt_sep = "\ue0b1"


"Overriding the inactive statusline
function! Render_Only_File(...)
  let builder = a:1
  let context = a:2

  call builder.add_section('file', '!! %F')

  return 0   " the default: draw the rest of the statusline
  return -1  " do not modify the statusline
  return 1   " modify the statusline with the current contents of the builder
endfunction
call airline#add_inactive_statusline_func('Render_Only_File')


"Human readable Line number (with thousands separators)
function! MyLineNumber()
  return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). '|'.
    \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})

let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])


"Add the window number in front of the mode
function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')
"/
"/ NERDTree 
"/
"open a NERDTree automatically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd vimenter * NERDTree
nmap <C-n> :NERDTreeToggle<CR>

let NERDTreeHijackNetrw = 0
let NERDTreeMapOpenInTab='<c-t>'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


"/
"/ fzf 
"/
nmap <c-P> :Files<cr>
"nmap <c-R> :Buffers<cr>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'



"/
"/ Colorizer
"/
let g:colorizer_maxlines = 1000


"/
"/ Rainbow
"/

" :RainbowToggle	--you can use it to toggle this plugin.
let g:rainbow_active = 0



"/
"/ vim-search-pulse
"/
let g:vim_search_pulse_mode = 'pattern'
"let g:vim_search_pulse_color_list = [22, 28, 34, 40, 46]
"-------------------- Auto-Commands --------------------"
augroup autosourcing
    autocmd!
    autocmd BufWritePost vimrc source %
augroup END

