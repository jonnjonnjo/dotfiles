return {
	{ "ellisonleao/gruvbox.nvim" },
	{ "e-q/okcolors.nvim", name = "okcolors",
  -- lazy = false,
  -- priority = 1000,
  -- -- name = 'kanagawa-paper',
  -- config = function()
  --  vim.cmd.colorscheme("okcolors")
  -- end,
},
	{
		"thesimonho/kanagawa-paper.nvim",
  -- lazy = false,
  -- priority = 1000,
  -- name = 'kanagawa-paper',
  -- config = function()
  --  vim.cmd.colorscheme("kanagawa-paper")
  -- end,
	},
	{
  'embark-theme/vim',
  -- lazy = false,
  -- priority = 1000,
  -- name = 'embark',
  -- config = function()
  --  vim.cmd.colorscheme("embark")
  -- end,
},
	{ "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  name = 'kanagawa',
  config = function()
   vim.cmd.colorscheme("kanagawa")
  end,
},
}
