command W w

let g:neovide_cursor_animation_length = 0.0
let g:neovide_scroll_animation_length = 0.07

"set guifont=Cascadia\ Code:h12
"set guifont=Cascadia\ Code:h12
"set guifont=Liberation\ Mono:h12
"set guifont=Lucida\ Console:h14
"set guifont=Perfect\ DOS\ VGA\ 437\ Win:h19
"set guifont=Cascadia\ Code:h12
set guifont=Consolas:h12

set wrap
set clipboard=unnamedplus
set expandtab
set smartindent
set relativenumber
set autoindent
"set cursorline
set cindent
set tabstop=4
set shiftwidth=4
set cinoptions=(0,l1
set ignorecase
set smartcase
set guicursor=n-v-c-i:block
set nohlsearch
"let g:neovide_fullscreen=v:true

autocmd bufreadpre *.txt setlocal textwidth=64
"set textwidth=64

set omnifunc=complete#Complete
set tags=c:/dev/system_tags/system.tags,tags

noremap K k

imap <C-c> <ESC>

map <C-p> :vs<CR>
map <C-S-p> :q<CR>

"noremap <C-o> :call feedkeys(":e ")<CR>
"noremap <Space> :call feedkeys(":b ")<CR>

nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

noremap <C-e> zz
nnoremap <C-l> <C-w><C-w>
nnoremap gd <C-]>

nnoremap <F11> :let g:neovide_fullscreen = !get(g:, 'neovide_fullscreen', 0)<CR>

"noremap <C-s> :call feedkeys(":grep ")<CR>

noremap <F9> :e $MYVIMRC<CR>
noremap <C-F9> :e ~/AppData/Local/nvim/config.vim<CR>
noremap <F12> :source $MYVIMRC<CR>
noremap <C-Enter> :!tag<CR>

noremap <C-Space> :call feedkeys(":tag ")<CR>

noremap <A-m> :!build<CR>
