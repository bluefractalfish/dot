
-- minimal single-file colorscheme
-- :colorscheme mytheme
vim.g.colors_name = "kuiet"
vim.opt.termguicolors = true

local ITALIC = vim.g.kuiet_italics ~= true
local ITALIC = vim.g.kuiet_bold ~= true

local function hi(group, val) vim.api.nvim_set_hl(0, group, val) end
local function link(a,b) vim.api.nvim_set_hl(0, a, {link=b}) end

-- palette
-- in order of visibility -> importance
--
local orng = "#FF5E33"
local blue = "#325aaF"
local lblu = "#89CFF0"
local yell = "#FFC915"
local lght = "#eeeeee"
local midm = "#acacac"
local dark = "#575757"
local lgrn = "#ffffff"
local blck = "#121217"
--
local bg    = none

-- Core UI
hi("Normal",       { fg = lght, bg = bg })
hi("NormalFloat",  { fg = orng, bg = blck })
hi("FloatBorder",  { fg = midm, bg = blck })
hi("CursorColumn", { bg = orng })
hi("LineNr",       { fg = dark})
hi("CursorLineNr", { fg = orng })
--hi("CursorLine",   { fg = fg})
hi("SignColumn",   { bg = bg  })
hi("WinSeparator", { fg = orng })
hi("ModeMsg",      { fg = orng })
hi("ErrorMsg",     { fg = orng })
hi("MsgArea",      { fg = orng, bold=true })
hi("Question",     { fg = orng})

-- Editor
hi("Visual",       { bg = orng, fg=blue, bold=true })
hi("Search",       { fg = blck, bg = orng, bold = true })
hi("IncSearch",    { fg = blck, bg = orng, bold = true })
hi("MatchParen",   { fg = orng, bg=bg, bold=true })

-- Syntax
hi("Comment",      { fg = dark, italic=true})
hi("Constant",     { fg = blck, bg=lght, bold = true })
hi("String",       { fg = lgrn, bold=true  })

hi("Character",    { fg = lght })
hi("Number",       { fg = yell, bold=true })
hi("Boolean",      { fg = midm })
hi("Identifier",   { fg = yell })
hi("Function",     { fg = orng, bold=true })
hi("Statement",    { fg = orng, bold=true})
hi("Conditional",  { fg = lght,italic=true })
hi("Repeat",       { fg = dark, bold=true})
hi("Operator",     { fg = lght })
hi("Keyword",      { fg = lght, bold=true})
hi("Type",         { fg = orng, bold=true })
hi("Special",      { fg = midm, bold=true })
hi("Todo",         { fg = bg, bg = orng, bold = true })

-- Diagnostics/LSP
hi("DiagnosticError", { fg = blck })
hi("DiagnosticWarn",  { fg = yell })
hi("DiagnosticInfo",  { fg = lblu })
hi("DiagnosticHint",  { fg = lblu })
hi("DiagnosticUnderblckError", { undercurl = true, sp = lght })
hi("DiagnosticUnderblckWarn",  { undercurl = true, sp = yell })
hi("DiagnosticUnderblckInfo",  { undercurl = true, sp = lght })
hi("DiagnosticUnderblckHint",  { undercurl = true, sp = lght })
hi("LspReferenceText",  { bg = orng })
hi("LspReferenceRead",  { bg = orng })
hi("LspReferenceWrite", { bg = orng })

-- Treesitter (new-style @ groups)
hi("@comment",      { link = "Comment" })
hi("@string",       { link = "String" })
hi("@number",       { link = "Number" })
hi("@boolean",      { link = "Boolean" })
hi("@function",     { link = "Function" })
hi("@method",       { link = "Function" })
hi("@constructor",  { fg = lght })
hi("@parameter",    { fg = orng })
hi("@field",        { fg = orng, bold=true})
hi("@property",     { fg = lght, bg=blck, bold=true})
hi("@type",         { link = "Type" })
hi("@keyword",      { link = "Keyword" })
hi("@operator",     { link = "Operator" })
hi("@punctuation",  { fg = lght })

-- Optional: terminal palette (0..15)
