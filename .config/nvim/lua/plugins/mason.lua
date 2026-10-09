require("mason").setup({
    firewall = {
		enabled = true
	},
	install_root_dir = vim.fn.stdpath("cache") .. "/mason",

	ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lsp_servers = require('config.lsp'):GetMasonNames()
require("mason-lspconfig").setup({
	ensure_installed =  lsp_servers;
})


