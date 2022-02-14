""""""""
" BASE "
""""""""
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent
set relativenumber nu
set nowrap
set hidden
set noerrorbells
set undodir=~/.vim/undodir undofile noswapfile nobackup  
set scrolloff=4 sidescrolloff=20
set termguicolors
set colorcolumn=80
if (has("termguicolors"))
 set termguicolors
endif
set completeopt=menu,menuone,noselect

"""""""""""
" PLUGINS "
"""""""""""
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif 
call plug#begin()
  Plug 'BurntSushi/ripgrep' " brew install ripgrep
  Plug 'editorconfig/editorconfig-vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Completion
  Plug 'hrsh7th/nvim-cmp' "autocomplete
  Plug 'hrsh7th/cmp-buffer' "complete words from opened files
  Plug 'hrsh7th/cmp-path' "complete file paths 
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " Color
  Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

lua <<EOF

local telescope = require('telescope')
telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { height = 0.95 },
    find_command = 'rg',
    preview = {
      treesitter = false
    }
  },
})

telescope.load_extension "fzf"

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

  -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local omnisharp_bin = "/Users/jimmyhurrah/Documents/omnisharp-osx-x64-net6.0/OmniSharp"
local pid = vim.fn.getpid()

require'lspconfig'.omnisharp.setup{
  -- find <omnisharp> | xargs xattr -r -d com.apple.quarantine
  cmd = { omnisharp_bin, "-lsp", "-hpid", tostring(pid) };
  capabilities = capabilities
}
EOF

colorscheme dracula

let mapleader=","
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>fe :Vexplore<CR>
