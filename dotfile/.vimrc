set guifont=Consolas::h11:cANSI

set smartindent
set autoindent
set cindent

set nocompatible
syntax enable
filetype plugin on
filetype indent on

if has("syntax")
 syntax on
endif

" The following are commented out as they cause vim to behave a lot
set showcmd        " Show (partial) command in status line.
set showmatch        " Show matching brackets.
set ignorecase        " Do case insensitive matching
set smartcase        " Do smart case matching
set incsearch        " Incremental search
set autowrite        " Automatically save before command like :next and :make
set hlsearch
set showtabline=2  " always tabs visible
" set mouse=a        " Enable mouse usage (all modes)

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python,R let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <C-c> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR> :nohlsearch<CR>
noremap <silent> <C-x> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR> :nohlsearch<CR>

:ab #b #############################################################################
:ab #l #----------------------------------------------------------------------------

:imap jj <ESC>
:vmap vv <ESC>
:nmap qq :q!<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lasttab = 1
autocmd TabLeave * let g:lasttab = tabpagenr()
nmap ff :exe "tabn ".g:lasttab<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto header
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd bufnewfile *.R so ~/r_header_takeda.txt
autocmd Bufwritepre,filewritepre *.R execute "normal ma"
autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "10" . "g/Program:.*/s/Program:.*/Program:\t".expand("%")
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Programmer.*/s/Programmer.*/Programmer\\/Date:\tShuaicheng (Freeman) Wang \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tLaura B. Gillis \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tBrigid M. Wilson \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tLin Li \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tFang Chen \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\t \\/ ".strftime("%b %d, %Y")

autocmd bufwritepost,filewritepost *.R execute "normal `a"
" below only for Takeda Vortioxetione project
"autocmd bufwritepost,filewritepost *.R,*.sh exe "!sed -f sed.txt -i ".expand("%")<CR>
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Client.*/s/Client.*/Client:\tTakeda"
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "$" . "g/^#\\+\\s\\+Project.*/s/Project.*/Project:\tVortioxetione 2013"
":nmap er :g/#\\+Programmer\/Date*/s/Programmer.Date.*/Programmer\/Date:\tShuaicheng (Freeman) Wang \/ <CR>A<C-R>=strftime("%b %d, %Y")<CR><ESC>
"
" below is only for GBCF CGS
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "50" . "s@Basedir:.*@Basedir:\t\\lillyce\\prd\\ly2189265\\h9x_mc_gbcf\\pgx3\\@"
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "50" . "g/Location:.*/s/Location:.*/Location:\t[basedir]programs_nonsdd\\"
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "50" . "g/Input:.*/s/Input:.*/Input:\t[basedir]data\\shared\\custom\\"
"autocmd bufnewfile,Bufwritepre *.R,*.sh exe "1," . "50" . "g/Output:.*/s/Output:.*/Output:\t[basedir]data\\shared\\custom\\"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" grep i/o files in R script
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:noremap <C-i> :!~/grep_io_files.sh % <CR><CR>:vsp ~/tmp_io_file.R<CR><C-w>R<ESC>
so ~/.vim/word_complete.vim
":call DoWordComplete()  "to stop the funciton:call EndWordComplete()
"so ~/.vim/underS.vim

autocmd FileType r,rnoweb set tags+=~/.vim/RTAGS,~/.vim/RsrcTags

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project vimrc file. To be sourced each time you open any file in this
" repository. You may use [vimscript #3393][1] [(homepage)][2] to do this
" automatically.
"
" [1]: http://www.vim.org/scripts/script.php?script_id=3393
" [2]: https://github.com/thinca/vim-localrc
"setlocal noexpandtab
" Despite promise somewhere alignment is done only using tabs. Thus setting
" &tabstop is a requirement.
"setlocal tabstop=4
"let g:syntastic_python_flake8_args = '--ignore=W191,E501,E121,E122,E123,E128,E225,W291,E126'
"let b:syntastic_checkers = ['flake8']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set cmdheight=2
set display=uhex
set completeopt=menu
set noexpandtab
set history=1000
"set list listchars=trail:-,extends:>,precedes:<
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set ffs=unix

"no <down> ddp
no <left> <Nop>
no <right> <Nop>
"no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>


"============== Color Settings ===============
color wombat256
"color xterm16
"color railscasts
"color molokai
"color skittles_dark

nmap <C-j> :tabnext<CR>
nmap <C-k> :tabprevious<CR>
nmap <C-n> :tabnew
imap <C-k> <ESC>:tabprevious<CR>
imap <C-j> <ESC>:tabnext<CR>
imap <C-n> <ESC>:tabnew
noremap <F7> :set expandtab!<CR>


"I really hate that things don't auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" delete surrounding characters
noremap ss{ F{xf}x
noremap cs{ F{xf}xi
noremap ss" F"x,x
noremap cs" F"x,xi
noremap ss' F'x,x
noremap cs' F'x,xi
noremap ss( F(xf)x
noremap cs( F(xf)xi
noremap ss) F(xf)x
noremap cs) F(xf)xi

nmap cu ct_
nmap cU cf_

"quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i

"quick quote
nmap w' ciw'<C-r>"'<ESC>
nmap w" ciw"<C-r>""<ESC>

let mapleader='\'
"if exists('$TMUX')
  "let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
  "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif
"let g:Powerline_symbols = 'fancy'
"call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
