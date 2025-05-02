local module = require("azitems")


vim.api.nvim_create_user_command("AZWorkItems", module.workItems, {})
