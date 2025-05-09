---@class Config
local config = {
	api = {
		cache = {
			enabled = true,
			refreshTime = 300, -- every 5 minutes
		}
	},
	azure = {
		patToken = "",
		org = "",
		project = "",
		workitem = {}
	},
}

---@class ConfigModule 
local ConfigModule = {
	config=config
}

local n_id = vim.api.nvim_create_namespace("azitems")
ConfigModule.namespace = n_id

function ConfigModule:setup(args)
	self.config = vim.tbl_deep_extend("force", ConfigModule.config, args or {})
end



return ConfigModule
