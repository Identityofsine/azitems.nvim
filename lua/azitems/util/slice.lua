---@param tbl table
---@param startIndex number
---@param endIndex number
---@return {sliced:table, remaining:table}
function Slice(tbl, startIndex, endIndex)
	local sliced = {}
	local remaining = {}

	for i, v in ipairs(tbl) do
		if i >= startIndex and i <= endIndex then
			table.insert(sliced, v)
		else
			table.insert(remaining, v)
		end
	end

	return {
		sliced = sliced,
		remaining = remaining
	}

end
