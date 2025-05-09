require("azitems.azure.model.query")
require("azitems.azure.api.parser")
require("azitems.azure.api.cache")
local config = require("azitems.config")
--[
-- This file is to act as a query helper, this will use microsoft's tools and your own queries to give back work-items.
--]

QueryApi = {}
local GetQueriesEndPoint = "https://dev.azure.com/{{org}}/{{project}}/_apis/wit/queries?api-version=7.2-preview.2&$depth=2"
local ExecuteQueryEndPoint = "https://dev.azure.com/{{org}}/{{project}}/_apis/wit/wiql/{{queryid}}?api-version=7.1"

QueryApi.__index = QueryApi

function QueryApi:fetchQueries()

	local opts = {
		requestMethod = "get",
		headers = {},
		url = GetQueriesEndPoint:gsub("{{org}}", config.config.azure.org):gsub("{{project}}", config.config.azure.project),
		org = config.config.azure.org,
		project = config.config.azure.project,
	}
	local preQueries = AzureFetch(opts)
	if not preQueries then
		vim.notify("Error fetching queries from Azure DevOps", vim.log.levels.ERROR)
		return {}
	end
	-- Check if the response is empty
	if not preQueries or not preQueries.value or #preQueries.value == 0 then
		vim.notify("No queries found in Azure DevOps", vim.log.levels.ERROR)
		return {}
	end
	local queries = {}
	for _, query in ipairs(preQueries.value) do
		local q = Parser.parseQuery(query)
		if q then
			table.insert(queries, q)
		end
	end

	return queries
end

---@param query Query
function QueryApi:executeQuery(query)
	local cached = QueryCache:getItem(query.id)
	if cached then
		return cached
	end

	local opts = {
		requestMethod = "get",
		headers = {},
		url = ExecuteQueryEndPoint:gsub("{{org}}", config.config.azure.org):gsub("{{project}}", config.config.azure.project):gsub("{{queryid}}", query.id),
		org = config.config.azure.org,
		project = config.config.azure.project,
	}
	local preQueries = AzureFetch(opts)
	local queries = Parser.parseExecutedQuery(preQueries)
	return queries
end
