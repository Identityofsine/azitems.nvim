---@class WorkItemFields
---@field areaPath string
---@field teamProject string
---@field iterationPath string
---@field workItemType string
---@field state string
---@field reason string
---@field assignedTo Person | nil
---@field createdDate string | nil
---@field createdBy Person | nil
---@field changedDate string | nil
---@field changedBy Person | nil
---@field communtCount number | nil
---@field title string
---@field priority string | nil
---@field severity string | nil
---@field valueArea string | nil
---@field relatedItems Base[] | nil 
local WorkItemFields = {
	title = "",
	areaPath = "",
	teamProject = "",
	iterationPath = "",
	workItemType = "",
	state = "",
	reason = "",
	assignedTo = nil,
	createdDate = nil,
	createdBy = nil,
	changedDate = nil,
	changedBy = nil,
	communtCount = nil,
	priority = nil,
	severity = nil,
	valueArea = nil,
	relatedItems = {},
}

function WorkItemFields:constructor(
	title,
	priority,
	state,
	reason,
	severity,
	assignedTo,
	createdDate,
	createdBy,
	changedDate,
	changedBy,
	areaPath,
	teamProject,
	iterationPath,
	workItemType,
	communtCount,
	valueArea
)
	---@type WorkItemFields
	local self = {}
	self.areaPath = areaPath
	self.teamProject = teamProject
	self.iterationPath = iterationPath
	self.workItemType = workItemType
	self.state = state
	self.reason = reason
	self.assignedTo = assignedTo
	self.createdDate = createdDate
	self.createdBy = createdBy
	self.changedDate = changedDate
	self.changedBy = changedBy
	self.communtCount = communtCount
	self.title = title
	self.priority = priority or ""
	self.severity = severity
	self.valueArea = valueArea

	---@return WorkItemFields
	function self:new()
		return self
	end

	return self
end

return WorkItemFields
