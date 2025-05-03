---@class Query
---@field id string | nil
---@field name string | nil
---@field path string | nil
---@field isFolder boolean
---@field hasChildren boolean
---@field children Query[] | nil
Query = {
	id = nil,
	name = nil,
	path = nil,
	isFolder = false,
	hasChildren = false,
	children = {},
}

---@class ExecutedQuery
---@field queryType string | nil
---@field queryResultType string | nil
---@field asOf string | nil
---@field columns table
---@field sortColumns table
---@field workItems QueriedWorkItem[] 
ExecutedQuery = {
	queryType = nil,
	queryResultType = nil,
	asOf = nil,
	columns = {},
	sortColumns = {},
	workItems = {},
}


---@class QueriedWorkItem
QueriedWorkItemApi = {
	id = -1,
	url = ""
}
