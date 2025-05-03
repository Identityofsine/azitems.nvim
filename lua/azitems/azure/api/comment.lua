require("azitems.azure.api")
require("azitems.azure.parser")


---@class CommentApi
local CommentApi = {}

local CommentsEndpoint = "https://dev.azure.com/{{org}}/{{project}}/_apis/wit/workItems/{{workitemid}}/comments?api-version=7.2-preview.4"


---@param workItemId number
---@return table
function CommentApi:getComments(workItemId)
	local body = AzureFetch({
		requestMethod = "get",
		headers = {},
		url = CommentsEndpoint:gsub("{{org}}", "lbisoftware"):gsub("{{project}}", "A5"):gsub("{{workitemid}}", workItemId),
		org = "lbisoftware",
		project = "A5",
	})
	if not body or not body.value then
		return {}
	end
	---@type CommentAPI[] 
	local c = body.comments
	local comments = Parser.parseComments(c)

	return comments
end
