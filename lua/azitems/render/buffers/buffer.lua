local templates = require("azitems.render.templates")
local highlighter = require("azitems.render.buffers.highlighter")
local config = require("azitems.config")
require("azitems.util.buffer")
local azure_api = require("azitems.azure.azure_api")

--types for the buffer
---@class BufferOpts 
---@field id string | number | nil this should be the id of whatever the buffer is showing
---@field name string | nil the name of the buffer
---@field listed boolean | nil if the buffer should be listed
---@field scratch boolean | nil if the buffer should be a scratch buffer
---@field events table | nil a table of events to subscribe to 
local BufferOpts = {
  id = nil,
	name = nil,
	listed = false,
	scratch = true,
	events = {},
}


---@class OpenedBuffer
---@field id string | number | nil this should be the id of whatever the buffer is showing
---@field name string | nil the name of the buffer
---@field bufnr number | nil the buffer number of the opened buffer
---@field win number | nil the window number of the opened buffer
---@field content string[] | nil
local OpenedBuffer = {
	id = nil,
	name = nil,
	bufnr = nil,
	win = nil,
	content = nil,
}

---@class BufferCache static
---BufferCache is a class that not only manages the open buffers in the current instance, but also handles the creation of new buffers and their lifecycle
local BufferCache = {
	opened = {},
}

BufferCache.__index = BufferCache

BufferCache.getBuffer = function(id)
	if BufferCache.opened[id] then
		return BufferCache.opened[id]
	end
	return nil
end

BufferCache.getBufferByName = function(name)
	for _, buffer in pairs(BufferCache.opened) do
		if buffer.name == name then
			return buffer
		end
	end
	return nil
end

BufferCache.getBufferByBufnr = function(bufnr)
	for _, buffer in pairs(BufferCache.opened) do
		if buffer.bufnr == bufnr then
			return buffer
		end
	end
	return nil
end

---@param bufobj OpenedBuffer
BufferCache.isBufferOpen = function(self, bufobj)
	if self.getBuffer(bufobj.id) ~= nil or
		self.getBufferByBufnr(bufobj.bufnr) or
		self.getBufferByName(bufobj.name) then
		return true
	end
	return false
end

BufferCache.closeBuffer = function(self, id)
	if self.opened[id] then
		local buffer = self.opened[id]
		vim.api.nvim_set_current_buf(buffer.bufnr)
		vim.cmd("q")
		buffer.id = nil
		--vim.api.nvim_buf_delete(buffer.bufnr, { force = true })
		self.opened[id] = nil
	end
end

BufferCache.closeAllBuffers = function(self)
	for _, buffer in pairs(self.opened) do
		self.closeBuffer(self, buffer.id)
	end
	self.opened = {}
end


--setup block

---@param opts BufferOpts 
---@return OpenedBuffer | nil
BufferCache.createBuffer = function(self, opts)
	if not opts.id then
		error("Buffer id is required")
	end
	if self.isBufferOpen(self, {name=opts.name, id=opts.id} ) then
		return nil
	end

	local bufferObj = {
		id = opts.id,
		name = opts.name,
		bufnr = vim.api.nvim_create_buf(opts.scratch, opts.listed),
	}

	if opts.name then
		vim.api.nvim_buf_set_name(bufferObj.bufnr, opts.name)
	end

	self.closeAllBuffers(self)
  self.opened[opts.id] = bufferObj

	-- Set the buffer maps 
	self.setupBuffer(self, bufferObj, opts.events)

	return bufferObj
end

BufferCache.setupBuffer = function(self, bufObj, events)
	--set generic keymaps
	vim.keymap.set('', 'q', function()
		if bufObj then
			self.closeBuffer(self, bufObj.id)
		end
	end, { buffer = bufObj.bufnr, desc = "Close buffer" })

	if events then
		for _, event in ipairs(events) do
			if type(event) == "function" then
				event(bufObj)
			end
		end
	end

end

--end of setupblock

---@class BufferStylizer
BufferStylizer = {}

---@param self BufferStylizer
---@param state State 
---@param bufferObj OpenedBuffer
---@return OpenedBuffer
BufferStylizer.stylizeToWorkItem = function(self, state, bufferObj)
	if not bufferObj then
		error("Buffer object is required")
	end

	local workItem = state:getState()

	if not workItem then
		error("WorkItem object is required")
	end

	local opts = {
		buf = bufferObj.bufnr,
	}

	---@param unsubscribe function
	local effect = function(unsubscribe)

		workItem = state:getState()
		if not workItem then

			workItem = {
				id = -1,
				fields = {
					workItemType = "Bug",
					title = "No Work Item",
					assignedTo = { displayName = "None" },
					state = "None",
					description = "No Description",
					createdBy = { displayName = "None" },
					changedBy = { displayName = "None" },
				},
			}
		end

		if not bufferObj.id then
			if unsubscribe then
				unsubscribe()
			end
			return
		end

		-- Set the buffer options
		vim.api.nvim_set_option_value("modifiable", true, opts)
		vim.api.nvim_set_option_value("readonly", false, opts)
		vim.api.nvim_set_option_value("buftype", "nofile", opts)
		vim.api.nvim_set_option_value("bufhidden", "wipe", opts)
		vim.api.nvim_set_option_value("swapfile", false, opts)
		vim.api.nvim_set_option_value("filetype", "markdown", opts)

		bufferObj.content = vim.split(templates.getWorkItemTemplate(workItem), "\n", { plain = true })
		-- Set some sample text
		highlighter:clearHighlights(bufferObj)

		local cursorPos = vim.api.nvim_win_get_cursor(0)

		vim.api.nvim_buf_set_lines(bufferObj.bufnr, 0, -1, false, {})
		vim.api.nvim_buf_set_lines(bufferObj.bufnr, 2, -1, false, bufferObj.content)

		--set the cursor position to where it was
		vim.api.nvim_win_set_cursor(0, { cursorPos[1], cursorPos[2] })

		highlighter:highlightWorkItemTemplate(bufferObj)

		vim.api.nvim_set_option_value("readonly", true, opts)
		vim.api.nvim_set_option_value("modifiable", false, opts)
	end

	effect(state:subscribe(effect))

  return bufferObj
end



---@class Buffer
local Buffer = {}

---@param state State 
---@return OpenedBuffer | nil	
Buffer.createWorkItem = function(state, opts)

	---@type WorkItem
	local workitem = state:getState()
	if not workitem then
		error "Work Item Null"
	end

	---@type BufferOpts
	local bufferOpts = {
		id = workitem.id or opts.id,
		name = "azitems:" .. (workitem.id or opts.name),
		events = {
			function(bufObj)
				vim.keymap.set('', '<Tab>', function()
					workitem = state:getState()
					workitem.fields.workItemType = "Ready for Code Review"
					azure_api:mutateWorkItem(workitem, function(result) state:setState(result) end)
				end, { buffer = bufObj.bufnr, desc = "Open work item in browser" })
			end,
		} or opts.events,
	}

	local bufferObj = BufferCache:createBuffer(bufferOpts)
	if not bufferObj then
		return
	elseif not bufferObj.bufnr then
		error("Buffer not created")
	end

	bufferObj = BufferStylizer:stylizeToWorkItem(state, bufferObj)

	return bufferObj
end

---@param workitem State 
Buffer.openWorkItem = function(workitem)
	-- create new buffer
	local bufferObj = Buffer.createWorkItem(workitem)
	if not bufferObj then
		return
	end

  vim.cmd("vsplit") -- or "split", "tabnew", etc.
	bufferObj.win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(bufferObj.win, bufferObj.bufnr)
	vim.api.nvim_set_current_win(bufferObj.win)
end

return Buffer
