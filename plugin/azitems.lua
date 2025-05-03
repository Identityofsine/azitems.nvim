local module = require("azitems")


vim.api.nvim_create_user_command("AZWorkItems", module.workItems, {
	desc="Get Azure DevOps Work Items"
})
vim.api.nvim_create_user_command("AZQueries", module.queries, {
	desc="Get Azure DevOps Queries",
})
vim.api.nvim_create_user_command("AZClearCache", module.clearCache, {
	desc="Clear Azure Work Item Cache"
})
