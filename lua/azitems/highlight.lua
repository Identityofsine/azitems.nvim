local Config = require("azitems.config")
require("azitems.util")

local namespace = 0

vim.api.nvim_set_hl(namespace, "UserStory", { fg = "#fef3ef", bg = "#038aff" })
vim.api.nvim_set_hl(namespace, "UserStoryText", { fg = "#038aff" })
vim.api.nvim_set_hl(namespace, "Bug", { fg = "#fef3ef", bg = "#cc293d" })
vim.api.nvim_set_hl(namespace, "BugText", { fg = "#cc293d" })
vim.api.nvim_set_hl(namespace, "CreatedBy", { fg = "#fef3ef", bg = "#038aff" })

------------
--WorkItem--
------------

---@param type string
function GetHighLightbyWorkType(workType)
	workType = workType:lower():gsub("%s+", "")
	local hl = vim.api.nvim_get_hl(0, { name = workType })
	return Ternary(hl and hl.fg, workType, "Bug")
end
