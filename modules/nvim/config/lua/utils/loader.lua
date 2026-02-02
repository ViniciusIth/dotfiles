-- lua/utils/loader.lua
local M = {}

--- Require all `.lua` files inside a given module directory (non-recursive)
--- @param module string The module path, e.g. "text" or "lsp.servers"
function M.require_dir(module)
  local module_path = vim.fn.stdpath("config") .. "/lua/" .. module:gsub("%.", "/")

  local files = {}

  for name, type in vim.fs.dir(module_path) do
    if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
      table.insert(files, name)
    end
  end

  table.sort(files)

  for _, name in ipairs(files) do
    local mod_name = module .. "." .. name:gsub("%.lua$", "")
    local ok, err = pcall(require, mod_name)
    if not ok then
      vim.notify(("Failed to load module %s: %s"):format(mod_name, err), vim.log.levels.ERROR)
    end
  end
end

return M

