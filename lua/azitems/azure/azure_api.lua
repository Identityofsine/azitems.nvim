local config = require("azitems.config")
local person = require("azitems.azure.model.person")
local WorkItemField = require("azitems.azure.model.workitemfield")
local WorkItem      = require("azitems.azure.model.workitem")

print("Azure API module loaded")
print("Config: ", config.config.azure.patToken)

---@class AzureApi
local AzureApi = {}


function fakeWorkItemCall()

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

function AzureApi:getWorkItems()


	local items =  {
		fakeWorkItemCall(),
		fakeWorkItemCall(),
		fakeWorkItemCall(),
	}

	return items
end

return AzureApi
