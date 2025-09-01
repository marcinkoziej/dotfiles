vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")


vim.lsp.config("*", {
on_attach = function(client, buffer) 
	local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = "Show diagnostics" }
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts)	
end,

})
