---@class CommentAPI
---@field workItemId number
---@field commentId number 
---@field createdBy PersonAPI
---@field createdDate string
---@field text string
---@field modifiedBy PersonAPI
---@field modifiedDate string
---@field url string
---@field isDeleted boolean
local CommentAPI = {
	workItemId = -1,
	commentId = -1,
	createdDate = "",
	text = "",
	modifiedDate = "",
	url = "",
	isDeleted = false,
}


---@class Comment
---@field id number 
---@field workItemId number
---@field createdBy Person
---@field createdDate string
---@field text string
---@field modifiedBy Person
---@field modifiedDate string
---@field url string 
---@field isDeleted boolean
local Comment = {
	id = 0,
	workItemId = -1,
	text = "",
}

