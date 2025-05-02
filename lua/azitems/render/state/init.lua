---@class State
---@field _value unknown
---@field subscribers table 
local State = {
	_value = nil,
	_subscribers = {}
}

---@param callback function
function State:subscribe(callback)
	vim.print("subscribing to state")
	local insertId = #self._subscribers + 1
	local unsub = function()
		self.subscribers[insertId] = nil
	end
	local callbackWrapper = function() callback(unsub) end
	table.insert(self._subscribers, insertId, callbackWrapper)

	return unsub
end

function State:_emit()
	if not self._subscribers then
		return
	end
	for _, value in ipairs(self._subscribers) do
		value(self._value)
	end
end

---@param state unknown | function
function State:setState(state)
	if type(state) == "function" then
		state = state(self._value)
	else
		self._value = state
	end
	self:_emit()
end

function State:getState()
	return self._value
end

function State:new(initalValue)
	local instance = setmetatable({}, self)
	self.__index = self
	self.subscribers = {}
	instance._value = initalValue
	return instance
end

return State
