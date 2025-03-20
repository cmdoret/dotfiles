local M = {}

-- run system command base64 encode/decode
M.general = {
 v = {
  ["<leader>be"] = {"c<c-r>=system('base64 --wrap=0', @\")<cr><esc>", "Base64 Encode"},
  ["<leader>bd"] = {"c<c-r>=system('base64 --wrap=0 -d', @\")<cr><esc>", "Base64 Decode"},
  }
}

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
