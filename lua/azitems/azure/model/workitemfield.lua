
---@class WorkItemFieldsAPI
---@field System.AreaPath string | nil
---@field System.TeamProject string | nil
---@field System.IterationPath string | nil
---@field System.WorkItemType string | nil
---@field System.State string | nil
---@field System.Reason string | nil
---@field System.AssignedTo PersonAPI | nil
---@field System.CreatedDate string | nil
---@field System.CreatedBy PersonAPI | nil
---@field System.ChangedDate string | nil
---@field System.ChangedBy PersonAPI | nil
---@field System.CommentCount number | nil
---@field System.Title string | nil
---@field Microsoft.VSTS.Common.StateChangeDate string | nil
---@field Microsoft.VSTS.Common.ResolvedDate string | nil
---@field Microsoft.VSTS.Common.ResolvedBy PersonAPI | nil
---@field Microsoft.VSTS.Common.ClosedDate string | nil
---@field Microsoft.VSTS.Common.ClosedBy PersonAPI | nil
---@field Microsoft.VSTS.Common.Priority number | nil
---@field Microsoft.VSTS.Common.Severity string | nil
---@field Microsoft.VSTS.Common.ValueArea string | nil
---@field Custom.Release number | nil
---@field Microsoft.VSTS.TCM.ReproSteps string | nil
local WorkItemFieldsAPI = {
	["System.AreaPath"] = nil,
	["System.TeamProject"] = nil, -- string
	["System.IterationPath"] = nil, -- string
	["System.WorkItemType"] = nil, -- string
	["System.State"] = nil, -- string
	["System.Reason"] = nil, -- string
	["System.AssignedTo"] = nil,
	["System.CreatedDate"] = nil, -- string (ISO 8601 datetime)
	["System.CreatedBy"] = nil,
	["System.ChangedDate"] = nil, -- string (ISO 8601 datetime)
	["System.ChangedBy"] = nil,
	["System.CommentCount"] = nil, -- number
	["System.Title"] = nil, -- string
	["Microsoft.VSTS.Common.StateChangeDate"] = nil, -- string (ISO 8601 datetime)
	["Microsoft.VSTS.Common.ResolvedDate"] = nil, -- string (ISO 8601 datetime)
	["Microsoft.VSTS.Common.ResolvedBy"] = nil,
	["Microsoft.VSTS.Common.ClosedDate"] = nil, -- string (ISO 8601 datetime)
	["Microsoft.VSTS.Common.ClosedBy"] = nil,
	["Microsoft.VSTS.Common.Priority"] = nil, -- number
	["Microsoft.VSTS.Common.Severity"] = nil, -- string (e.g., "3 - Medium")
	["Microsoft.VSTS.Common.ValueArea"] = nil, -- string
	["Custom.Release"] = nil, -- number
	["Microsoft.VSTS.TCM.ReproSteps"] = nil -- string (HTML content)
}


---@class WorkItemFields
---@field areaPath string
---@field description string
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
---@field priority string | number | nil
---@field severity string | nil
---@field valueArea string | nil
---@field relatedItems Base[] | nil 
local WorkItemFields = {
	title = "",
	description = "",
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
