return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope live grep' })

    vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.grep_string({search = vim.fn.input("Grep > ")});
    end, { desc = "Telescope search" })

    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end
}