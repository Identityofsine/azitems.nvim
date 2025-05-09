function Filter(tbl, predicate)
	local result = {}
	for _, value in ipairs(tbl) do
		if predicate(value) then
			table.insert(result, value)
		end
	end
	return result
end
