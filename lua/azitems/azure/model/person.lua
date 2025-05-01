---@class Person
--azure defined person
local Person = {
	displayName = nil,
	id = nil,
	url = nil,
	uniqueName = nil,
	imageUrl = nil,
	descriptor = nil,
}

Person.__index = Person

Person.hack = function()
	-- This is a hack to ensure that the Person class is not garbage collected
	-- and can be used in other modules.
	-- This is a workaround for the fact that Lua does not have a built-in way
	-- to prevent garbage collection of objects.
	return false
end

function Person:constructor(displayName, id, url, uniqueName, imageUrl, descriptor)
	---@type Person
	local self = {}
	self.displayName = displayName or ""
	self.id = id or -1
	self.url = url or ""
	self.uniqueName = uniqueName or ""
	self.imageUrl = imageUrl or ""
	self.descriptor = descriptor or ""

	return self
end

return Person
