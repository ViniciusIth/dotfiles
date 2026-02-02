local devicons = require("nvim-web-devicons")

-- Helpers
local function concat(parts)
  local out = {}
  for _, part in ipairs(parts) do
    if part and part ~= "" then
      table.insert(out, part)
    end
  end
  return table.concat(out, " ")
end

local function hl(group, text)
  return string.format("%%#%s#%s", group, text)
end

local function reset_hl()
  return "%#StatusLine#"
end


-- widgets
local function mode_widget()
  local map = { n = "NORMAL", i = "INSERT", v = "VISUAL" }
  local m = vim.api.nvim_get_mode().mode
  return map[m] or m
end

local function git_widget()
  return vim.b.gitsigns_head and (" " .. vim.b.gitsigns_head) or ""
end

local function path_widget()
  local name = vim.api.nvim_buf_get_name(0)
  return name ~= "" and vim.fn.fnamemodify(name, ":~:.") or "[No Name]"
end

local function diagnostics_widget()
  local c = vim.diagnostic.count(0)

  local err  = c[vim.diagnostic.severity.ERROR] or 0
  local warn = c[vim.diagnostic.severity.WARN]  or 0
  local info = c[vim.diagnostic.severity.INFO]  or 0
  local hint = c[vim.diagnostic.severity.HINT]  or 0

  local parts = {
    err  > 0 and hl("DiagnosticError", ":" .. err)  or "",
    warn > 0 and hl("DiagnosticWarn",  ":" .. warn) or "",
    info > 0 and hl("DiagnosticInfo",  ":" .. info) or "",
    hint > 0 and hl("DiagnosticHint",  "󰌵:" .. hint) or "",
  }

  return table.concat(vim.tbl_filter(function(p) return p ~= "" end, parts), " ")
end

local function filetype_widget()
  local bufname = vim.api.nvim_buf_get_name(0)
  local filetype = vim.bo.filetype

  if bufname == "" and filetype == "" then
    return ""
  end

  local name = vim.fn.fnamemodify(bufname, ":t")
  local ext  = vim.fn.fnamemodify(bufname, ":e")

  local icon, icon_hl =
    devicons.get_icon(name, ext, { default = true })

  if not icon then
    icon, icon_hl =
      devicons.get_icon_by_filetype(filetype, { default = true })
  end

  if not icon then
    return filetype
  end

  return string.format(
    "%%#%s#%s %%#StatusLine#%s",
    icon_hl,
    icon,
    filetype
  )
end

local function pos_widget()
  return string.format("%d:%d", vim.fn.line("."), vim.fn.col("."))
end


-- Render
function render()
  return concat {
    mode_widget(),
    git_widget(),
    path_widget(),
    "%=",
    diagnostics_widget(),
    filetype_widget(),
    pos_widget(),
  }
end

vim.o.statusline = "%!v:lua.render()"
