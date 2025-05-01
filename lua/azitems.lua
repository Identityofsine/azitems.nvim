local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

-- main module file
local module = require("azitems.module")
local config = require("azitems.config").config
local workitemUtils = require("azitems.util.string")

---@class MyModule
local M = {}

M.setup = function(opts)
	config.setup(opts)
end

M.hello = function()
  return module.my_first_function(config.opt)
end

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 10 },
    { width = 60 },
  },
})

local previewer = previewers.new_buffer_previewer({
	define_preview = function(self, entry, status)
		local workItem = entry.value
		local preview_text = string.format(
			"ID: %d\nTitle: %s\nAssigned To: %s\nState: %s\nDescription: %s",
			workItem.id,
			workItem.fields.title,
			workItem.fields.assignedTo.displayName,
			workItem.fields.state,
			workItem.fields.description
		)
		self.state.bufnr = self.state.bufnr or vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(preview_text, "\n"))
	end,
})

M.workItems = function()
	local workItems = module.getWorkItems()
	pickers.new({}, {
		prompt_title = "A5 Work Items",
		finder = finders.new_table {
			results = workItems,
			---@param entry WorkItem
			entry_maker = function(entry)
				return {
					value = entry,
					display = function()
						return displayer({
							{ workitemUtils[entry.fields.workItemType](tostring(entry.id)), "Error" },
							{ entry.fields.title, "Error" },
						})
					end,
					ordinal = entry.id .. " " .. entry.fields.title,
				}
			end,
		},
		previewer = previewer,
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				print(vim.inspect(selection.value))
			end)
			return true
		end,
	}):find()
end


return M
