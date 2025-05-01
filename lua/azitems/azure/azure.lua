require("azitems.azure.azure_api")
local AzureApi = require("azitems.azure.azure_api")

---@class AzureModule
local AzureModule = {};

AzureModule.getWorkItems = AzureApi.getWorkItems

return AzureModule
