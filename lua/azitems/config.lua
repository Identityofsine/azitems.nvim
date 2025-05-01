
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

ConfigModule.config = config

ConfigModule.setup = function(args)
	ConfigModule.config = vim.tbl_deep_extend("force", ConfigModule.config, args or {})
end

return ConfigModule
