---@class PersonAPI
---@field displayName string
---@field url string
---@field _links table
---@field _links.avatar table
---@field _links.avatar.href string
---@field id string
---@field uniqueName string
---@field imageUrl string
---@field descriptor string
local PersonAPI = {
	displayName = nil,
	url = nil,
	_links = {
		avatar = {
			href = nil -- string (URL)
		}
	},
	id = nil, -- string (GUID)
	uniqueName = nil, -- string (email)
	imageUrl = nil, -- string (URL)
	descriptor = nil -- string
}



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

function Person:constructor(opts)
	---@type Person
	local self = {}
	if not opts then
		opts = {}
	end
	self.displayName = opts.displayName or ""
	self.id = opts.id or -1
	self.url = opts.url or ""
	self.uniqueName = opts.uniqueName or ""
	self.imageUrl = opts.imageUrl or ""
	self.descriptor = opts.descriptor or ""

	return self
end

return Person
