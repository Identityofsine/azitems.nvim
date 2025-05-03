---@class Parser
Parser = {}


---@param body WorkItemAPI
Parser.parseWorkItem = function(body)
	---@type WorkItem
	local workItem = {
		id = body.id,
		fields = {
			title = body.fields['System.Title'],
			description = body.fields['System.Description'] or body.fields['Microsoft.VSTS.TCM.ReproSteps'],
			areaPath = body.fields['System.AreaPath'],
			teamProject = body.fields['System.TeamProject'],
			iterationPath = body.fields['System.IterationPath'],
			workItemType = body.fields['System.WorkItemType'],
			state = body.fields['System.State'],
			assignedTo = person:constructor(body.fields['System.AssignedTo']),
			changedDate = body.fields['System.ChangedDate'],
			changedBy = person:constructor(body.fields['System.ChangedBy']),
			commentCount = body.fields['System.CommentCount'],
			priority = body.fields['Microsoft.VSTS.Common.Priority'],
			severity = body.fields['Microsoft.VSTS.Common.Severity'],
			valueArea = body.fields['Microsoft.VSTS.Common.ValueArea'],
			closedBy = person:constructor(body.fields['Microsoft.VSTS.Common.ClosedBy']),
			closedDate = body.fields['Microsoft.VSTS.Common.ClosedDate'],
			resolvedBy = person:constructor(body.fields['Microsoft.VSTS.Common.ResolvedBy']),
			resolvedDate = body.fields['Microsoft.VSTS.Common.ResolvedDate'],
			stateChangeDate = body.fields['Microsoft.VSTS.Common.StateChangeDate'],
			reproSteps = body.fields['Microsoft.VSTS.TCM.ReproSteps'],
			createdBy = person:constructor(body.fields['System.CreatedBy']),
			createdDate = body.fields['System.CreatedDate'],
			reason = body.fields['System.Reason'],
			constructor={}
		},
		constructor = {},
		__index = WorkItem
	}
	setmetatable(workItem, workItem)
	return workItem
end

Parser.parseWorkItems = function(body)
	local workItems = {}
	for _, item in ipairs(body.value) do
		local workItem = Parser.parseWorkItem(item)
		table.insert(workItems, workItem)
	end
	return workItems
end


