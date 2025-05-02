---@class State
---@field _value unknown
---@field subscribers function[] 
local State = {
	_value = nil,
	_subscribers = {}
}

---@param callback function
State._subscribe = function(self, callback)
	self.subscribers[callback] = callback
	return function()
		self.subscribers[callback] = nil
	end
end

State._emit = function(self)
	for _, value in ipairs(self._subscribers) do
		value(self._value)
	end
end

State.setState = function(self, state)
	self._value = state
	self:_emit()
end

State.getState = function(self, state)
	return self._value
end
