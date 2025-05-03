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
	default="󰈙",
}


WorkTypeTable = {}

---@param key string 
function WorkTypeTable:get(key)
	if self[key] then
		return self[key]
	end
	return self["default"]
end



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

WorkTypeTable["QA Task"] = function(string)
	return icons.qaTask .. " " .. string
end

WorkTypeTable["Shared Steps"] = function(string)
	return icons.sharedSteps .. " " .. string
end

WorkTypeTable["Task"] = function(string)
	return icons.task .. " " .. string
end

WorkTypeTable["Test Case"] = function(string)
	return icons.testCase .. " " .. string
end

WorkTypeTable["Test Suite"] = function(string)
	return icons.testSuite .. " " .. string
end

WorkTypeTable["User Story"] = function(string)
	return icons.story .. " " .. string
end

WorkTypeTable["default"] = function(string)
	return icons.default .. " " .. string
end

return WorkTypeTable
