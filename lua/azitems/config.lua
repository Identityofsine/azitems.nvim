
---@class ConfigModule 
local ConfigModule = {}

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
	azure = {
		patToken = nil
	},
}


local n_id = vim.api.nvim_create_namespace("azitems")

ConfigModule.config = config
ConfigModule.namespace = n_id

ConfigModule.setup = function(args)
	ConfigModule.config = vim.tbl_deep_extend("force", ConfigModule.config, args or {})
end

return ConfigModule
