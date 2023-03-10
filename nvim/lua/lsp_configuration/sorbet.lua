local M = {}

M.build_config = function()
  local config = require('lsp_configuration.config_builder').make_config()
  if vim.fn.glob("scripts/bin/typecheck") ~= "" then
    config.cmd = {
      "scripts/dev_productivity/while_pay_up_connected.sh",
      "pay",
      "exec",
      "scripts/bin/typecheck",
      "--lsp",
      "--enable-all-experimental-lsp-features",
    }
    config.on_exit = require('nvim-lsp-pay-server/lsp/nvim-lspconfig')
    config.root_dir = require('lspconfig/util').root_pattern('sorbet', '.git')
  else
    config.cmd = {'srb', 'tc', '--enable-all-beta-lsp-features', '--lsp'}
  end
  require('lspconfig').sorbet.setup(config)
end

return M
