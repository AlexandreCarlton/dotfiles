-- vim:fdm=marker:

vim.cmd [[ runtime! plugin/python_setup.vim ]]

  -- Sensible defaults {{{

  -- Map leader to space
  vim.cmd [[ let mapleader=" " ]]

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

-- Install via git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- Run :PackerCompiler after _any_ change.
-- Run :PackerSync to update.
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- {{{ Optimisations
  -- Speeds up loading of lua modules.
  -- Must be at the beginning to cover as many plugins as possible.
  use { 'lewis6991/impatient.nvim',
    config = function()
      -- replace with require'impatient'.enable_profile() to access :LuaCacheProfile
      require'impatient'.enable_profile()
    end
  }
  --- }}}

  -- Languages (mainly Syntax) -- {{{

  -- Should provide _most_ of our syntax highlighting
  -- Anything else in this section is too esoteric.
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "bash",
          "cpp",
          "fish",
          "go",
          "java",
          "javascript",
          "json",
          "json5",
          "kotlin",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "proto",
          "python",
          "rust",
          "sql",
          "terraform",
          "typescript",
        },
        -- Install parsers in 'ensure_installed' synchronously (so we don't overload the machine)
        sync_install = true,
        highlight = {
          -- Enable syntax highlighting
          enable = true,
        }
      }
    end
  }

  -- Ansible
  use 'pearofducks/ansible-vim'

  -- i3
  use 'mboughaba/i3config.vim'

  -- Mediawiki
  use 'chikamichi/mediawiki.vim'

  -- Nginx
  use 'chr4/nginx.vim'

  -- }}}

  -- Completion {{{

  -- Autocompletion for quotes, parentheses, etc.
  use { 'raimondi/delimitMate', opt = true, event = 'InsertEnter' } --- {{{
  -- Turn on expansion of <Space>.
  vim.g.delimitMate_expand_cr = 1
  --- }}}

  -- End certain structures automatically
  use { 'tpope/vim-endwise', opt = true, event = 'InsertEnter' }

  -- LSP support
  use { 'neovim/nvim-lspconfig',  -- {{{
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      -- Add extra capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require'cmp_nvim_lsp'.default_capabilities(capabilities)
      require'lspconfig'.ccls.setup {}
      require'lspconfig'.efm.setup { filetypes = {"sh", "Dockerfile", "yaml"}, capbilities = capabilities }
      require'lspconfig'.gopls.setup { capbilities = capabilities }
      require'lspconfig'.pylsp.setup { cmd = { "pylsp" }, capbilities = capabilities }
      require'lspconfig'.tsserver.setup { capbilities = capabilities }
      require'lspconfig'.rust_analyzer.setup { settings = { ['rust-analyzer'] = {} } }
    end
  } -- }}}

  -- LSP progress to indicate why completions aren't yet active.
  use { 'j-hui/fidget.nvim',
   config = function()
     require'fidget'.setup{}
   end
  }

  -- Autocompletion (recommended by nvim-lspconfig)
  -- See https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  -- Note that this seems to disable teh default omnifunc.
  use { 'hrsh7th/nvim-cmp', --- {{{
    requires = {
      { 'hrsh7th/cmp-buffer' }, -- source for buffer words
      { 'hrsh7th/cmp-nvim-lua' }, -- source for neovim's Lua API
      { 'hrsh7th/cmp-nvim-lsp' }, -- source for neovim's LSP
      { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- source for displaying function signatures
      { 'hrsh7th/cmp-path' }, -- source for filesystem paths
    },
    opt = true,
    event = 'InsertEnter',
    config = function()
      require'cmp'.setup {
        mapping = {
          ['<Tab>'] = require'cmp'.mapping.select_next_item(),
          ['<S-Tab>'] = require'cmp'.mapping.select_prev_item(),
        },
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
        }
      }
    end
  } -- }}}

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
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require'trouble'.setup {
        -- No devicons for filenames
        icons = false,
        -- Use normal characters for fold
        fold_open = "v",
        fold_closed = ">",
        -- use signs from LSP client
        use_diagnostic_signs = true
      }
    end
  } -- }}}

  -- Nicer UI on top of LSP - keymapping is inspired by IntelliJ
  use { 'glepnir/lspsaga.nvim',
    branch = 'main',
    event = 'BufRead', -- Try 'LspAttach' in future as recommended in readme
    opt = true,
    config = function()
      require'lspsaga'.setup {
        symbol_in_winbar = {
          enable = false -- This provides a file/class/method at the top of the window.
        }
      }
    end,
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      -- Requires markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  }
  vim.cmd [[
    " alt-enter to prompt suggestions
    nnoremap <a-cr> :Lspsaga code_action<cr>
    " ctrl-] to find definition/references
    nnoremap <c-]> :Lspsaga lsp_finder<cr>
    " shift-k to consult docs
    nnoremap K :Lspsaga hover_doc<cr>
    " <space>r to rename
    nnoremap <Leader>r :Lspsaga rename<cr>
  ]]


  -- Create missing highlight LSP diagnostics groups for colourschemes that don't have them.
  use 'folke/lsp-colors.nvim'

  -- Display marks in the gutter
  use 'kshenoy/vim-signature'

  -- Display git diff in the gutter
  -- ]c / [c to jump between hunks
  use { 'lewis6991/gitsigns.nvim', -- {{{
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require'gitsigns'.setup {
        -- Copied wholesale from the gitsigns.nvim README.
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
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
        lualine_b = { {'filename', file_status = true, path = 1 } }, -- no branch (too verbose)
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

  -- Provide more options when dealing with swap files.
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
  use { 'tpope/vim-fugitive', opt = true, cmd = { 'Git', 'G' } }

  -- Shell commands
  use { 'tpope/vim-eunuch', opt = true, cmd = { 'Mkdir', 'SudoWrite', 'SudoEdit' } }

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
        pickers = {
          find_files = {
            -- No devicons for filenames
            disable_devicons = true,
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
