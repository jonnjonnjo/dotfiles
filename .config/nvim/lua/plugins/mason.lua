-- I think it's better for the nvim to start this plugin right at the time of nvim instatiation  
return {
    {
    "mason-org/mason.nvim",
    opts = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	},
    },
    },
	{
	    "mason-org/mason-lspconfig.nvim",
	    opts = {},
	    dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	    },
	}
}

