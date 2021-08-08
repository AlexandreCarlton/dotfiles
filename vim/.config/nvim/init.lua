-- vim:fdm=marker:

vim.cmd [[ runtime! plugin/python_setup.vim ]]

-- Install via git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- Run :PackerCompiler after _any_ change.
-- Run :PackerSync to update.
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- When neovim 0.6 arrives we should move to treesitter
  -- See https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  -- Languages (mainly Syntax) -- {{{

  -- Ansible
  use 'pearofducks/ansible-vim'

  -- C / C++
  use 'octol/vim-cpp-enhanced-highlight'

  -- Docker
  use 'ekalinin/Dockerfile.vim'

  -- Fish
  use 'dag/vim-fish'

  -- Git (syntax highlighting messages)
  use 'tpope/vim-git'
  vim.cmd 'autocmd Filetype gitcommit set spell'

  -- i3
  use 'mboughaba/i3config.vim'

  -- JavaScript
  use 'pangloss/vim-javascript'

  -- JSON5 (json but allows comments)
  use 'gutenye/json5.vim'

  -- Kotlin
  use 'udalov/kotlin-vim'

  -- Markdown
  use 'plasticboy/vim-markdown' -- {{{
  vim.g.vim_markdown_folding_disabled=1
  -- Set relevant files with markdown extensions to be MarkDown.
  -- vim.call "au BufNewFile,BufRead *.md,*.mkd set filetype=markdown"
  -- Spell check markdown files.
  -- vim.call "autocmd FileType markdown set spell"
  -- }}}

  -- Mediawiki
  use 'chikamichi/mediawiki.vim'

  -- Nginx
  use 'chr4/nginx.vim'

  -- Python PEP-8 indenting
  use 'hynek/vim-python-pep8-indent'

  -- Rust
  use 'rust-lang/rust.vim'

  -- Terraform
  use 'hashivim/vim-terraform'

  -- Typescript
  use 'leafgarland/typescript-vim'

  -- }}}

  -- Completion {{{

  -- Autocompleteion for quotes, parentheses, etc.
  use { 'raimondi/delimitMate', opt = true, event = 'InsertEnter' } --- {{{
  -- Turn on expansion of <Space>.
  vim.g.delimitMate_expand_cr = 1
  --- }}}

  -- End certain structures automatically
  use { 'tpope/vim-endwise', opt = true, event = 'InsertEnter' }

  -- LSP support
  use { 'neovim/nvim-lspconfig',  -- {{{
    config = function()
      require'lspconfig'.efm.setup { filetypes = {"sh", "Dockerfile", "yaml"} }
      require'lspconfig'.pylsp.setup { cmd = { "pyls" } }
    end
  } -- }}}

  -- Autocompletion (recommended by nvim-lspconfig)
  use { 'hrsh7th/nvim-compe', --- {{{
    opt = true,
    event = 'InsertEnter',
    requires = {'neovim/nvim-lspconfig'},
    config = function()
      vim.o.completeopt = "menuone,noselect"
      require'compe'.setup {
        source = {
          path = true,
          buffer = true,
          nvim_lsp = true,
          nvim_lua = true,
        }
      }
      -- (S-)Tab to cycle through suggestions
      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      local check_back_space = function()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
      end
      _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-n>"
        elseif check_back_space() then
          return t "<Tab>"
        else
          return vim.fn['compe#complete']()
        end
      end
      _G.s_tab_complete = function()
        return vim.fn.pumvisible() == 1 and t "<C-p>" or t "<S-Tab>"
      end
      vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    end
  } -- }}}

  -- }}}

  -- Sane defaults {{{
  -- Make searches case-insensitive, unless we have an upper-case character.
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Don't highlight previous search results.
  vim.o.hlsearch = false

  -- Hide buffer when it is hidden.
  vim.o.hidden = true

  -- Highlight current row
  vim.o.cursorline = true

  -- Straya
  vim.o.spelllang = 'en_au'
  -- }}}

  -- UI {{{
  -- Solarized colorscheme
  use 'lifepillar/vim-solarized8' -- {{{
  vim.o.termguicolors = true
  vim.o.background = 'dark'
  vim.cmd [[ colorscheme solarized8 ]]
  -- }}}

  -- Show disagnostics in loclist
  use { 'folke/trouble.nvim', -- {{{
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require'trouble'.setup {
        icons = false
      }
    end
  } -- }}}

  -- Create missing highlight LSP diagnostics groups for colourschemes that don't have them.
  use 'folke/lsp-colors.nvim'

  -- Display marks in the gutter
  use 'kshenoy/vim-signature'

  -- Display git diff in the gutter
  -- ]c / [c to jump between hunks
  use { 'lewis6991/gitsigns.nvim', -- {{{
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require'gitsigns'.setup {}
    end
  } -- }}}

  -- Intelligent number toggling
  use 'myusuf3/numbers.vim' -- {{{
  -- Odd things happen without this
  vim.o.number = true
  vim.g.numbers_exclude = {'undotree'}
  -- }}}

  -- Better buffertab
  use 'ap/vim-buftabline' -- {{{
  vim.g.buftabline_numbers = 1 -- Show numbers in label
  vim.g.buftabline_indicators = 1 -- Show buffer state in label
  --- }}}

  -- Statusline
  use 'hoob3rt/lualine.nvim' -- {{{
  local function short_mode()
    return string.sub(require('lualine.utils.mode').get_mode(), 1, 1)
  end
  require'lualine'.setup {
    options = {
      theme = 'solarized_dark',
      section_separators = {'', ''},
      component_separators = {'|', '|'},
      icons_enabled = false,
    },
    sections = {
        lualine_a = {short_mode},
        lualine_b = {'filename'}, -- no branch (too verbose)
        lualine_c = {'diff'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
  }
  -- }}}

  -- }}}

  -- Recovery {{{
  vim.o.undofile = true

  -- Look at the undo tree
  use { 'mbbill/undotree', opt = true, cmd = 'UndotreeToggle' }
  vim.cmd [[ nnoremap <Leader>ud :UndotreeToggle<cr> ]]

  -- Provide more options when dealin with swap files.
  use 'chrisbra/recover.vim'

  -- }}}

  -- Misc {{{

  use 'editorconfig/editorconfig-vim' -- {{{
  vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'tarfile::.*'}
  vim.g.EditorConfig_max_line_indictor = 'line'
  vim.g.EditorConfig_core_mode = 'external_command'
  vim.g.EditorConfig_exec_path = '/usr/bin/editorconfig'
  -- }}}

  -- }}}

  -- Key mappings {{{
  vim.cmd [[ let mapleader=" " ]]

  -- gcc to toggle comments
  use 'tpope/vim-commentary'

  -- Changing surroundings in pairs
  use 'tpope/vim-surround'

  -- Nicer mappeings using ] / [ for 'next' / 'previous'
  -- e.g. ]b for next buffer
  use 'tpope/vim-unimpaired'

  vim.cmd [[
    " Rapidly press these keys (instead of Esc) to go Normal mode.
    inoremap jk <Esc>
    inoremap kj <Esc>

    " When wrapping is enabled, move down by row not by line.
    nnoremap j gj
    nnoremap k gk
  ]]
  -- }}}

  -- Command-invoked {{{

  -- Git
  use 'tpope/vim-fugitive'

  -- Shell commands
  use { 'tpope/vim-eunuch', opt = true, cmd= { 'Mkdir', 'SudoWrite', 'SudoEdit' } }

  -- Run things in tmux pane
  use { 'tpope/vim-dispatch', opt = true, cmd = { 'Make', 'Dispatch', 'Start' } }

  -- Profile vim startup if it gets slow.
  use { 'tweekmonster/startuptime.vim', opt = true, cmd = {'StartupTime'} }
  -- }}}

  -- Navigation {{{
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'folke/trouble.nvim' }
    },
    config = function()
      require'telescope'.setup {
        defaults = {
          mappings = {
            -- Ctrl-T will open the search results in trouble.
            i = { ["<c-t>"] = require'trouble.providers.telescope'.open_with_trouble },
            n = { ["<c-t>"] = require'trouble.providers.telescope'.open_with_trouble },
          }
        },
        extensions = {
          -- Use telescope's C implementation of fzf
          fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }
      -- Requried to load fzf and have it work with telescope.
      require'telescope'.load_extension'fzf'
    end
  }
  vim.cmd [[
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
  ]]
  -- }}}

end)
