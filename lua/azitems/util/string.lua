local icons = {
	bug="",
	deploymentPlan="",
	feature="",
	issue="󱍼",
	qaTask="",
	sharedSteps="󰓍",
	task="",
	testCase="󰙨",
	testSuite="󰮜",
	story="",
}


local WorkTypeTable = {}

---@param string string
WorkTypeTable["Bug"] = function(string)
	return icons.bug .. " " .. string
end

WorkTypeTable["Deployment Plan"] = function(string)
	return icons.deploymentPlan .. " " .. string
end

WorkTypeTable["Feature"] = function(string)
	return icons.feature .. " " .. string
end

WorkTypeTable["Issue"] = function(string)
	return icons.issue .. " " .. string
end

return WorkTypeTable
