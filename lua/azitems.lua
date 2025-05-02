local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

-- main module file
local config = require("azitems.config")
local highlight = require("azitems.highlight")
local renderer = require("azitems.render")
local module = require("azitems.module")
local workitemUtils = require("azitems.util.string")

---@class MyModule
local M = {}

M.setup = function(opts)
	vim.notify("Setting up azitems with opts: " .. vim.inspect(opts), vim.log.levels.INFO)
	config:setup(opts)
end

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 11 },
    { width = 61 },
  },
})

local WorkItemPreviewer = previewers.new_buffer_previewer({
	define_preview = renderer.preview.workitem
})

M.workItems = function()
	local workItems = module.getWorkItems()
	pickers.new({}, {
		prompt_title = "A6 Work Items",
		finder = finders.new_table {
			results = workItems,
			---@param entry State 
			entry_maker = function(entry)
				local value = entry:getState()
				if not value then
					return nil
				end
				return {
					value = entry,
					display = function()
						---@type WorkItem
						return displayer({
							{ workitemUtils[value.fields.workItemType](tostring(value.id)), "Bug" },
							{ value.fields.title, "BugText" },
						})
					end,
					ordinal = value.id .. " " .. value.fields.title,
				}
			end,
		},
		previewer = WorkItemPreviewer,
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				renderer.buffer.openWorkItem(selection.value)
			end)
			return true
		end,
	}):find()
end


return M
