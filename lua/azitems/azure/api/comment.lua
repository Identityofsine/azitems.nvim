require("azitems.azure.api.api")
require("azitems.azure.api.parser")
require("azitems.util")


---@class CommentApi
CommentApi = {}

local CommentsEndpoint = "https://dev.azure.com/{{org}}/{{project}}/_apis/wit/workItems/{{workitemid}}/comments?api-version=7.2-preview.4"


---@param workItemId number
---@return table
function CommentApi:getComments(workItemId, opts)
	opts = opts or {}
	local mergedOpts = Merge({
		requestMethod = "get",
		headers = {},
		url = CommentsEndpoint:gsub("{{org}}", "lbisoftware"):gsub("{{project}}", "A5"):gsub("{{workitemid}}", workItemId),
		org = "lbisoftware",
		project = "A5",
	}, opts)

	local cb = function(body)
		if not body or not body.comments then
			return {}
		end
		---@type CommentApi[] 
		local c = body.comments
		local comments = Parser.parseComments(c)
		return comments
	end

	if opts.callback then
		mergedOpts.callback = function(body)
			local comments = cb(body)
			opts.callback(comments)
		end
	end

	local resposeBody = AzureFetch(mergedOpts)

	return cb(resposeBody)
end
