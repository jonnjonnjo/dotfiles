return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
	require("oil").setup({
		default_file_explorer = true,
		columns = {
			"icon",
			--"size",
			--"mtime",
		},
		lsp_file_methods = {
			enabled = true,
			timeout_ms = 10000,
			autosave_changes = false, 
		},
		constrain_cursor = "editable",
		watch_for_changes = false,
		keymaps = {
		},
		view_options = {
			show_hidden = false,
			is_hidden_file = function(name,bufnr)
				local m = name:match("^&.")
				return m ~= nil
			end, 
			is_always_hidden = function(name,bufnr)
				return false
			end,
			natural_order = "fast",
			case_insensitive = true, 
			sort = {
				{"type", "asc"},
				{"name", "asc"},
			}
		},
		preview_win = {
			update_on_cursor_moved = true, 
			preview_method = "fast_scratch",
			disable_preview = function(filename)
				return false
			end,

		},
	})
  end,

}
