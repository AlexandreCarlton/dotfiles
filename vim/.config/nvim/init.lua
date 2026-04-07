-- vim:fdm=marker:

-- Bootstrap lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- vim.cmd [[ runtime! plugin/python_setup.vim ]]

-- Sensible defaults - load before plugins {{{

-- Map leader to space
vim.g.mapleader=" "

-- Make searches case-insensitive, unless we have an upper-case character.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't highlight previous search results.
vim.o.hlsearch = false

-- Hide buffer when it is hidden.
vim.o.hidden = true

-- Highlight current row
vim.o.cursorline = true

-- Enable 24bit RGB golor in GUI.
vim.o.termguicolors = true
-- TODO: See if we can dynamically set this based on system theme.
-- We'd ideally alternate between light/dark depending on daylight/nighttime
vim.o.background = 'dark'

-- Save undo history to a file
vim.o.undofile = true

-- Straya
vim.o.spelllang = 'en_au'

-- Keymaps
vim.cmd [[
  " Rapidly press these keys (instead of Esc) to go Normal mode.
  inoremap jk <Esc>
  inoremap kj <Esc>

  " When wrapping is enabled, move down by row not by line.
  nnoremap j gj
  nnoremap k gk
]]

-- }}}

-- Use :Lazy to configure plugins
require('lazy').setup({ -- {{{

  spec = {
    { -- Color {{{
      'https://codeberg.org/lifepillar/vim-solarized8',
      -- we want this to load first on startup
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd.colorschem('solarized8')
      end
    }, --- }}}

    -- {{{ Languages
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',
      opts = {
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'css',
          'diff',
          'dockerfile',
          'fish',
          'gitcommit',
          'git_rebase',
          'go',
          'graphql',
          'java',
          'javascript',
          'json',
          'json5',
          'kotlin',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'proto',
          'python',
          'rust',
          'sql',
          'terraform',
          'typescript',
          'xml',
          'yaml'
        },
        -- Install parsers in 'ensure_installed' synchronously (so we don't overload the user's machine)
        sync_install = true,
        highlight = {
          enable = true
        }
      }
    },
    -- }}}

    -- Completion {{{
    { -- Automatically complete opening parentheses/quotes/etc.
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
    },
    { -- Provides configuration for LSP servers which can be easily hooked up to in a completion engine
      'neovim/nvim-lspconfig',
      event = 'BufRead',
      config = function()
        -- Enable LSPs here
        vim.lsp.enable('ruff') -- Python
      end
    },
    { -- Actual completion engine
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        -- These are the varioues sources nvim-cmp can use.
        'hrsh7th/cmp-buffer', -- buffer words
        'hrsh7th/cmp-nvim-lua', -- neovim's Lua API
        'hrsh7th/cmp-nvim-lsp', -- neovim's LSP
        'hrsh7th/cmp-nvim-lsp-signature-help', -- displays function signatures
        'hrsh7th/cmp-path', -- filesystem paths
      },
      opts = function()
        -- Register cmp-nvim-lsp's capabilities to all LSP configs from nvim-lspconfig
        vim.lsp.config("*", { capabilities = require'cmp_nvim_lsp'.default_capabilities() })
        local cmp = require'cmp'

        return {
          mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
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
    },
    { -- Shows LSP loading progress in the bottom-right corner
      'j-hui/fidget.nvim',
    },
    -- }}}

    -- {{{ Eye candy
    { -- Status line
      'nvim-lualine/lualine.nvim',
       lazy = false,
       opts = {
         options = {
           theme = 'solarized',
           section_separators = {'', ''},
           component_separators = {'|', '|'},
           icons_enabled = false,
         },
         sections = {
             lualine_a = { function() return string.sub(require('lualine.utils.mode').get_mode(), 1, 1) end },
             lualine_b = { {'filename', file_status = true, path = 1 } }, -- no branch (too verbose)
             lualine_c = {'diff'},
             lualine_x = {'encoding', 'fileformat', 'filetype'},
             lualine_y = {'progress'},
             lualine_z = {'location'}
         },
       }
    },
    { -- Buffer list that live in the tab line
      'ap/vim-buftabline',
      lazy = false,
      config = function()
       vim.g.buftabline_numbers = 1 -- Show numbers in label
       vim.g.buftabline_indicators = 1 -- Show buffer state in label
      end
    },
    { -- Sane number toggling (Normal = relative, Insert = absolute)
      'myusuf3/numbers.vim',
      config = function()
        vim.o.number = true
        vim.g.numbers_exclude = {'undotree'}
      end
    },
    -- }}}

    -- {{{ Git
    { 'lewis6991/gitsigns.nvim', -- Show/stage/unstage hunks in the gutter, and :G <cmd> (e.g. blame)
      dependencies = { 'nvim-lua/plenary.nvim' },
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
    },
    --- }}}

    -- {{{ Useful commands
    { -- Load the undo tree
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      init = function()
        vim.cmd [[ nnoremap <Leader>ud :UndotreeToggle<cr> ]]
      end
    },
    { -- Profile vim startup
      'tweekmonster/startuptime.vim',
      cmd = {'StartupTime'}
    },
    -- }}}

    -- {{{ Key mappings
    {
      'kylechui/nvim-surround' -- modify surroundings in pairs, e.g. "{...}" => "(...)"
    },
    {  -- EditorConfig
      'editorconfig/editorconfig-vim',
      config = function()
        vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'tarfile::.*'}
        vim.g.EditorConfig_max_line_indictor = 'line'
        vim.g.EditorConfig_core_mode = 'external_command'
        vim.g.EditorConfig_exec_path = '/usr/bin/editorconfig'
      end
    },
    -- }}}

    -- {{{ Menus
    {
      'folke/trouble.nvim', -- Get a nice loclist
       cmd = 'Trouble',
       --enabled = false, -- Behaving weirdly..
       opts = {
         -- No devicons for filenames
         icons = false,
         -- Use normal characters for fold
         fold_open = "v",
         fold_closed = ">",
         -- use signs from LSP client
         use_diagnostic_signs = true
       },
       keys = {
         {
           '<leader>xx',
           '<cmd>Trouble diagnostics toggle<cr>',
           desc = 'Diagnostics (Trouble)'
         },
         -- More are provided in the readme
       }
    },
    {
      'nvim-telescope/telescope.nvim', -- Nice pop up window (e.g. for finding files)
      dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
        'folke/trouble.nvim',
      },
      opts = {
        defaults = {
          mappings = {
            -- TODO: Get this working again.
            -- Ctrl-T will open the search results in trouble.
            -- i = { ["<c-t>"] = require'trouble.sources.telescope'.open },
            -- n = { ["<c-t>"] = require'trouble.sources.telescope'.open },
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
      },
      keys = {
        {
          '<leader>ff',
          '<cmd>Telescope find_files<cr>',
          desc = "Find files (Telescope)"
        },
        {
          '<leader>fg',
          '<cmd>Telescope live_grep<cr>',
          desc = "Grep (Telescope)"
        },
        {
          '<leader>fb',
          '<cmd>Telescope buffers<cr>',
          desc = "Buffers (Telescope)"
        },
      },
    },
  },
  --- }}}

  -- Automatically check plugin updates.
  checker = { enabled = true }
}) -- }}}
