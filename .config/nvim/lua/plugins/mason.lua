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

require("mason-lspconfig").setup()
