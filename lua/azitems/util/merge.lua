function Merge(defaults, overrides)
	local copy = vim.deepcopy(defaults)
	for k, v in pairs(overrides) do
		if type(v) == "table" and type(copy[k]) == "table" then
			copy[k] = Merge(copy[k], v)
		else
			copy[k] = v
		end
	end
	return copy
end
