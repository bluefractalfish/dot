require("config.lazy")
require("config.options")

local npairs = require("nvim-autopairs")

vim.keymap.set("i", "<Tab>", function()
  local column = vim.fn.col(".")
  local next_character = vim.fn.getline("."):sub(column, column)

  if next_character:match('[%)%]%}"\'`]') then
    return "<Right>"
  end

  return "<Tab>"
end, { expr = true })

local function apply_transparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

local function change_colors()
    vim.api.nvim_set_hl(0,"Comment", {fg="#eeaa00"})
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_transparency,
})

vim.cmd.colorscheme("retrobox")
apply_transparency()
change_colors()

