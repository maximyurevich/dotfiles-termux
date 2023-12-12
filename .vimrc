set encoding=utf-8
scriptencoding utf-8
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent
set hlsearch
set incsearch
set undofile
set noswapfile
set number
set relativenumber
setlocal tagfunc=lsp#lsp#TagFunc
setlocal formatexpr=lsp#lsp#FormatExpr()

call plug#begin()

Plug 'andlrc/lsp', { 'branch': 'sig-params-label-uint-uint' }

Plug 'mattn/vim-lsp-settings'
Plug 'normen/vim-lsp-settings-adapter'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'leafOfTree/vim-vue-plugin'
Plug 'thinca/vim-quickrun'

Plug 'metakirby5/codi.vim'

Plug 'https://tpope.io/vim/eunuch.git'
Plug 'https://tpope.io/vim/endwise.git'

Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'editorconfig/editorconfig-vim'

Plug 'tomtom/tcomment_vim'

Plug 'svermeulen/vim-cutlass'

Plug 'svermeulen/vim-yoink'

Plug 'justinmk/vim-sneak'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'mbbill/undotree'

call plug#end()

if executable('pyright-langserver')
    silent! call lsp#lsp#AddServer([{
        \   'name': 'pyright',
        \   'filetype': 'python',
        \   'path': 'pyright-langserver',
        \   'args': ['--stdio'],
        \   'workspaceConfig': {
        \       'python': {
        \           'typeCheckingMode': v:false,
        \           'diagnosticMode': 'openFilesOnly'
        \       }
        \   },
        \   'runIfSearch': ['pyproject.toml', 'requirements.txt', 'pyrightconfig.json']
        \ }])
endif

augroup lsp_options
    autocmd VimEnter * silent! call LspOptionsSet({
        \   'autoComplete': v:true,
        \   'autoHiglight': v:false,
        \   'autoHigightDiags': v:true,
        \   'autoPopulateDiags': v:false,
        \   'completionMatcher': 'case',
        \   'completionTextEdit': v:true,
        \   'customCompletionKinds': v:true,
        \   'diagVirtualTextAlign': 'after',
        \   'echoSignature': v:false,
        \   'hideDisabledCodeActions': v:false,
        \   'higightDiagInline': v:true,
        \   'hoverInPreview': v:false,
        \   'ignoreMissingServer': v:true,
        \   'keepFocusInReferences': v:false,
        \   'noNewlineInCompletion': v:true,
        \   'outlineOnRight': v:true,
        \   'outlineWinSize': 40,
        \   'showDiagInBalloon': v:true,
        \   'showDiagInPopup': v:true,
        \   'showDiagOnStatusLine': v:false,
        \   'showDiagWithSign': v:true,
        \   'showDiagWithVirtualText': v:true,
        \   'showInlayHints': v:false,
        \   'showSignature': v:true,
        \   'snippetSupport': v:true,
        \   'vsnipSupport': v:true,
        \   'usePopupInCodeAction': v:false,
        \   'useQuickfixForLocations': v:false,
        \   'useBufferCompletion': v:true,
        \ })
augroup END

function! s:on_lsp_buffer_attached() abort
    nmap <buffer> ca :LspCodeAction<CR>
    vmap <buffer> ca :LspCodeAction<CR>
    nmap <buffer> gr :LspRename<CR>
    nmap <buffer> gp :LspPeekDefinition<CR>
    nmap <buffer> gd :LspGotoDefinition<CR>
    nmap <buffer> <space>wa :LspWorkspaceAddFolder<CR>
    nmap <buffer> <space>wr :LspWorkspaceRemoveFolder<CR>
    nmap <buffer> <space>wl :LspWorkspaceListFolders<CR>
    nmap <buffer> gi :LspGotoImpl<CR>
    nmap <buffer> gT :LspGotoTypeDefinition<CR>
    nmap <buffer> gt :LspPeekTypeDefinition<CR>
    nmap <buffer> sl :LspDiagCurrent<CR>
    nmap <buffer> sb :LspDiagFirst<CR>
    nmap <buffer> sc :LspDiagHere<CR>
    nmap <buffer> [g :LspDiagPrev<CR>
    nmap <buffer> ]g :LspDiagNext<CR>
    nmap <buffer> [d :LspDiagLast<CR>
    nmap <buffer> ]d :LspDiagFirst<CR>
    nmap <buffer> <space>q :LspDiagShow<CR>
    nmap <buffer> K :LspHover<CR>
    nmap <buffer> <leader>o :LspOutline<CR>
    nmap <buffer> <leader>ci :LspIncomingCalls<CR>
    nmap <buffer> <leader>co :LspOutgoingCalls<CR>

    augroup lsp_format
      autocmd! BufWritePre *.py,*.sh,*.svelte,*.toml,*.vue,*.rb,*.html,*.json,*.yaml,*.lua,*.css,*.js,*.jsx,*.ts,*.tsx,*.rs,*.go,*.dart,*.md,*.c,*.cpp :LspFormat
    augroup END
endfunction

augroup lsp_attach
    au!
    autocmd User LspAttached call s:on_lsp_buffer_attached()
augroup END

 augroup LspCustom
	au!
	au CursorMoved * silent! LspDiag! current
 augroup END

" Cutlass

nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

" Yoink

let g:yoinkIncludeDeleteOperations = 1

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)

