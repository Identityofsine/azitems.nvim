local Buffer = require("azitems.render.buffers")
local Preview = require("azitems.render.preview")

local renderers = {}

renderers.preview = Preview
renderers.buffer = Buffer

return renderers
