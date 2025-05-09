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
require("azitems.util")

---@class MyModule
local M = {}

M.setup = function(opts)
	config:setup(opts)
end

local displayer = entry_display.create({
  separator = " ",
  items = {
    { width = 10 },
    { width = 61 },
  },
})

local WorkItemPreviewer = previewers.new_buffer_previewer({
	define_preview = renderer.preview.workitem
})

M.workItems = function()
	local workItems = module.getWorkItems()
	pickers.new({}, {
		prompt_title = string.format("%s Work Items", config.config.azure.workitem.query.path),
		finder = finders.new_table {
			results = workItems,
			---@param entry State 
			entry_maker = function(entry)
				---@type WorkItem
				local value = entry:getState()
				if not value then
					return nil
				end
				return {
					value = entry,
					display = function()
						---@type WorkItem
						return displayer({
							{ (workitemUtils:get(value.fields.workItemType))(" " .. tostring(value.id)), GetHighLightbyWorkType(value.fields.workItemType) },
							{ value.fields.title, GetHighLightbyWorkType(value.fields.workItemType.."Text") },
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

M.queries = function()
	local queries = Filter(module.getQueries(), function(tbl)
		if tbl.children and #tbl.children > 0 then
			return true
		end
	end)
	local queriesChildren = Map(function(tbl)
		return tbl.children
	end, queries)
	pickers.new({}, {
		prompt_title = string.format("%s Queries", config.config.azure.project),
		finder = finders.new_table {
			results = queriesChildren[1],
			entry_maker = function(entry)
				return {
					---@type Query
					value = entry,
					display = function()
						return entry.path
					end,
					ordinal = entry.path,
				}
			end,
		},
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				---@type Query
				local selection = action_state.get_selected_entry().value
				config.config.azure.workitem.query = selection
			end)
			return true
		end
	}):find()
end

M.clearCache = function()
	module:clearCache()
end


return M
