let g:user42 = 'zlee'
let g:mail42 = 'zlee@student.42kl.edu.my'

" Enable mouse support
set mouse=a

" Set tab size and enable line numbers
set tabstop=4
set nu
syntax on
set ruler
filetype indent on
set cursorline
" Keep 8 lines visible when scrolling
set scrolloff=8

" Set leader key to space
let mapleader = "\<Space>"

" Enable incremental search
set incsearch

" Disable custom GUI cursor behavior (Vim doesn't support `guicursor`)
" Use Vim defaults here, no need to set

" Move selected visual block up and down
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

" Join lines and keep cursor position
nnoremap J mzJ`z

" Half-page jump with cursor centered
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep search terms centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Better paste in visual mode
xnoremap <leader>p "_dP

" Copy to system clipboard
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>Y "+Y

" Disable swapfile and enable persistent undo
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Use Ctrl+C to exit insert mode
inoremap <C-c> <Esc>

" Find and replace with word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Split screen shortcuts
nnoremap <leader>ss :split<CR>
nnoremap <leader>sv :vsplit<CR>

" Navigate between split screens
nnoremap <leader><Left> <C-w>h
nnoremap <leader><Down> <C-w>j
nnoremap <leader><Up> <C-w>k
nnoremap <leader><Right> <C-w>l

" Delete a word backwards
nnoremap dw vb_d

" Enable statusline
set laststatus=2

" Define colors based on Rose Pine theme (corrected)
hi User1 guifg=#191724 guibg=#ebbcba ctermfg=234 ctermbg=217 " Base on Rose (mode)
hi User2 guifg=#e0def4 guibg=#26233a ctermfg=189 ctermbg=235 " Text on Surface (filename)
hi User3 guifg=#9ccfd8 guibg=#1f1d2e ctermfg=152 ctermbg=234 " Foam on Base (git branch)
hi User4 guifg=#f6c177 guibg=#1f1d2e ctermfg=222 ctermbg=234 " Gold on Base (filetype)
hi User5 guifg=#e0def4 guibg=#1f1d2e ctermfg=189 ctermbg=234 " Text on Base (separator)
hi User6 guifg=#191724 guibg=#9ccfd8 ctermfg=234 ctermbg=152 " Base on Foam (cursor position)
hi User7 guifg=#9ccfd8 guibg=#1f1d2e ctermfg=152 ctermbg=234 " Foam on Base (separator)
hi User8 guifg=#e0def4 guibg=#1f1d2e ctermfg=189 ctermbg=234 " Text on Base (percentage)

" Powerline symbols
let g:powerline_symbols = {
    \ 'arrow'   : '',
    \ 'divider' : '',
\ }

" Filename function
function! StatuslineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" Mode function
function! StatuslineMode()
    let l:mode = mode()
    if l:mode ==# "n"
        return "NORMAL"
    elseif l:mode ==# "i"
        return "INSERT"
    elseif l:mode ==# "v"
        return "VISUAL"
    elseif l:mode ==# "V"
        return "V-LINE"
    elseif l:mode ==# "\<C-v>"
        return "V-BLOCK"
    elseif l:mode ==# "R"
        return "REPLACE"
    elseif l:mode ==# "c"
        return "COMMAND"
    endif
    return l:mode
endfunction

" Git branch function (without plugin)
function! StatuslineGitBranch()
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? ' '.l:branchname : ''
endfunction

" Filetype function
function! StatuslineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

" Cursor position function
function! StatuslineCursorPosition()
    return 'Ln ' . line('.') . ', Col ' . col('.')
endfunction

" Set statusline
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\
set statusline+=%2*%{g:powerline_symbols.arrow}
set statusline+=%2*\ %{StatuslineFilename()}\
set statusline+=%3*%{g:powerline_symbols.arrow}
set statusline+=%3*%{StatuslineGitBranch()}\
set statusline+=%4*%{g:powerline_symbols.arrow}
set statusline+=%4*\ %{StatuslineFiletype()}\
set statusline+=%5*%{g:powerline_symbols.arrow}
set statusline+=%=%7*%{g:powerline_symbols.arrow}
set statusline+=%6*\ %{StatuslineCursorPosition()}\
set statusline+=%7*%{g:powerline_symbols.arrow}
set statusline+=%8*\ %3p%%\

" Optional: Set the background to dark for better contrast
set background=dark

