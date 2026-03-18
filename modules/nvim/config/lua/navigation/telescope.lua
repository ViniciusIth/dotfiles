local telescope = require("telescope")
local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local builtin = require("telescope.builtin")

telescope.setup({
    pickers = {
        find_files = {
            hidden = true
        },
        live_grep = {
            additional_args = function(_)
                return { "--hidden" }
            end
        }
    },
    defaults = {
        file_ignore_patterns = { 'node_modules', '.git', '.venv' }
    },
    extensions = {
        repo = {
            list = {
                fd_opts = {
                    "--no-ignore-vcs",
                },
                search_dirs = {
                    "~/Projects",
                    "~/Documents"
                },
                tail_path = false
            },
        },
    },
})


local function search_hub()
  local searches = {
    { name = "Find files", run = builtin.find_files },
    { name = "Live grep", run = builtin.live_grep },
    { name = "Buffers", run = builtin.buffers },
    { name = "Diagnostics (Project)", run = builtin.diagnostics },
    { name = "Help tags", run = builtin.help_tags },
    { name = "Functions / Methods (current file)", run = function()
      builtin.lsp_document_symbols({
        symbols = { "function", "method" },
      })
    end },
    { name = "Workspace symbols", run = builtin.lsp_workspace_symbols },
    { name = "Recent files", run = builtin.oldfiles },
  }

  pickers.new({}, {
    prompt_title = "Search",
    finder = finders.new_table({
      results = searches,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry().value
        actions.close(prompt_bufnr)
        selection.run()
      end)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>fs", search_hub, { desc = "Search hub" })
