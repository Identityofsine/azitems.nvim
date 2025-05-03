
---@param func function
---func will act as a function that goes through each element in the table, it's return value will be used as the new value for that element in a new table
---@param tbl table
---tbl will be the table that we want to map over, it can be any table
function Map(func, tbl)
	if type(func) ~= "function" then
		error("func must be a function")
	end
	if type(tbl) ~= "table" then
		error("tbl must be a table")
	end

	local newTable = {}
	for i, v in ipairs(tbl) do
		newTable[i] = func(v)
	end

	return newTable
end
