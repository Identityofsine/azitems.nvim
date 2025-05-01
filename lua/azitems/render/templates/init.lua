local plugin_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local templates_folder = plugin_path .. "tmpl"

--- @class Templater
local Templater = {}

local function get_template_path(template_name)
	return templates_folder .. "/" .. template_name
end


--- @param workItem WorkItem
Templater.getWorkItemTemplate = function(workItem)
	local template_name = "workitem.md"
	local template_path = get_template_path(template_name)
	local file = table.concat(vim.fn.readfile(template_path), "\n")
	local text = file
	text = text:gsub("{{title}}", tostring(workItem.fields.title))
	text = text:gsub("{{id}}", tostring(workItem.id))
	text = text:gsub("{{workItemType}}", tostring(workItem.fields.workItemType))
	text = text:gsub("{{state}}", tostring(workItem.fields.state))
	text = text:gsub("{{priority}}", tostring(workItem.fields.priority))
	text = text:gsub("{{severity}}", tostring(workItem.fields.severity))
	text = text:gsub("{{valueArea}}", tostring(workItem.fields.valueArea))
	text = text:gsub("{{reason}}", tostring(workItem.fields.reason))
	text = text:gsub("{{areaPath}}", tostring(workItem.fields.areaPath))
	text = text:gsub("{{iterationPath}}", tostring(workItem.fields.iterationPath))
	text = text:gsub("{{teamProject}}", tostring(workItem.fields.teamProject))
	text = text:gsub("{{assignedTo.displayName}}", tostring(workItem.fields.assignedTo.displayName))
	text = text:gsub("{{assignedTo.uniqueName}}", tostring(workItem.fields.assignedTo.uniqueName))
	text = text:gsub("{{assignedTo.imageUrl}}", tostring(workItem.fields.assignedTo.imageUrl))
	text = text:gsub("{{createdBy.displayName}}", tostring(workItem.fields.createdBy.displayName))
	text = text:gsub("{{createdBy.uniqueName}}", tostring(workItem.fields.createdBy.uniqueName))
	text = text:gsub("{{createdDate}}", tostring(workItem.fields.createdDate))
	text = text:gsub("{{changedBy.displayName}}", tostring(workItem.fields.changedBy.displayName))
	text = text:gsub("{{changedBy.uniqueName}}", tostring(workItem.fields.changedBy.uniqueName))
	text = text:gsub("{{changedDate}}", tostring(workItem.fields.changedDate))

	return text
end

return Templater
