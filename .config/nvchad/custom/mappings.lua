local M = {}

M.maximizer = {
  n = {
    ["<leader>mm"] = {"<cmd> MaximizerToggle <CR>", "Maximize"},
  },
}

-- include hidden files, except for .git
M.telescope = {
  n = {
    ["<leader>ff"] = {"<cmd> Telescope find_files find_command=rg,--hidden,--files,--glob,!.git <CR>", "Find File"},
  },
}

return M
