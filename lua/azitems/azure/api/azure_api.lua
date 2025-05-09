local config = require("azitems.config")
local state         = require("azitems.render.state")
require("azitems.util")
require("azitems.azure.api.api")
require("azitems.azure.api.query")
require("azitems.azure.api.parser")
require("azitems.azure.api.cache")
require("azitems.azure.api.comment")

---@class AzureApi
AzureApi = {}

function AzureApi:getWorkItems()

	local workitems = {}
	if config.config.azure.workitem == nil or config.config.azure.workitem.query == nil then
		vim.notify("No query found in config, please select one using :AZQueries", vim.log.levels.ERROR)
		return workitems
	end
	local workitemIds = QueryApi:executeQuery(config.config.azure.workitem.query)
	-- get all workitem ids from query
	workitemIds = Map(function(tbl) return tbl.id end, workitemIds.workItems)
	-- store nonCached ids in tempArray
	local tempArray = {}
	for _, id in ipairs(workitemIds) do
		local cached = WorkItemCache:getItem(id)
		if not cached then
			table.insert(tempArray, id)
			goto continue
		else
			table.insert(workitems, cached:getData())
		end
	  ::continue::
	end
	--set workitemIds to tempArray
	workitemIds = tempArray
	local remainingWorkItemIds = #workitemIds
	vim.notify("Fetching " .. remainingWorkItemIds .. " work items", vim.log.levels.INFO)
  while remainingWorkItemIds > 0 do
		local slice = Slice(workitemIds, 0, 200)
		local currentFetch = slice.sliced
		workitemIds = slice.remaining
		remainingWorkItemIds = #workitemIds
		---@type FetchOpts
		local opts = {
			requestMethod = "post",
			headers = {},
			url = "https://dev.azure.com/" .. config.config.azure.org .. "/" .. config.config.azure.project .. "/" .. "_apis/wit/workitemsbatch?api-version=7.2-preview.1",
			org = config.config.azure.org,
			project = config.config.azure.project,
			body = {
				ids = currentFetch,
			},
		}
		local preWorkItems = AzureFetch(opts)
		local _workitems = Parser.parseWorkItems(preWorkItems)
		PushMass(workitems, _workitems)
		for _, value in ipairs(_workitems) do
			-- cache workitem
			WorkItemCache:cacheItem(value.id, "workitem", value)
		end
  end

	local statefulWorkItems = {}
	---@param value WorkItem
	for index, value in ipairs(workitems) do
		statefulWorkItems[index] = state:new(value)	
	end

	return statefulWorkItems
end

---@param workItem WorkItem
---@param callback function
function AzureApi:mutateWorkItem(workItem, callback, mutation)
	-- call api and update workItem
	-- ...
	return callback(workItem)
end

return AzureApi
