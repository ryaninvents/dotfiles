local M = {}

local colors = {
  bg = { ctermbg = "White" },
  red = { ctermfg = "Red" },
  green = { ctermfg = "Green" },
  blue = { ctermfg = "Blue" },
  cyan = { ctermfg = "Cyan" },
  purple = { ctermfg = "Purple" },
  magenta = { ctermfg = "Magenta" },
  magentaDark = { ctermfg = "DarkMagenta" },
  fg = { ctermfg = "Black" },
  orange = { ctermfg = "Orange" },
  lightMagenta = { ctermfg = "LightMagenta" },
  yellowDark = { ctermfg = "YellowDark" },
  blueLight = { ctermfg = "BlueLight" },
  redDark = { ctermfg = "RedDark" },
  orangeLight = { ctermfg = "OrangeLight" },
}

local function set_groups()
  local groups = {
    -- base
    Normal = colors.fg,
    LineNr = colors.cyan,
    CursorLine = { bg = "#eeeeee" },
    Cursor = { ctermbg = "Black", ctermfg = "White" },
    Constant = colors.magentaDark,
    String = { ctermfg = "DarkGreen" },
    Character = colors.magentaDark,
    Number = colors.magentaDark,
    Float = colors.magentaDark,
    Boolean = colors.magentaDark,
    Comment = { ctermfg = "Black", italic = true, bold = true },
    Keyword = { italic = true },
    Search = { ctermbg = "LightMagenta" },
    Visual = { ctermbg = "LightCyan" },
  }

  for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
  end
end

function M.colorscheme()
  vim.g.colors_name = "untheme"

  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.cmd("set notermguicolors")

  vim.o.background = "light"

  set_groups()
end

return M
