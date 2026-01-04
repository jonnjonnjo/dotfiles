local M = {}

local TEMPLATE_DIR = vim.fn.expand("~/.config/nvim/templates/competitive-programming")

local function copy_template_to_clipboard()
  require("telescope.builtin").find_files({
    prompt_title = "CP Templates",
    cwd = TEMPLATE_DIR,
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection then
          local filepath = selection.path or selection.filename
          local file = io.open(filepath, "r")
          if file then
            local content = file:read("*all")
            file:close()

            -- Copy to system clipboard
            vim.fn.setreg("+", content)
            vim.notify("Template copied to clipboard: " .. selection.filename, vim.log.levels.INFO)
          else
            vim.notify("Error reading file: " .. filepath, vim.log.levels.ERROR)
          end
        end
      end)

      return true
    end,
  })
end

local function insert_template_at_cursor()
  require("telescope.builtin").find_files({
    prompt_title = "CP Templates",
    cwd = TEMPLATE_DIR,
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection then
          local filepath = selection.path or selection.filename
          local file = io.open(filepath, "r")
          if file then
            local content = file:read("*all")
            file:close()

            local lines = {}
            for line in content:gmatch("[^\r\n]+") do
              table.insert(lines, line)
            end

            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, lines)

            vim.notify("Template inserted: " .. selection.filename, vim.log.levels.INFO)
          else
            vim.notify("Error reading file: " .. filepath, vim.log.levels.ERROR)
          end
        end
      end)

      return true
    end,
  })
end

-- Option 1: Copy to clipboard
vim.keymap.set("n", "<leader>tcpc", copy_template_to_clipboard, {
  desc = "CP Template to Clipboard",
})

-- Option 2: Insert at cursor
vim.keymap.set("n", "<leader>tcpi", insert_template_at_cursor, {
  desc = "CP Template Insert at cursor",
})

return M
