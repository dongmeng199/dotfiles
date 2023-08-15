local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local actions = require "telescope.actions"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"
local utils = require "telescope.utils"
local conf = require("telescope.config").values
local log = require "telescope.log"

local Path = require "plenary.path"

local flatten = vim.tbl_flatten
local filter = vim.tbl_filter


local split = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end

  return t
end

local get_open_filelist = function(grep_open_files, cwd)
  if not grep_open_files then
    return nil
  end

  local bufnrs = filter(function(b)
        if 1 ~= vim.fn.buflisted(b) then
          return false
        end
        return true
      end, vim.api.nvim_list_bufs())
  if not next(bufnrs) then
    return
  end

  local filelist = {}
  for _, bufnr in ipairs(bufnrs) do
    local file = vim.api.nvim_buf_get_name(bufnr)
    table.insert(filelist, Path:new(file):make_relative(cwd))
  end
  return filelist
end

-- Special keys:
--  opts.search_dirs -- list of directory to search in
--  opts.grep_open_files -- boolean to restrict search to open files
local leaderf = function(opts)
  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  local search_dirs = opts.search_dirs
  local grep_open_files = opts.grep_open_files
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

  local filelist = get_open_filelist(grep_open_files, opts.cwd)
  if search_dirs then
    for i, path in ipairs(search_dirs) do
      search_dirs[i] = vim.fn.expand(path)
    end
  end


  local live_grepper = finders.new_job(function(prompt)
        -- TODO: Probably could add some options for smart case and whatever else rg offers.

        if not prompt or prompt == "" then
          return nil
        end

        local search_list = {}

        if grep_open_files then
          search_list = filelist
        elseif search_dirs then
          search_list = search_dirs
        end


        --  return flatten {"erg",  split(prompt,' ')}
        --end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

        return flatten { "python3", "/Users/meng.dong/code/scripts/multi_ripgrep.py", split(prompt, ' ') }
      end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)


  opts.sorting_strategy = "ascending"
  opts.layout_strategy = "vertical"
  opts.layout_config = {
      preview_height = 0.3,
      width = 0.8,
      height = 0.8,
      prompt_position = "top"
  }


  pickers
      .new(opts, {
          prompt_title = "Live Grep",
          finder = live_grepper,
          previewer = conf.grep_previewer(opts),
          -- TODO: It would be cool to use `--json` output for this
          -- and then we could get the highlight positions directly.
          sorter = sorters.highlighter_only(opts),
      })
      :find()
end

return require('telescope').register_extension { exports = { leaderf = leaderf } }
