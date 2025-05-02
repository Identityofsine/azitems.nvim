local config = require("azitems.config")
--[[

	Highlighter module for highlighting work items in a buffer.

]]

---@class Highlighter
local Highlighter = {}

Highlighter.clearHighlights = function(self, buffer)
	-- clear all extmarks
	vim.api.nvim_buf_clear_namespace(buffer.bufnr, 0, 0, -1)
end

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
	if not buffer.content then
		return
	end
	---@type string[]
	local content = buffer.content
	--catch all bold characters
	local isInsideBoldTag = -1
	for i = 1, #content, 1 do
		local str = content[i]
		for c = 1, str:len() - 1, 1 do
			local char = str:sub(c,c)
			if char == '*' then
				if str:sub(c + 1, c + 1) == '*' then
					if isInsideBoldTag > -1 then
						vim.api.nvim_buf_set_extmark(buffer.bufnr, config.namespace, i, isInsideBoldTag, {
							hl_group = "CreatedBy",
							end_col = c - 1,
							hl_mode = "replace",
						})
						isInsideBoldTag = -1
					else
						c = c + 1
						isInsideBoldTag = c
					end
				end
			end
		end
	end
end

return Highlighter
