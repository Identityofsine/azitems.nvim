local config = require("azitems.config")

-- http
local curl = require("plenary.curl")

---@class FetchOpts
FetchOpts = {
	url = "",
	requestMethod = "get",
	org = "lbisoftware",
	project = "A5",
	body = {},
	headers = {
		["Content-Type"] = "application/json",
	},
}

---@param opts FetchOpts
---@return table
function AzureFetch(opts)

	if config.config.azure.patToken == "" then
		vim.notify("Azure PAT token is not set", vim.log.levels.ERROR)
		return nil
	end

	---@type FetchOpts
	local fOpts = Merge(FetchOpts, opts)
  local json_body = vim.json.encode(fOpts.body)

	local body = curl[opts.requestMethod]({
		url = fOpts.url,
		body = json_body,
		headers = Merge(opts.headers, {
			["Content-Type"] = "application/json",
			["Content-Length"] = tostring(#json_body),
			["Authorization"] = "Bearer" .. config.config.azure.patToken,
		}),
	})
	if body.error then
		vim.notify("Error fetching data from Azure DevOps: " .. body.error, vim.log.levels.ERROR)
		return nil
	end

	return vim.json.decode(body.body)
end


