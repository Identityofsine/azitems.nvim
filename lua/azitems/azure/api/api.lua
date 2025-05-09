local config = require("azitems.config")

-- http
local curl = require("plenary.curl")

---@class FetchOpts
FetchOpts = {
	url = "",
	requestMethod = "get",
	org = nil,
	project = nil,
	callback = nil,
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

	local freshOpts = {
		project = config.config.azure.project,
		org = config.config.azure.org,
	}

	---@type FetchOpts
	local fOpts = Merge(FetchOpts, freshOpts)
	fOpts = Merge(fOpts, opts or {})
  local jStatus, json_body = pcall(vim.json.encode, (fOpts.body))
	if not jStatus then
		vim.notify("AzureFetch: Error encoding body to JSON: " .. json_body, vim.log.levels.ERROR)
		return nil
	end

	local curl_method = curl[fOpts.requestMethod]
	if not curl_method then
		vim.notify("AzureFetch: Invalid request method: " .. tostring(fOpts.requestMethod), vim.log.levels.ERROR)
		return nil
	end

	local postRequestSync = function(body)
		if body.error then
			vim.notify("Error fetching data from Azure DevOps: " .. body.error, vim.log.levels.ERROR)
			return nil
		end
		return vim.json.decode(body.body)
	end

	if opts.callback then
		fOpts.callback = function(body)
			local status, rBody = pcall(postRequestSync, (body))
			if not status then
				vim.notify("Error parsing response from Azure DevOps: " .. rBody, vim.log.levels.ERROR)
				return nil
			end
			if rBody then
				opts.callback(rBody)
			else
				vim.notify("Error fetching data from Azure DevOps: " .. body.error, vim.log.levels.ERROR)
			end
		end
	end

	local body = curl_method({
		url = fOpts.url,
		body = json_body,
		callback = fOpts.callback,
		headers = Merge(opts.headers, {
			["Content-Type"] = "application/json",
			["Content-Length"] = tostring(#json_body),
			["Authorization"] = "Bearer" .. config.config.azure.patToken,
		}),
	})

	if fOpts.callback then
		return nil
	end

	return postRequestSync(body)

end


