set nu rnu cul is hls ic scs sm smd et ts=2 sw=2 sts=2 ls=2 wim=longest:full,full | syntax on | colo pablo

nnoremap j gj
nnoremap k gk
noremap H ^
noremap L g_

" Move lines up and down (Fixed syntax)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
xnoremap <A-j> :m '>+1<CR>gv=gv
noremap <A-k> :m '<-2<CR>gv=gv

nnoremap <A-h> <<
nnoremap <A-l> >>
xnoremap <A-h> <gv
xnoremap <A-l> >gv

nnoremap <space>gv '[V']

" Searching
nnoremap / /\v
vnoremap / <Esc>/\%V
nnoremap <Esc> <cmd>nohl<CR>
