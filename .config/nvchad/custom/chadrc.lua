local M = {}
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

-- relative line numbers by default
vim.opt.rnu = true

-- M.mapings = require "custom.mappings"

return M
