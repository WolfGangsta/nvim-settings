" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


" Ack
packadd! ack.vim

" use with ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" C++ syntax
packadd! vim-cpp-enhanced-highlight

" tagbar
packadd! tagbar
nmap <F8> :TagbarToggle<CR>

" Gutentags
packadd! vim-gutentags

" NERDTree
map <tab> :NERDTreeToggle <CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Ctrl-P
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

let g:ctrlp_user_command = {
    \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f'
    \ }

autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'A',
                \ 'Untracked' :'U',
                \ 'Renamed'   :'R',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'D',
                \ 'Dirty'     :'*',
                \ 'Ignored'   :'!',
                \ 'Clean'     :'C',
                \ 'Unknown'   :'?',
                \ }

" Put these lines at the very end of your vimrc file.
let g:ale_fixers = {
 \ 'javascript': ['eslint'],
 \ 'css': ['stylelint'],
 \ 'sass': ['stylelint'],
 \ 'scss': ['stylelint'],
 \ }

let g:ale_fix_on_save = 1

" Clear ALE Buffer
" https://github.com/lericson/verktyg/blob/80afdcce09088c11bc1eace82d5f5c23753fe803/etc/vimrc#L322-L332
fun! ALEClearBuffer(buffer)
  if get(g:, 'ale_enabled') && has_key(get(g:, 'ale_buffer_info', {}), a:buffer)
    call ale#engine#SetResults(a:buffer, [])
    call ale#engine#Cleanup(a:buffer)
  endif
endfun

augroup UnALE
  autocmd!
  autocmd TextChanged,TextChangedI,InsertEnter,InsertLeave * call ALEClearBuffer(bufnr('%'))
augroup END

" https://github.com/dense-analysis/ale/issues/4255
let g:ale_echo_msg_format = '[%linter%] %s [%severity%:%code%]'

" For GitGutter--decreasing delay
set updatetime=100

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
