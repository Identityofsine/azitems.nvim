require("azitems.azure.api")

---@class AzureModule
local AzureModule = {};

AzureModule.getWorkItems = AzureApi.getWorkItems
AzureModule.getQueries = QueryApi.fetchQueries

return AzureModule
