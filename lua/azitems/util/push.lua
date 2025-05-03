
---@param arr table
---@param tbl table
function PushMass(arr, tbl)
	if not tbl then
		return arr
	end
	if not arr then
		arr = {}
	end
	for i, v in ipairs(tbl) do
		table.insert(arr, v)
	end
end
