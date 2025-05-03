local config = require("azitems.config")
local person = require("azitems.azure.model.person")
local WorkItemField = require("azitems.azure.model.workitemfield")
local WorkItem      = require("azitems.azure.model.workitem")
local state         = require("azitems.render.state")
require("azitems.util")
require("azitems.azure.api.api")
require("azitems.azure.api.query")
require("azitems.azure.api.parser")
require("azitems.azure.api.cache")


---@class AzureApi
AzureApi = {}

function fakeWorkItem3()
	local AssignedTo = {
		displayName = "Lopez, Maria",
		url = "https://spsprodcus1.vssps.visualstudio.com/_apis/Identities/ffeeddcc-bbaa-9988-7766-554433221100",
		id = "ffeeddcc-bbaa-9988-7766-554433221100",
		uniqueName = "mlopez@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.ffeeddccbbaa99887766554433221100",
		descriptor = "aad.ffeeddccbbaa99887766554433221100"
	}

	local CreatedBy = {
		displayName = "Singh, Raj",
		url = "https://spsprodcus1.vssps.visualstudio.com/_apis/Identities/11223344-5566-7788-99aa-bbccddeeff00",
		id = "11223344-5566-7788-99aa-bbccddeeff00",
		uniqueName = "rsingh@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.112233445566778899aabbccddeeff00",
		descriptor = "aad.112233445566778899aabbccddeeff00"
	}

	local ChangedBy = {
		displayName = "Taylor, Chris",
		url = "https://spsprodcus1.vssps.visualstudio.com/_apis/Identities/00112233-4455-6677-8899-aabbccddeeff",
		id = "00112233-4455-6677-8899-aabbccddeeff",
		uniqueName = "ctaylor@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.00112233445566778899aabbccddeeff",
		descriptor = "aad.00112233445566778899aabbccddeeff"
	}

	local WorkItemFields = {
		title = "API returns 500 when given invalid token",
		areaPath = "A5\\Backend",
		teamProject = "A5",
		iterationPath = "A5\\Sprint 07",
		workItemType = "Bug",
		state = "Closed",
		reason = "Resolved and deployed",
		assignedTo = AssignedTo,
		createdDate = "2025-04-20T10:03:25.000Z",
		createdBy = CreatedBy,
		changedDate = "2025-04-21T14:45:33.000Z",
		changedBy = ChangedBy,
		communtCount = 2,
		priority = 1,
		severity = "Critical",
		valueArea = "Backend"
	}

	local workItem = {
		id = 35290,
		fields = WorkItemFields
	}

	return workItem
end

function fakeWorkItem2()
	local AssignedTo = {
		displayName = "Nguyen, Linda",
		url = "https://spsprodcus1.vssps.visualstudio.com/_apis/Identities/1a2b3c4d-5678-90ab-cdef-1234567890ab",
		id = "1a2b3c4d-5678-90ab-cdef-1234567890ab",
		uniqueName = "lnguyen@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.1a2b3c4d567890abcdef1234567890ab",
		descriptor = "aad.1a2b3c4d567890abcdef1234567890ab"
	}

	local CreatedBy = {
		displayName = "Smith, Jordan",
		url = "https://spsprodcus1.vssps.visualstudio.com/_apis/Identities/abc12345-6789-def0-1234-56789abcdef0",
		id = "abc12345-6789-def0-1234-56789abcdef0",
		uniqueName = "jsmith@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.abc123456789def0123456789abcdef0",
		descriptor = "aad.abc123456789def0123456789abcdef0"
	}

	local ChangedBy = {
		displayName = "Chen, Alice",
		url = "https://spsprodcus1.vssps.visualstudio.com/_apis/Identities/98fedcba-7654-3210-fedc-ba9876543210",
		id = "98fedcba-7654-3210-fedc-ba9876543210",
		uniqueName = "achen@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.98fedcba76543210fedcba9876543210",
		descriptor = "aad.98fedcba76543210fedcba9876543210"
	}

	local WorkItemFields = {
		title = "Dashboard layout is broken on smaller screens",
		areaPath = "A5",
		teamProject = "A5",
		iterationPath = "A5\\Sprint 08",
		workItemType = "Bug",
		state = "Active",
		reason = "Investigating",
		assignedTo = AssignedTo,
		createdDate = "2025-04-22T13:14:01.000Z",
		createdBy = CreatedBy,
		changedDate = "2025-04-23T08:56:44.000Z",
		changedBy = ChangedBy,
		communtCount = 0,
		priority = 2,
		severity = "High",
		valueArea = "User Experience"
	}

	local workItem = {
		id = 35289,
		fields = WorkItemFields
	}

	return workItem
end

function fakeWorkItem1()

	local AssignedTo = {
		displayName = "Erdogan, Kevin",
		url = "https://spsprodcus1.vssps.visualstudio.com/Ab92fa016-875f-4263-b915-52e419325c7f/_apis/Identities/ea20a224-308f-64e4-8214-c5899ca7730e",
		id = "ea20a224-308f-64e4-8214-c5899ca7730e",
		uniqueName = "kerdogan@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.ZWEyMGEyMjQtMzA4Zi03NGU0LTgyMTQtYzU4OTljYTc3MzBl",
		descriptor = "aad.ZWEyMGEyMjQtMzA4Zi03NGU0LTgyMTQtYzU4OTljYTc3MzBl"
	}

	local CreatedBy = {
		displayName = "Penalo, Isac",
		url = "https://spsprodcus1.vssps.visualstudio.com/Ab92fa016-875f-4263-b915-52e419325c7f/_apis/Identities/c64a47d0-dafa-677a-80b4-05bfca3fe680",
		id = "c64a47d0-dafa-677a-80b4-05bfca3fe680",
		uniqueName = "ipenalo@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.YzY0YTQ3ZDAtZGFmYS03NzdhLTgwYjQtMDViZmNhM2ZlNjgw",
		descriptor = "aad.YzY0YTQ3ZDAtZGFmYS03NzdhLTgwYjQtMDViZmNhM2ZlNjgw"
	}

	local ChangedBy = {
		displayName = "Boylan, Robert",
		url = "https://spsprodcus1.vssps.visualstudio.com/Ab92fa016-875f-4263-b915-52e419325c7f/_apis/Identities/bd4af2fb-7de9-60c1-84a3-8c61583e8f44",
		id = "bd4af2fb-7de9-60c1-84a3-8c61583e8f44",
		uniqueName = "rboylan@lbisoftware.com",
		imageUrl = "https://dev.azure.com/lbisoftware/_apis/GraphProfile/MemberAvatars/aad.YmQ0YWYyZmItN2RlOS03MGMxLTg0YTMtOGM2MTU4M2U4ZjQ0",
		descriptor = "aad.YmQ0YWYyZmItN2RlOS03MGMxLTg0YTMtOGM2MTU4M2U4ZjQ0"
	}

	---@type WorkItemFields
	local WorkItemFields = {
		title = "Multiple screen summary does not match requirements",
		areaPath = "A5",
		teamProject = "A5",
		iterationPath = "A5\\Sprint 08",
		workItemType = "Bug",
		state = "Closed",
		reason = "Fixed and verified",
		assignedTo = AssignedTo,
		createdDate = "2025-04-24T20:23:59.883Z",
		createdBy = CreatedBy,
		changedDate = "2025-04-25T18:11:14.033Z",
		changedBy = ChangedBy,
		communtCount = 1,
		priority = nil,
		severity = nil,
		valueArea = nil
	}
	local workItem = {
		id = 35288,
		fields = WorkItemFields
	}

	return workItem
end


---@class AzureCache
local AzureCache = {}




local function fakeWorkItems()
	return {
		fakeWorkItem1(),
		fakeWorkItem2(),
		fakeWorkItem3(),
	}
end

function AzureApi:getWorkItems()

	local workitems = {}
	local workitemIds = QueryApi:executeQuery(config.config.azure.workitem.query)
	-- get all workitem ids from query
	workitemIds = Map(function(tbl) return tbl.id end, workitemIds.workItems)
	-- store nonCached ids in tempArray
	local tempArray = {}
	for _, id in ipairs(workitemIds) do
		local cached = WorkItemCache:getItem(id)
		if not cached then
			table.insert(tempArray, id)
			goto continue
		else
			table.insert(workitems, cached:getData())
		end
	  ::continue::
	end
	--set workitemIds to tempArray
	workitemIds = tempArray
	local remainingWorkItemIds = #workitemIds
	vim.notify("Fetching " .. remainingWorkItemIds .. " work items", vim.log.levels.INFO)
  while remainingWorkItemIds > 0 do
		local slice = Slice(workitemIds, 0, 200)
		local currentFetch = slice.sliced
		workitemIds = slice.remaining
		remainingWorkItemIds = #workitemIds
		---@type FetchOpts
		local opts = {
			requestMethod = "post",
			headers = {},
			url = "https://dev.azure.com/" .. "lbisoftware" .. "/" .. "A5" .. "/" .. "_apis/wit/workitemsbatch?api-version=7.2-preview.1",
			org = "lbisoftware",
			project = "A5",
			body = {
				ids = currentFetch,
			},
		}
		local preWorkItems = AzureFetch(opts)
		PushMass(workitems, Parser.parseWorkItems(preWorkItems))
  end

	local statefulWorkItems = {}
	---@param value WorkItem
	for index, value in ipairs(workitems) do
		statefulWorkItems[index] = state:new(value)
		WorkItemCache:cacheItem(value.id, "workitem", value)
	end

	return statefulWorkItems
end

---@param workItem WorkItem
---@param callback function
function AzureApi:mutateWorkItem(workItem, callback, mutation)
	-- call api and update workItem
	-- ...
	return callback(workItem)
end

return AzureApi
