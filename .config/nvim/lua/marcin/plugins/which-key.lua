return {
  "folke/which-key.nvim",
  config = function()
    vim.keymap.set("n", "<C-h>k", function()
      require("which-key").show({ global = false })
    end)
  end
}