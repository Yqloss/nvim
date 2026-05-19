local snippets = {
}

vim.pack.add {
  'https://github.com/catppuccin/nvim',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.comment',
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.keymap',
  'https://github.com/nvim-mini/mini.move',
  'https://github.com/nvim-mini/mini.operators',
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.snippets',
  'https://github.com/nvim-mini/mini.splitjoin',
  'https://github.com/nvim-mini/mini.surround',
  'https://github.com/nvim-mini/mini.basics',
  'https://github.com/nvim-mini/mini.bracketed',
  'https://github.com/nvim-mini/mini.diff',
  'https://github.com/nvim-mini/mini.files',
  'https://github.com/nvim-mini/mini.jump',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/nvim-mini/mini.cursorword',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.indentscope',
  'https://github.com/nvim-mini/mini.trailspace',
  'https://github.com/nvim-mini/mini.statusline',
  'https://github.com/nvim-mini/mini.hipatterns',
  'https://github.com/nvim-mini/mini.sessions',
  'https://codeberg.org/andyg/leap.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'http://github.com/mbbill/undotree',
  'https://github.com/akinsho/toggleterm.nvim',
}

require 'vim._core.ui2'.enable {}

require 'mini.ai'.setup()

require 'mini.comment'.setup {
  mappings = {
    comment_line = '_',
    comment_visual = '_',
    textobject = '_',
  }
}

require 'mini.completion'.setup()
require 'mini.keymap'.setup()

require 'mini.move'.setup {
  mappings = {
    left = '<left>',
    right = '<right>',
    down = '<down>',
    up = '<up>',
    line_left = '<left>',
    line_right = '<right>',
    line_down = '<down>',
    line_up = '<up>',
  }
}

require 'mini.operators'.setup {
  replace = {
    prefix = ''
  }
}

require 'mini.pairs'.setup()

require 'mini.snippets'.setup {
  snippets = snippets,
  mappings = {
    expand = 'S',
    jump_prev = 'H',
    jump_next = 'L',
    stop = '<c-c>',
  }
}

require 'mini.splitjoin'.setup {
  mappings = {
    toggle = 'zx'
  }
}

require 'mini.surround'.setup {
  mappings = {
    highlight = 'ss'
  }
}

require 'mini.basics'.setup {
  options = {
    basic = false,
    extra_ui = false,
    win_borders = 'auto',
  },
  mappings = {
    basic = false,
    option_toggle_prefix = '',
    windows = true,
    move_with_alt = false,
  }
}

require 'mini.bracketed'.setup()
require 'mini.diff'.setup()
require 'mini.files'.setup()
require 'mini.jump'.setup()
require 'mini.pick'.setup()
require 'mini.cursorword'.setup()
require 'mini.icons'.setup()

require 'mini.indentscope'.setup {
  symbol = '▏'
}

require 'mini.trailspace'.setup()
require 'mini.statusline'.setup()

require 'mini.hipatterns'.setup {
  highlighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = require 'mini.hipatterns'.gen_highlighter.hex_color(),
  },
}

require 'mini.sessions'.setup()

require 'toggleterm'.setup {
  open_mapping = '<c-`>',
  direction = 'float'
}

require 'leap'.setup {
  safe_labels = '',
  preview = function(ch0, ch1, ch2)
    return not (
      ch1:match '%s'
      or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a')
    )
  end
}

require 'mason'.setup()

vim.lsp.enable {
  "lua_ls",
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      format = { enable = true }
    }
  }
})

vim.cmd.colorscheme 'catppuccin-mocha'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.winborder = 'rounded'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.gdefault = true
vim.opt.belloff = "all"
vim.opt.visualbell = true
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10
vim.opt.mouse = 'a'
vim.opt.fixeol = true
vim.opt.list = true
vim.opt.listchars = {
  trail = '-',
  tab = '>>',
}
vim.opt.fileformat = 'unix'
vim.opt.fileformats = 'unix,dos'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.g.mapleader = 'z'

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    vim.lsp.buf.format()
    require 'mini.trailspace'.trim()
    require 'mini.trailspace'.trim_last_lines()
  end
})

local function n(...) vim.keymap.set('n', ...) end
local function x(...) vim.keymap.set('x', ...) end
local function c(...) vim.keymap.set('c', ...) end
local function nx(...) vim.keymap.set({ 'n', 'x' }, ...) end
local function xo(...) vim.keymap.set({ 'x', 'o' }, ...) end
local function nxo(...) vim.keymap.set({ 'n', 'x', 'o' }, ...) end
local function all(...) vim.keymap.set({ 'n', 'x', 'o', 'i', 'v', 'c', 't' }, ...) end

n('<esc>', '<cmd>nohl<cr>')
c('<esc>', '<c-c>')

n(' ', '<Plug>(leap-anywhere)')
xo(' ', '<Plug>(leap)')

n('1', '<nop>')
n('2', '@')
n('3', vim.lsp.buf.rename)
n('4', '<nop>')
n('5', '<nop>')
n('6', '<nop>')
n('7', '<nop>')
n('8', '<cmd>x!<cr>')
n('9', '<cmd>bprev<cr>')
n('0', '<cmd>bnext<cr>')

n('!', '1')
n('@', '2')
n('#', '3')
n('$', '4')
n('%', '5')
n('^', '6')
n('&', '7')
n('*', '8')
n('(', '9')
n(')', '0')

n('Q', '@q')
n('M', '`m')
n('U', '<C-r>')
n('K', vim.lsp.buf.hover)
n('Z', '<nop>')

n('+', '"yyymy"yP`y')
x('+', '"yy"yPgv')

n('<bs>', '<cmd>Pick grep<cr>')
n('\\', '<cmd>Pick files<cr>')
n('<cr>', '<cmd>Pick buffers<cr>')

local error = { severity = vim.diagnostic.severity.ERROR }
local function jump_error(dir) require 'mini.bracketed'.diagnostic(dir, error) end
n('[E', function() jump_error('first', error) end)
n(']E', function() jump_error('last', error) end)
n('[e', function() jump_error('forward', error) end)
n(']e', function() jump_error('backward', error) end)

n('gd', vim.lsp.buf.definition)
n('gD', vim.lsp.buf.declaration)
n('gi', vim.lsp.buf.implementation)
n('gR', vim.lsp.buf.references)
n('<tab>', vim.lsp.buf.code_action)

n('<c-a>', 'ggVG')
n('<c-c>', 'myggVG"+y`y')
x('<c-c>', '"+y')

nx('-', '"0')
nx('=', '"+')
nx('gf', '=')
n('gff', '==')

nxo('H', '^')
nxo('L', '$')
nxo('R', '%')

all('<c-s>', '<cmd>w!<cr>')
all('<c-q>', '<cmd>x!<cr>')
all('<c-s-q>', '<cmd>wa!<cr><cmd>tabo<cr>')
all('<c-s-u>', '<cmd>UndotreeToggle<cr>')
all('<c-1>', require 'mini.files'.open)

all('<a-k>', '<cmd>resize +2<cr>')
all('<a-j>', '<cmd>resize -2<cr>')
all('<a-h>', '<cmd>vertical resize -2<cr>')
all('<a-l>', '<cmd>vertical resize +2<cr>')
all('<c-cr>', '<cmd>wincmd =<cr>')
all('<c-space>', '<cmd>resize<cr><cmd>vertical resize<cr>')

n('<leader>d', vim.diagnostic.open_float)
n('<leader>f', vim.lsp.buf.format)
n('<leader>z', 'zz')
nx('<leader>s', ':s/\\V\\<<c-r>0/')

local ms = require 'mini.keymap'.map_multistep

ms('i', '<tab>', { 'pmenu_next' })
ms('i', '<s-tab>', { 'pmenu_prev' })

local undo_path = vim.fn.stdpath('state') .. '/undo'
if vim.fn.isdirectory(undo_path) == 0 then
  vim.fn.mkdir(undo_path, 'p', 448)
end
vim.opt.undodir = undo_path
vim.opt.undofile = true

if vim.g.neovide then
  vim.opt.guifont = "Lilex Nerd Font:h14"
  local function update_scale(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
    if vim.g.neovide_scale_factor <= 0.1 then
      vim.g.neovide_scale_factor = 0.1
    end
  end
  vim.g.neovide_input_ime = true
  all('<c-scrollwheelup>', function() update_scale(0.1) end)
  all('<c-scrollwheeldown>', function() update_scale(-0.1) end)
  all('<c-=>', function() update_scale(0.1) end)
  all('<c-->', function() update_scale(-0.1) end)
  all('<c-0>', function() vim.g.neovide_scale_factor = 1.0 end)
end
