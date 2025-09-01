

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  -- or: tag = '0.1.8',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- lua/plugins/rose-pine.lua
  use {
	  "rose-pine/neovim",
	  as = "rose-pine",
	  config = function()
		  vim.cmd("colorscheme rose-pine")
	  end
  }

  use("theprimeagen/harpoon")

  use("mbbill/undotree")
  use("tpope/vim-fugitive")

 use("nvim-tree/nvim-web-devicons")
 use("folke/which-key.nvim")
end)


