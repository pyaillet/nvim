-- Packer setup
local ensure_packer = function()
  local fn = vim.fn
  local install_path = '/usr/local/share/nvim/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup({function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'tami5/lspsaga.nvim'
  use 'williamboman/nvim-lsp-installer'

  -- Autocompletion framework
  use 'hrsh7th/nvim-cmp'

  -- cmp LSP completion
  use 'hrsh7th/cmp-nvim-lsp'

  -- cmp Snippet completion
  use 'hrsh7th/cmp-vsnip'

  -- cmp Path completion
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  -- See hrsh7th other plugins for more great completion sources!

  -- Adds extra functionality over rust analyzer
  use 'simrat39/rust-tools.nvim'

  use 'simrat39/symbols-outline.nvim'

  -- Snippet engine
  use 'hrsh7th/vim-vsnip'

  -- Optional
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter'

  use 'nvim-lua/lsp-status.nvim'
  use 'ojroques/nvim-hardline'
  use 'j-hui/fidget.nvim'

  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-surround'
  use 'folke/trouble.nvim'

  -- If you want to display icons, then use one of these plugins:
  use 'kyazdani42/nvim-web-devicons' -- lua
  use 'kyazdani42/nvim-tree.lua'

  use { 'iCyMind/NeoSolarized', run = ':colorscheme NeoSolarized' }
  
  if packer_bootstrap then
    require('packer').sync()
  end
end, config = {
  package_root = "/usr/local/share/nvim/site/pack",
}})

-- End packer setup

vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = menuone,noinsert,noselect

-- Avoid showing extra messages when using completion
table.insert(vim.opt.shortmess, "c")

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
-- setup rust-tools
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities
})

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})



local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  "gopls",
  "rust_analyzer",
  "yamlls",
  "vimls"
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }
    capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

    capabilities.experimental = {}
    capabilities.experimental.hoverActions = true

    local opts = {
      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
          use_telescope = true
        },
        debuggables = {
          use_telescope = true
        },
        inlay_hints = {
          show_parameter_hints = true,
          parameter_hints_prefix = "<< ",
          other_hints_prefix  = ">> ",
          highlight = "RustInlayHint",
        },

        hover_actions = {
          border = {
            {"╭", "FloatBorder"}, {"─", "FloatBorder"},
            {"╮", "FloatBorder"}, {"│", "FloatBorder"},
            {"╯", "FloatBorder"}, {"─", "FloatBorder"},
            {"╰", "FloatBorder"}, {"│", "FloatBorder"}
          },
          -- whether the hover action window gets automatically focused
          auto_focus = true
        },
        crate_graph = {
          -- Backend used for displaying the graph
          -- see: https://graphviz.org/docs/outputs/
          -- default: x11
          backend = "png",
          -- where to store the output, nil for no output stored (relative
          -- path from pwd)
          -- default: nil
          output = nil,
          -- true for all crates.io and external crates, false only the local
          -- crates
          -- default: true
          full = true,
          -- enabled_graphviz_backends = {
          --   "bmp", "cgimage", "canon", "dot", "gv", "xdot", "xdot1.2", "xdot1.4",
          --   "eps", "exr", "fig", "gd", "gd2", "gif", "gtk", "ico", "cmap", "ismap",
          --   "imap", "cmapx", "imap_np", "cmapx_np", "jpg", "jpeg", "jpe", "jp2",
          --   "json", "json0", "dot_json", "xdot_json", "pdf", "pic", "pct", "pict",
          --   "plain", "plain-ext", "png", "pov", "ps", "ps2", "psd", "sgi", "svg",
          --   "svgz", "tga", "tiff", "tif", "tk", "vml", "vmlz", "wbmp", "webp", "xlib",
          --   "x11"
          -- }
        }
      },
      server = { -- setup rust_analyzer
        on_attach = lsp_on_attach,
        capabilities = capabilities,
        settings = {
          -- to enable rust-analyzer settings visit:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
              command = "clippy"
            },
          }
        }
      },
      -- dap = {
      --   adapter = {
      --     type = 'executable',
      --     command = 'lldb-vscode',
      --     name = "rt_lldb"
      --   }
      -- }
    }

    if server.name == "rust_analyzer" then
        -- Initialize the LSP via rust-tools instead
        require("rust-tools").setup {
            -- The "server" property provided in rust-tools setup function are the
            -- settings rust-tools will provide to lspconfig during init.
            -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
            -- with the user's own settings (opts).
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
        }
        server:attach_buffers()
    else
        server:setup(opts)
    end
end)
-- setup rust-tools end

vim.g.mapleader = ','

-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
vim.keymap.set('n', 'gd', [[<cmd>lua vim.lsp.buf.definition()<CR>]], { noremap = true, silent = true })
-- nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
vim.keymap.set('n', 'ga', [[<cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true, silent = true })
-- nnoremap <silent>ff <cmd>lua vim.lsp.buf.formatting()<cr>
vim.keymap.set('n', 'ff', [[<cmd>lua vim.lsp.buf.formatting()<cr>]], { noremap = true, silent = true })
-- nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
vim.keymap.set('n', 'g[', [[<Cmd>lua vim.diagnostic.goto_prev()<CR>]], { noremap = true, silent = true })
-- nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>
vim.keymap.set('n', 'g]', [[<Cmd>lua vim.diagnostic.goto_next()<CR>]], { noremap = true, silent = true })

-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
vim.keymap.set('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true })
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
vim.keymap.set('n', '<leader>fg]', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true })
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
vim.keymap.set('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true })
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
vim.keymap.set('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true })

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

