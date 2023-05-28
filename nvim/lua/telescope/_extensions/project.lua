local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local actions = require("telescope.actions")
local state = require("telescope.actions.state")
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values
local Path = require('plenary.path')
local fn = vim.fn

local on_change_events = {
  function() require 'internal.broot':shutdown() end,
}


local project_paths = function()
  local root
  root = '~/code/company'
  local paths = fn.split(fn.globpath(root, '*'))
  local apis = fn.split(fn.globpath(root .. '/api', '*'))

  for _, v in ipairs(apis) do
    table.insert(paths, v)
  end

  table.insert(paths, os.getenv('HOME') .. "/code/scripts/")

  return paths
end


local change_project_dir = function(path)
  if Path:new(path):exists() then
    vim.fn.execute("cd " .. path, "silent")
    print("changing path to " .. path)
    return true
  else
    print("The path '" .. path .. "' does not exist")
    return false
  end
end

-- Extracts project path from current buffer selection
local get_selected_path = function(prompt_bufnr)
  return state.get_selected_entry(prompt_bufnr).value
end

-- Change working directory to the selected project and close the picker.
local change_working_directory = function(prompt_bufnr)
  local project_path = get_selected_path(prompt_bufnr)
  actions.close(prompt_bufnr)
  vim.cmd("wall")
  vim.cmd("bufdo bd")
  vim.cmd("clearjumps")
  -- vim.cmd("Dashboard")
  for _, call_back in ipairs(on_change_events) do
    call_back()
  end
  change_project_dir(project_path)
end

local gosource = function(opts)
  opts = opts or {}
  local results = project_paths()

  pickers.new(opts, {
    prompt_title = 'Find In Go Root',
    results_title = 'Go Source Code',
    finder = finders.new_table {
      results = results,
      entry_maker = make_entry.gen_from_file(opts)
    },
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),

    attach_mappings = function(prompt_bufnr, map)

      local refresh_projects = function()
        local picker = action_state.get_current_picker(prompt_bufnr)
        local finder = _finders.project_finder(opts, _utils.get_projects())
        picker:refresh(finder, { reset_prompt = true })
      end

      local on_project_selected = function()
        change_working_directory(prompt_bufnr)
      end


      actions.select_default:replace(on_project_selected)

      return true
    end

  }):find()
end



return telescope.register_extension { exports = { project = gosource } }
