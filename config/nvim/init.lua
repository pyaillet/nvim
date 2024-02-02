-- Packer setup
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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
  use 'williamboman/mason.nvim'

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
  use 'simrat39/inlay-hints.nvim' 

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

  use 'iCyMind/NeoSolarized'
  
  if packer_bootstrap then
    require('packer').sync()
  end
end})

-- End packer setup

vim.opt.termguicolors = true
vim.cmd([[colorscheme NeoSolarized]])

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

require("inlay-hints").setup()

-- lsp_installer.on_server_ready(function(server)
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities.textDocument.completion.completionItem.snippetSupport = true
--     capabilities.textDocument.completion.completionItem.resolveSupport = {
--       properties = {
--         'documentation',
--         'detail',
--         'additionalTextEdits',
--       }
--     }
--     capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
-- 
--     capabilities.experimental = {}
--     capabilities.experimental.hoverActions = true
-- 
--     local opts = {
--       tools = {
--         autoSetHints = true,
--         hover_with_actions = true,
--         runnables = {
--           use_telescope = true
--         },
--         debuggables = {
--           use_telescope = true
--         },
--         inlay_hints = {
--           show_parameter_hints = true,
--           parameter_hints_prefix = "<< ",
--           other_hints_prefix  = ">> ",
--           highlight = "RustInlayHint",
--         },
-- 
--         hover_actions = {
--           border = {
--             {"╭", "FloatBorder"}, {"─", "FloatBorder"},
--             {"╮", "FloatBorder"}, {"│", "FloatBorder"},
--             {"╯", "FloatBorder"}, {"─", "FloatBorder"},
--             {"╰", "FloatBorder"}, {"│", "FloatBorder"}
--           },
--           -- whether the hover action window gets automatically focused
--           auto_focus = true
--         },
--         crate_graph = {
--           -- Backend used for displaying the graph
--           -- see: https://graphviz.org/docs/outputs/
--           -- default: x11
--           backend = "png",
--           -- where to store the output, nil for no output stored (relative
--           -- path from pwd)
--           -- default: nil
--           output = nil,
--           -- true for all crates.io and external crates, false only the local
--           -- crates
--           -- default: true
--           full = true,
--           -- enabled_graphviz_backends = {
--           --   "bmp", "cgimage", "canon", "dot", "gv", "xdot", "xdot1.2", "xdot1.4",
--           --   "eps", "exr", "fig", "gd", "gd2", "gif", "gtk", "ico", "cmap", "ismap",
--           --   "imap", "cmapx", "imap_np", "cmapx_np", "jpg", "jpeg", "jpe", "jp2",
--           --   "json", "json0", "dot_json", "xdot_json", "pdf", "pic", "pct", "pict",
--           --   "plain", "plain-ext", "png", "pov", "ps", "ps2", "psd", "sgi", "svg",
--           --   "svgz", "tga", "tiff", "tif", "tk", "vml", "vmlz", "wbmp", "webp", "xlib",
--           --   "x11"
--           -- }
--         }
--       },
--       server = { -- setup rust_analyzer
--         on_attach = lsp_on_attach,
--         capabilities = capabilities,
--         settings = {
--           -- to enable rust-analyzer settings visit:
--           -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--           ["rust-analyzer"] = {
--             -- enable clippy on save
--             checkOnSave = {
--               command = "clippy"
--             },
--           }
--         }
--       },
--       -- dap = {
--       --   adapter = {
--       --     type = 'executable',
--       --     command = 'lldb-vscode',
--       --     name = "rt_lldb"
--       --   }
--       -- }
--     }
-- 
--     if server.name == "rust_analyzer" then
--         -- Initialize the LSP via rust-tools instead
--         require("rust-tools").setup {
--             -- The "server" property provided in rust-tools setup function are the
--             -- settings rust-tools will provide to lspconfig during init.
--             -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
--             -- with the user's own settings (opts).
--             server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
--         }
--         server:attach_buffers()
--     else
--         server:setup(opts)
--     end
-- end)
-- setup rust-tools end

vim.g.mapleader = ','

-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
vim.keymap.set('n', 'gd', [[<cmd>lua vim.lsp.buf.definition()<CR>]], { noremap = true, silent = true })
-- nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
vim.keymap.set('n', 'ga', [[<cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true, silent = true })
-- nnoremap <silent>ff <cmd>lua vim.lsp.buf.formatting()<cr>
vim.keymap.set('n', 'ff', [[<cmd>lua vim.lsp.buf.format()<cr>]], { noremap = true, silent = true })
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

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.g.signcolumn = yes

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.g.updatetime = 300
-- Show diagnostic popup on cursor hover (Disabled because it's the same as
-- <leader>cd <leader>cc from lspsaga, we should choose between the two
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

-- Goto previous/next diagnostic warning/error
vim.keymap.set('n', 'g[', [[<cmd>lua vim.diagnostic.goto_prev()<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', 'g]', [[<cmd>lua vim.diagnostic.goto_next()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], { noremap = true })
vim.keymap.set('n', '<leader>fS', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]], { noremap = true })

require('gitsigns').setup()

require('hardline').setup {}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

local saga = require 'lspsaga'
saga.init_lsp_saga()

require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

vim.keymap.set('n', 'gh', [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ca', [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]], { noremap = true, silent = true })
vim.keymap.set('v', '<leader>ca', [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', 'K', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', 'gs', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', 'gr', [[<cmd>lua require('lspsaga.rename').rename()<CR>]], { noremap = true, silent = true })

-- vim.keymap.set('n', 'gd', [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>cd', [[<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>cc', [[<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '[e', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', ']e', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>t', [[<cmd>TroubleToggle<CR>]], { noremap = true, silent = true })

-- init.lua
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = {icon = "", hl = "TSURI"},
    Module = {icon = "", hl = "TSNamespace"},
    Namespace = {icon = "", hl = "TSNamespace"},
    Package = {icon = "", hl = "TSNamespace"},
    Class = {icon = "𝓒", hl = "TSType"},
    Method = {icon = "ƒ", hl = "TSMethod"},
    Property = {icon = "", hl = "TSMethod"},
    Field = {icon = "", hl = "TSField"},
    Constructor = {icon = "", hl = "TSConstructor"},
    Enum = {icon = "ℰ", hl = "TSType"},
    Interface = {icon = "ﰮ", hl = "TSType"},
    Function = {icon = "", hl = "TSFunction"},
    Variable = {icon = "", hl = "TSConstant"},
    Constant = {icon = "", hl = "TSConstant"},
    String = {icon = "𝓐", hl = "TSString"},
    Number = {icon = "#", hl = "TSNumber"},
    Boolean = {icon = "⊨", hl = "TSBoolean"},
    Array = {icon = "", hl = "TSConstant"},
    Object = {icon = "⦿", hl = "TSType"},
    Key = {icon = "🔐", hl = "TSType"},
    Null = {icon = "NULL", hl = "TSType"},
    EnumMember = {icon = "", hl = "TSField"},
    Struct = {icon = "𝓢", hl = "TSType"},
    Event = {icon = "🗲", hl = "TSType"},
    Operator = {icon = "+", hl = "TSOperator"},
    TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}

require("symbols-outline").setup()
require("fidget").setup{}

require("nvim-tree").setup()

require("mason").setup()

vim.cmd([[
set undofile
]])

local ih = require("inlay-hints")

require("rust-tools").setup({
  tools = {
    on_initialized = function()
      ih.set_all()
    end,
    inlay_hints = {
      auto = false,
    },
  },
  server = {
    on_attach = function(c, b)
      ih.on_attach(c, b)
    end,
  },
})
