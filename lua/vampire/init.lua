local M = {}

function M.hi(group, style)
  vim.api.nvim_set_hl(0, group, M.conform(style))
end

function M.conform(style)
  style.ctermfg = style.f
  style.ctermbg = style.b
  if vim.o.termguicolors then
    style.fg = style.f and M.guicolors[style.f+1]
    style.bg = style.b and M.guicolors[style.b+1]
  end
  style.f = nil
  style.b = nil
  return style
end

function M.apply(group_styles)
  for group, style in pairs(group_styles) do
    M.hi(group, style)
  end
end

function M.load()
  if vim.g.colors_name then
    vim.cmd.highlight("clear")
  end

  if vim.fn.exists("syntax_on") then
    vim.cmd.syntax("reset")
  end

  local P = M.pallete
  M.apply({
    -- source
    Normal                        = { f = P.g22 },
    Statement                     = { f = P.g22 },
    Special                       = { f = P.g22 },
    Type                          = { f = P.g22 },
    StorageClass                  = { f = P.g22 },
    Function                      = { f = P.g22 },
    Identifier                    = { f = P.g22 },
    Constant                      = { f = P.g22 },
    String                        = { f = P.g22 },
    Delimiter                     = { f = P.g22 },
    Operator                      = { f = P.g22 },
    Comment                       = { f = P.g12 },
    Error                         = { f = P.hot, b = P.cold },
    MatchParen                    = { f = P.hot, b = P.cold },
    Added                         = { f = P.green },
    Changed                       = { f = P.blue },
    Removed                       = { f = P.hot },
    -- tui
    QuickFixLine                  = { f = P.hot },
    LineNr                        = { f = P.g14 },
    CursorLine                    = { b = P.g04 },
    CursorLineNr                  = { f = P.g22, b = P.g04 },
    StatusLine                    = { f = P.black, b = P.hot },
    StatusLineNC                  = { f = P.hot, b = P.cold },
    TabLine                       = { f = P.hot, b = P.cold },
    TabLineFill                   = { f = P.black, b = P.black },
    TabLineSel                    = { f = P.black, b = P.hot },
    VertSplit                     = { f = P.hot },
    WinSeparator                  = { f = P.hot },
    ColorColumn                   = { b = P.g04 },
    Folded                        = { f = P.hot },
    Search                        = { f = P.black, b = P.hot },
    IncSearch                     = { f = P.black, b = P.hot },
    CurSearch                     = { f = P.black, b = P.yellow },
    PMenu                         = { f = P.hot, b = P.cold },
    PMenuSel                      = { f = P.black, b = P.hot },
    PMenuThumb                    = { f = P.black, b = P.hot },
    Visual                        = { b = P.g06 },
    EndOfBuffer                   = { f = P.hot },
    ErrorMsg                      = { f = P.hot },
    WarningMsg                    = { f = P.yellow },
    Directory                     = { f = P.hot },
    ModeMsg                       = { f = P.hot },
    MoreMsg                       = { f = P.hot },
    Question                      = { f = P.hot },
    FloatBorder                   = { f = P.hot },
    FloatTitle                    = { f = P.hot },
    -- diagnostics
    DiagnosticError               = { f = P.hot },
    DiagnosticWarn                = { f = P.yellow },
    DiagnosticInfo                = { f = P.g22 },
    DiagnosticHint                = { link = "DiagnosticVirtualTextInfo" },
    DiagnosticOk                  = { link = "DiagnosticVirtualTextInfo" },
    DiagnosticFloatingWarn        = { link = "DiagnosticError" },
    DiagnosticFloatingInfo        = { link = "DiagnosticError" },
    DiagnosticFloatingHint        = { link = "DiagnosticError" },
    DiagnosticFloatingOk          = { link = "DiagnosticError" },
    DiagnosticUnderlineError      = { f = P.hot, underline = true },
    DiagnosticUnderlineWarn       = { f = P.yellow, underline = true },
    DiagnosticUnderlineInfo       = { f = P.g22, underline = true },
    DiagnosticUnderlineHint       = { link = "DiagnosticUnderlineInfo" },
    DiagnosticUnderlineOk         = { link = "DiagnosticUnderlineInfo" },
    -- Telescope
    TelescopeBorder               = { link = "FloatBorder" },
    -- lsp
    LspInfoBorder                 = { link = "FloatBorder" },
    ["@variable"]                 = { f = P.g22 },
    -- lua
    ["@constructor.lua"]          = { f = P.g19 },
    -- tmux
    tmuxString                    = { f = P.hot },
    tmuxEscape                    = { f = P.hot, b = P.cold },
    tmuxFormatString              = { f = P.hot, b = P.cold },
  })

  vim.g.colors_name = "vampire"
end

M.guicolors = {
  "#000000", "#800000", "#008000", "#808000", "#000080", "#800080", "#008080", "#c0c0c0",
  "#808080", "#ff0000", "#00ff00", "#ffff00", "#0000ff", "#ff00ff", "#00ffff", "#ffffff",
  "#000000", "#00005f", "#000087", "#0000af", "#0000d7", "#0000ff", "#005f00", "#005f5f",
  "#005f87", "#005faf", "#005fd7", "#005fff", "#008700", "#00875f", "#008787", "#0087af",
  "#0087d7", "#0087ff", "#00af00", "#00af5f", "#00af87", "#00afaf", "#00afd7", "#00afff",
  "#00d700", "#00d75f", "#00d787", "#00d7af", "#00d7d7", "#00d7ff", "#00ff00", "#00ff5f",
  "#00ff87", "#00ffaf", "#00ffd7", "#00ffff", "#5f0000", "#5f005f", "#5f0087", "#5f00af",
  "#5f00d7", "#5f00ff", "#5f5f00", "#5f5f5f", "#5f5f87", "#5f5faf", "#5f5fd7", "#5f5fff",
  "#5f8700", "#5f875f", "#5f8787", "#5f87af", "#5f87d7", "#5f87ff", "#5faf00", "#5faf5f",
  "#5faf87", "#5fafaf", "#5fafd7", "#5fafff", "#5fd700", "#5fd75f", "#5fd787", "#5fd7af",
  "#5fd7d7", "#5fd7ff", "#5fff00", "#5fff5f", "#5fff87", "#5fffaf", "#5fffd7", "#5fffff",
  "#870000", "#87005f", "#870087", "#8700af", "#8700d7", "#8700ff", "#875f00", "#875f5f",
  "#875f87", "#875faf", "#875fd7", "#875fff", "#878700", "#87875f", "#878787", "#8787af",
  "#8787d7", "#8787ff", "#87af00", "#87af5f", "#87af87", "#87afaf", "#87afd7", "#87afff",
  "#87d700", "#87d75f", "#87d787", "#87d7af", "#87d7d7", "#87d7ff", "#87ff00", "#87ff5f",
  "#87ff87", "#87ffaf", "#87ffd7", "#87ffff", "#af0000", "#af005f", "#af0087", "#af00af",
  "#af00d7", "#af00ff", "#af5f00", "#af5f5f", "#af5f87", "#af5faf", "#af5fd7", "#af5fff",
  "#af8700", "#af875f", "#af8787", "#af87af", "#af87d7", "#af87ff", "#afaf00", "#afaf5f",
  "#afaf87", "#afafaf", "#afafd7", "#afafff", "#afd700", "#afd75f", "#afd787", "#afd7af",
  "#afd7d7", "#afd7ff", "#afff00", "#afff5f", "#afff87", "#afffaf", "#afffd7", "#afffff",
  "#d70000", "#d7005f", "#d70087", "#d700af", "#d700d7", "#d700ff", "#d75f00", "#d75f5f",
  "#d75f87", "#d75faf", "#d75fd7", "#d75fff", "#d78700", "#d7875f", "#d78787", "#d787af",
  "#d787d7", "#d787ff", "#d7af00", "#d7af5f", "#d7af87", "#d7afaf", "#d7afd7", "#d7afff",
  "#d7d700", "#d7d75f", "#d7d787", "#d7d7af", "#d7d7d7", "#d7d7ff", "#d7ff00", "#d7ff5f",
  "#d7ff87", "#d7ffaf", "#d7ffd7", "#d7ffff", "#ff0000", "#ff005f", "#ff0087", "#ff00af",
  "#ff00d7", "#ff00ff", "#ff5f00", "#ff5f5f", "#ff5f87", "#ff5faf", "#ff5fd7", "#ff5fff",
  "#ff8700", "#ff875f", "#ff8787", "#ff87af", "#ff87d7", "#ff87ff", "#ffaf00", "#ffaf5f",
  "#ffaf87", "#ffafaf", "#ffafd7", "#ffafff", "#ffd700", "#ffd75f", "#ffd787", "#ffd7af",
  "#ffd7d7", "#ffd7ff", "#ffff00", "#ffff5f", "#ffff87", "#ffffaf", "#ffffd7", "#ffffff",
  "#080808", "#121212", "#1c1c1c", "#262626", "#303030", "#3a3a3a", "#444444", "#4e4e4e",
  "#585858", "#626262", "#6c6c6c", "#767676", "#808080", "#8a8a8a", "#949494", "#9e9e9e",
  "#a8a8a8", "#b2b2b2", "#bcbcbc", "#c6c6c6", "#d0d0d0", "#dadada", "#e4e4e4", "#eeeeee",
}

M.pallete = {
  none     = nil,

  black    = 16,
  g01      = 232,
  g02      = 233,
  g03      = 234,
  g04      = 235,
  g05      = 236,
  g06      = 237,
  g07      = 238,
  g08      = 239,
  g09      = 240,
  g10      = 241,
  g11      = 242,
  g12      = 243,
  g13      = 244,
  g14      = 245,
  g15      = 246,
  g16      = 247,
  g17      = 248,
  g18      = 249,
  g19      = 250,
  g20      = 251,
  g21      = 252,
  g22      = 253,
  g23      = 254,
  g24      = 255,
  white    = 15,

  hot      = 197,
  cold     = 52,
  red      = 197,
  green    = 46,
  blue     = 33,
  yellow   = 226,
}

return M
