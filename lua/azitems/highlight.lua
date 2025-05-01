local Config = require("azitems.config")

local namespace = 0

vim.api.nvim_set_hl(namespace, "Bug", { fg = "#fef3ef", bg = "#cc293d" })
vim.api.nvim_set_hl(namespace, "BugText", { fg = "#cc293d" })
vim.api.nvim_set_hl(namespace, "CreatedBy", { fg = "#fef3ef", bg = "#038aff" })
