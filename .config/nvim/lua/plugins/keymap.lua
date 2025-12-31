return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          -- Add a keymap
          { "H", "<cmd>echo 'hello'<cr>", desc = "Say Hello" },
          -- Change an existing keymap
          { "K", "<cmd>echo 'custom hover'<cr>", desc = "Custom Hover" },
          -- Disable a keymap
          { "gd", false },
          {
            "<leader>cp",
            function()
              local template_path = vim.fn.expand("~/.config/nvim/templates/competitive-programming/template.cpp")
              local lines = vim.fn.readfile(template_path)
              vim.api.nvim_put(lines, "l", true, true)
            end,
            { desc = "Insert C++ competitive programming template" },
          },
        },
      },
    },
  },
}
