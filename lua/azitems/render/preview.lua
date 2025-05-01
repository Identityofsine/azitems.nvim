local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

local templates     = require("azitems.render.templates")

local preview = {}


---@param workitem WorkItem
preview._workitem = function(workitem)
	local preview_text = string.format(
		"# %d %s\n\nAssigned To: %s\nState: %s\nDescription: %s",
		workItem.id,
		workItem.fields.title,
		workItem.fields.assignedTo.displayName,
		workItem.fields.state,
		workItem.fields.description
	)

	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(bufnr, 1, -1, false, vim.split(preview_text, "\n"))
	vim.api.nvim_buf_set_option(bufnr, "filetype", "md")

	return bufnr
end


preview.workitem = function(previewer, entry, status)
	local workItem = entry.value
	local preview_text = templates.getWorkItemTemplate(workItem)

	previewer.state.bufnr = previewer.state.bufnr or vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(previewer.state.bufnr, "buftype", "nofile")
	vim.api.nvim_buf_set_option(previewer.state.bufnr, "filetype", "markdown")
	vim.api.nvim_buf_set_lines(previewer.state.bufnr, 1, -1, false, vim.split(preview_text, "\n"))

end

return preview
