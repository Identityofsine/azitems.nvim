local config = require("azitems.config")
require("azitems.util")

---@class CachedItem
---@field private _id string
---@field private _type string (workitem, query, etc)
---@field private _cachedAt number
---@field private _data table
local CachedItem = {
}

function CachedItem:new(opts)
	local obj = Merge({
		_id = -1,
		_cachedAt = os.time(),
		_type = ""
	}, opts)
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function CachedItem:getId()
	return self._id
end

function CachedItem:getType()
	return self._type
end

function CachedItem:getData()
	return self._data
end

function CachedItem:getCachedAt()
	return self._cachedAt
end

---@class Cache
---@field private _cache table
---^ pulled from config
local Cache = {
}

--- Methods
function Cache:new()
	local obj = {
		_cache = {},
	}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Cache:clear()
	self._cache = {}
end

function Cache:cacheItem(id, type, data)
	if config.config.api.cache.enabled == false then
		return
	end
	---@type CachedItem
	local item = CachedItem:new({
		_id = id,
		_type = type,
		_data = data,
		_cachedAt = os.time(),
	})
	self._cache[id] = item
end

---@param id string
---@return CachedItem | nil
function Cache:getItem(id)

	if config.config.api.cache.enabled == false then
		return nil
	end

	---@type CachedItem
	local item = self._cache[id]
	if item then
		if item:getCachedAt() + config.config.api.cache.refreshTime < os.time() then
			self._cache[id] = nil
			return nil
		else
			return item
		end
	else
		return nil
	end
end




---chace the item
---@type Cache
WorkItemCache = Cache:new()
---cache the results
---@type Cache
QueryCache = Cache:new()


