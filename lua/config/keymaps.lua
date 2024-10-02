-- global
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

-- testing
vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ti", ":TestInfo", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast", { silent = true, noremap = true })
