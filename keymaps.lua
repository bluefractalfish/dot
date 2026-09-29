-- Goyo toggle

vim.g.goyo_width=85
vim.keymap.set("n", "<leader>z", ":Goyo<CR>", { desc = "Toggle Goyo" })

-- Goyo + Pencil integration
vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoEnter",
  callback = function()
    vim.cmd("Pencil")
    vim.cmd.colorscheme("kuiet")
    -- writing mode settings
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.spell = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoLeave",
  callback = function()
    vim.cmd("NoPencil")

    -- restore defaults
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.wrap = false
    vim.opt.spell = false
  end,
})
