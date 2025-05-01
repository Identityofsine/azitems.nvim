local config = require("azitems.config")
--[[

	Highlighter module for highlighting work items in a buffer.

]]

---@class Highlighter
local Highlighter = {}

---this is completely static, and based on the template, if the template changes, this will need to be updated
---@param buffer OpenedBuffer 
Highlighter.highlightWorkItemTemplate = function(self, buffer)
	-- lets set the first line to color
	vim.api.nvim_buf_set_extmark(buffer.bufnr, config.namespace, 1, 0, {
		line_hl_group = "Bug",
		hl_group = "Bug",
		hl_eol = true,
		hl_mode = "replace",
	})
	vim.api.nvim_buf_set_extmark(buffer.bufnr, config.namespace, 15, 0, {
		line_hl_group = "CreatedBy",
		hl_group = "CreatedBy",
		hl_eol = true,
		hl_mode = "replace",
	})
end

return Highlighter
