vim.g.ale_ruby_rubocop_executable = 'scripts/bin/rubocop'
vim.g.ale_fix_on_save = 1
vim.g.ale_lint_on_save = 1
vim.g.ale_linters = {
  javascript = {'prettier', 'eslint'},
  -- javascript.jsx = {'prettier', 'eslint' },
  typescriptreact = {'prettier', 'eslint'},
}
vim.g.ale_fixers = {
  javascript = {'prettier', 'eslint'},
  -- 'javascript.jsx = {'prettier', 'eslint'},
  typescriptreact = {'prettier', 'eslint'},
  ruby = {'rubocop'},
}
