require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Normal mode mappings
map("n", ";", ":")
map("n", "<C-p>", ":Telescope find_files <CR>")
map("n", "<A-]>", ":cnext <CR>")
map("n", "<A-[>", ":cprev <CR>")
map("n", "<C-x>", ":bd<CR>")
map("n", "<S-h>", "_")
map("n", "<S-l>", "$")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Visual mode mappings
map("v", "<S-h>", "_")
map("v", "<S-l>", "$")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

-- Oil
map("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })
