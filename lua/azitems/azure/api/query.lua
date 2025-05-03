require("azitems.azure.model.query")
require("azitems.azure.api.parser")
require("azitems.azure.api.cache")
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
		url = GetQueriesEndPoint:gsub("{{org}}", "lbisoftware"):gsub("{{project}}", "A5"),
		org = self.org,
		project = self.project,
	}
	local preQueries = AzureFetch(opts).value[1]
	local queries = Parser.parseQuery(preQueries)
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
		url = ExecuteQueryEndPoint:gsub("{{org}}", "lbisoftware"):gsub("{{project}}", "A5"):gsub("{{queryid}}", query.id),
		org = self.org,
		project = self.project,
	}
	local preQueries = AzureFetch(opts)
	local queries = Parser.parseExecutedQuery(preQueries)
	return queries
end
