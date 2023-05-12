vim.g.go_highlight_types = 0
vim.g.go_highlight_fields = 0
vim.g.go_highlight_functions = 0
vim.g.go_highlight_function_parameters = 0
vim.g.go_highlight_function_calls = 0
vim.g.go_highlight_extra_types = 0
vim.g.go_highlight_build_constraints = 0
vim.g.go_highlight_generate_tags = 0

-- disable vim-go :GoDef short cut (gd)
-- this is handled by LanguageClient [LC]
vim.g.go_def_mapping_enabled = 0
vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0

-- Auto formatting and importing
vim.g.go_fmt_autosave = 1
vim.g.go_fmt_command = "goimports"


local go_module = vim.fn.systemlist('go list -m')
if vim.v.shell_error == 0 then
    vim.g.go_fmt_options = { gofmt = '-s', goimports = '-local ' .. go_module[1] }
end
