local plugin_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local templates_folder = plugin_path .. "tmpl"


local fields = {}

--- @class Templater
local Templater = {}

local function get_template_path(template_name)
	return templates_folder .. "/" .. template_name
end

--- @param str string|number
local function nilSafeString(str, opts)
	if str == nil then
		return "" or opts.default
	end
	return tostring(str)
end

table.safeTableGet = function(self, key)
	if self == nil then
		return nil
	end
	if type(self) == "table" then
		return self[key]
	end
	return nil
end


--- @param workItem WorkItem
Templater.getWorkItemTemplate = function(workItem)
	local template_name = "workitem.md"
	local template_path = get_template_path(template_name)
	local file = table.concat(vim.fn.readfile(template_path), "\n")
	local text = file
	text = text:gsub("{{title}}", nilSafeString(workItem.fields.title))
	text = text:gsub("{{id}}", nilSafeString(workItem.id))
	text = text:gsub("{{workItemType}}", nilSafeString(workItem.fields.workItemType))
	text = text:gsub("{{state}}", nilSafeString(workItem.fields.state))
	text = text:gsub("{{priority}}", nilSafeString(workItem.fields.priority))
	text = text:gsub("{{severity}}", nilSafeString(workItem.fields.severity))
	text = text:gsub("{{valueArea}}", nilSafeString(workItem.fields.valueArea))
	text = text:gsub("{{reason}}", nilSafeString(workItem.fields.reason))
	text = text:gsub("{{areaPath}}", nilSafeString(workItem.fields.areaPath))
	text = text:gsub("{{iterationPath}}", nilSafeString(workItem.fields.iterationPath))
	text = text:gsub("{{teamProject}}", nilSafeString(workItem.fields.teamProject))
	text = text:gsub("{{assignedTo.displayName}}", nilSafeString(workItem.fields.assignedTo.displayName))
	text = text:gsub("{{assignedTo.uniqueName}}", nilSafeString(workItem.fields.assignedTo.uniqueName))
	text = text:gsub("{{assignedTo.imageUrl}}", nilSafeString(workItem.fields.assignedTo.imageUrl))
	text = text:gsub("{{createdBy.displayName}}", nilSafeString(workItem.fields.createdBy.displayName))
	text = text:gsub("{{createdBy.uniqueName}}", nilSafeString(workItem.fields.createdBy.uniqueName))
	text = text:gsub("{{createdDate}}", nilSafeString(workItem.fields.createdDate))
	text = text:gsub("{{changedBy.displayName}}", nilSafeString(workItem.fields.changedBy.displayName))
	text = text:gsub("{{changedBy.uniqueName}}", nilSafeString(workItem.fields.changedBy.uniqueName))
	text = text:gsub("{{changedDate}}", nilSafeString(workItem.fields.changedDate))

	return text
end

return Templater
