-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set("n", ",q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", ".q", vim.cmd.cnext, { desc = "Next quickfix" })

vim.keymap.set("i", "<C-f>", "<right>")
vim.keymap.set("i", "<C-b>", "<left>")

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", ",d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", ".d", diagnostic_goto(false), { desc = "Prev Diagnostic" })

vim.keymap.set("n", ";t", function()
  vim.cmd("FloatermNew --height=0.9 --width=0.9 --wintype=float --name=floaterm1 --autoclose=2 ")
end, { desc = "Prev Diagnostic" })

vim.keymap.set("n", ";g", function()
  vim.cmd("FloatermNew --height=0.9 --width=0.9 --wintype=float --name=floaterm1 --autoclose=0 lazygit ")
end, { desc = "Prev Diagnostic" })
