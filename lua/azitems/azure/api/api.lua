local config = require("azitems.config")

-- http
local curl = require("plenary.curl")

---@class FetchOpts
FetchOpts = {
	requestMethod = "get",
	org = "lbisoftware",
	project = "A5",
	body = {},
	headers = {
		["Content-Type"] = "application/json",
	},
}

---@param opts FetchOpts
function AzureFetch(opts)

	if config.config.azure.patToken == "" then
		vim.notify("Azure PAT token is not set", vim.log.levels.ERROR)
		return nil
	end

	opts = Merge(opts, FetchOpts)

  local json_body = vim.json.encode({
    ids = {35389, 35403, 35288, 35405, 35406},
  })
	local body = curl.post({
		url = "https://dev.azure.com/" .. opts.org .. "/" .. opts.project .. "/" .. "_apis/wit/workitemsbatch?api-version=7.2-preview.1",
		body = json_body,
		headers = Merge(opts.headers, {
			["Content-Length"] = tostring(#json_body),
			["Authorization"] = "Bearer" .. config.config.azure.patToken,
		}),
	})
	if body.error then
		return nil
	end

	return vim.json.decode(body.body)
end


