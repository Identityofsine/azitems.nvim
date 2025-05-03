local person = require("azitems.azure.model.person")
local WorkItemField = require("azitems.azure.model.workitemfield")
local WorkItem      = require("azitems.azure.model.workitem")
---@class Parser
Parser = {}


---@param body CommentAPI 
---@return Comment
Parser.parseComment = function(body)
	---@type Comment
	local comment = {
		id = body.commentId,
		workItemId = body.workItemId,
		text = body.text,
		createdDate = body.createdDate,
		createdBy = person:constructor(body.createdBy),
		modifiedBy = person:constructor(body.modifiedBy),
		modifiedDate = body.modifiedDate,
		isDeleted = body.isDeleted,
		url = body.url,
		createdById = body.createdBy.id,
		constructor={},
	}
	setmetatable(comment, comment)
	return comment
end

Parser.parseComments = function(body)
	local comments = {}
	for _, item in ipairs(body) do
		local comment = Parser.parseComment(item)
		table.insert(comments, comment)
	end
	return comments
end

---@return Query
Parser.parseQuery = function(body)
	---@type Query
	local query = {
		id = body.id,
		name = body.name,
		queryText = body.queryText,
		isDeleted = body.isDeleted,
		isPublic = body.isPublic,
		isFolder = body.isFolder,
		folderPath = body.folderPath,
		queryType = body.queryType,
		hasChildren = body.hasChildren,
		children = {},
		path = body.path,
		constructor={},
		__index = Query
	}
	if body.children and body.hasChildren then
		for _, child in ipairs(body.children) do
			local childQuery = Parser.parseQuery(child)
			table.insert(query.children, childQuery)
		end
	end

	setmetatable(query, query)
	return query
end

Parser.parseExecutedQuery = function(eQuery)
	---@type ExecutedQuery
	local query = {
		queryType = eQuery.queryType,
		queryResultType = eQuery.queryResultType,
		asOf = eQuery.asOf,
		columns = {},
		sortColumns = {},
		workItems = eQuery.workItems,
		constructor={},
		__index = ExecutedQuery
	}

	return query
end

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
	if not body or not body.value then
		vim.notify("No work items found, " .. vim.inspect(body), vim.log.levels.WARN)
		return workItems
	end
	for _, item in ipairs(body.value) do
		local workItem = Parser.parseWorkItem(item)
		table.insert(workItems, workItem)
	end
	return workItems
end


