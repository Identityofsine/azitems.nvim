require("azitems.azure.azure")
local AzureModule = require("azitems.azure.azure")

---@class CustomModule
local M = {}

M.clearCache = function()
	AzureModule:clearCache()
end

M.getWorkItems = function()
	return AzureModule:getWorkItems()
end

M.getQueries = function()
	return AzureModule:getQueries()
end

return M
