local config = require("azitems.config")
--[[

	Highlighter module for highlighting work items in a buffer.

]]

---@class Highlighter
local Highlighter = {}

---@param buffer OpenedBuffer 
Highlighter.highlightWorkItemTemplate = function(self, buffer)
	-- lets set the first line to color
	vim.api.nvim_buf_set_extmark(buffer.bufnr, config.namespace, 1, 0, {
		line_hl_group = "Bug",
		hl_group = "Bug",
		hl_eol = true,
		hl_mode = "replace",
	})
end

return Highlighter
