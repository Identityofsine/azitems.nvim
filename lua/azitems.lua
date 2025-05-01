local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

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
					return workitemUtils[entry.fields.workItemType](string.format("%s — %s", entry.id, entry.fields.title))
				end,
				ordinal = entry.id .. " " .. entry.fields.title,
			}
		end,
	},
	sorter = conf.generic_sorter({}),
	attach_mappings = function(prompt_bufnr, map)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
		end)
		return true
	end,
	}):find()
end


return M
