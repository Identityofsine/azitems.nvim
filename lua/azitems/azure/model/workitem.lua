require("azitems.azure.model.person")
require("azitems.azure.model.workitemfield")

---@class WorkItemAPI
---@field id number
---@field rev number
---@field fields WorkItemFieldsAPI | nil
local WorkItemAPI = {
	-- Define the properties of the WorkItemAPI class
	id = -1,
	rev = -1,
	fields = nil
}

---@class WorkItem
---@field id number
---@field fields WorkItemFields | nil
local WorkItem = {
	-- Define the properties of the WorkItem class
	id = -1,
	fields = nil
}

WorkItem.__index = WorkItem

function WorkItem:constructor(id, fields)
	---@type WorkItem
	local self = {}
	setmetatable(self, WorkItem)
	self.id = id
	self.fields = fields
	return self
end

return WorkItem
