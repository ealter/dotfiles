local M = {}

M.IsStripeLaptop = vim.fn.isdirectory('~/stripe') == 0

return M
