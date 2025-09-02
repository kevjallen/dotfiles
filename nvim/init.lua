-- Neovim configuration file

-- global options
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.title = true

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
  end,
})

-- set filetype for helm templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*helm*/templates/*.yaml",
  callback = function()
    vim.bo.filetype = "helm"
  end,
})

-- packer configuration
local ensure_packer = function()
  local fn = vim.fn
  local repo = 'https://github.com/wbthomason/packer.nvim'
  local path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', repo, path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use({
    'folke/tokyonight.nvim',
    config = function()
      local ok, tokyonight = pcall(require, 'tokyonight')
      if ok then
        tokyonight.setup({
          style = 'moon',
          transparent = true,
          terminal_colors = true,
        })
        vim.cmd('colorscheme tokyonight')
      end
    end
  })

  use({
    'hrsh7th/nvim-cmp',
    config = function()
      local ok, cmp = pcall(require, 'cmp')
      if ok then
        cmp.setup({
          mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
          },
        })
      end
    end
  })

  use({
    'ibhagwan/fzf-lua',
    config = function()
      local ok, fzf_lua = pcall(require, 'fzf-lua')
      if ok then
        fzf_lua.setup({'fzf-vim'})
        fzf_lua.register_ui_select()
      end
    end
  })

  use({
    'nvim-tree/nvim-tree.lua',
    config = function()
      local ok, nvim_tree = pcall(require, 'nvim-tree')
      if ok then
        nvim_tree.setup({
          view = {
            width = 40,
            side = 'left',
          },
        })
      end
    end
  })

  use({
    'williamboman/mason.nvim',
    config = function()
      local ok, mason = pcall(require, 'mason')
      if ok then
        mason.setup()
      end
    end
  })

  use({
    'williamboman/mason-lspconfig.nvim',
    after = { 'mason.nvim' },
    config = function()
      local ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
      if ok then
        mason_lspconfig.setup({
          ensure_installed = {
            'gopls',
            'helm_ls',
            'jsonls',
            'pyright',
            'terraformls',
            'ts_ls',
            'yamlls',
          },
        })
      end
    end
  })

  use 'github/copilot.vim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'junegunn/fzf'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'tpope/vim-commentary'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'wbthomason/packer.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim-airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'luna'

-- copilot.vim
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  script = true
})

-- leader key mappings
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')

vim.keymap.set('n', '<leader>b', '<cmd>Buffers<CR>')
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>f', '<cmd>Files<CR>')
vim.keymap.set('n', '<leader>g', '<cmd>GFiles<CR>')
vim.keymap.set('n', '<leader>h', '<cmd>History<CR>')
vim.keymap.set('n', '<leader>l', '<cmd>Lines<CR>')
vim.keymap.set('n', '<leader>m', '<cmd>Marks<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>Copen<CR>')
vim.keymap.set('n', '<leader>r', '<cmd>Rg<CR>')
