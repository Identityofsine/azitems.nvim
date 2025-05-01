require("azitems.azure.azure")
local AzureModule = require("azitems.azure.azure")

---@class CustomModule
local M = {}

---@return string
M.my_first_function = function(greeting)
  return greeting
end

M.getWorkItems = function()
	return AzureModule:getWorkItems()
end
return M
