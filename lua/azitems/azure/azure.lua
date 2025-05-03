require("azitems.azure.api")
require("azitems.azure.api.")

---@class AzureModule
local AzureModule = {};

AzureModule.getWorkItems = AzureApi.getWorkItems
AzureModule.getQueries = QueryApi.fetchQueries
AzureModule.clearCache = function()
		WorkItemCache:clear()
		QueryCache:clear()
	end

return AzureModule
