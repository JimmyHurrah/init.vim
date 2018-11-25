" https://codekoalas.com/blog/setting-neovim-javascript-development
" Install Vim Plug if not installed
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall
    endif 
    call plug#begin()

    "MUSIC
    Plug 'munshkr/vim-tidal' 

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'digitaltoad/vim-pug'
    Plug 'yegappan/mru'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'editorconfig/editorconfig-vim'
    Plug 'rking/ag.vim'
    Plug 'mhartington/oceanic-next'

    "Live feedback
    Plug 'metakirby5/codi.vim'
    
    "Dash 
    Plug 'rizzatti/dash.vim'

    "Javascript Plugins
    Plug 'pangloss/vim-javascript'
    Plug 'carlitux/deoplete-ternjs'
    Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

    "Prettier
    Plug 'w0rp/ale'
    let g:ale_fixers = {}
    let g:ale_linters = {}
    let g:ale_fixers['javascript'] = ['eslint'] ", 'prettier']
    let g:ale_linters['javascript'] = ['eslint']
    let g:ale_fix_on_save = 1
    let g:ale_javascript_eslint_use_local_config = 1
    "let g:ale_javascript_prettier_use_local_config = 1

    "GraphQL
    Plug 'jparise/vim-graphql'

    "JSX
    Plug 'mxw/vim-jsx'
    let g:jsx_ext_required = 0 "Handle .js files as well as .jsx

    "Typescript Plugins
    Plug 'mhartington/deoplete-typescript'
    Plug 'leafgarland/typescript-vim'
    Plug 'HerringtonDarkholme/yats.vim'

    call plug#end()

    let mapleader=","

    "Keybindings
    map <leader>p :FZF!<CR>
    map <leader>. :MRU<CR>
    "yank word into z register and search with silver searcher
    map <leader>f "zyiw:Ag <C-R>z<CR>
    "yank word into z register and search in Dash documentation
    map <leader>d "zyiw:Dash <C-R>z<CR>

    "filetree
    let g:netrw_browse_split = 3

    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_ignore_case = 1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#enable_camel_case = 1
    let g:deoplete#enable_refresh_always = 1
    let g:deoplete#max_abbr_width = 0
    let g:deoplete#max_menu_width = 0
    let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
    call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])

    let g:tern_request_timeout = 1
    let g:tern_request_timeout = 6000
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]
    let g:tern#arguments = ["--no-port-file"]
    let g:deoplete#sources#tss#javascript_support = 1
    let g:tsuquyomi_javascript_support = 1
    let g:tsuquyomi_auto_open = 1
    let g:tsuquyomi_disable_quickfix = 1

    if (has("termguicolors"))
	 set termguicolors
    endif

    " Theme
    syntax enable
    colorscheme OceanicNext

    set nowrap
