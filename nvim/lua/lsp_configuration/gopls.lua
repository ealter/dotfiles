local M = {}

M.build_config = function()
  local config = require('lsp_configuration.config_builder').make_config()

  -- Determine current root directory
  local root_dir = vim.fn.getcwd()

  -- If root_dir/bin/gopls exists, use that, otherwise use gopls from PATH
  if vim.fn.executable(root_dir .. '/bin/gopls') == 1 then
    config.cmd = {root_dir .. '/bin/gopls', '--remote=auto'}
  else
    -- Use gopls from PATH
    config.cmd = {'gopls', "--remote=auto"}
  end

  config.settings = {
    build = {
      directoryFilters = {
        "-bazel-bin",
        "-bazel-gocode",
        "-bazel-mypkg",
        "-bazel-out",
        "-bazel-testlogs",
      },
    },
    formatting = {},
    ui = {
      completion = {
        usePlaceholders = true,
      },
      semanticTokens = true,
      codelenses = {
        gc_details = false,
        regenerate_cgo = false,
        generate = false,
        test = false,
        tidy = false,
        upgrade_dependency = false,
        vendor = false,
      }
    }
  }

  -- set formatting['local'] to the name of the current go module
  -- go list -m returns the name of the current module and 
  -- returns an exit code of 1 if the current directory is not part of a module
  local go_module = vim.fn.systemlist('go list -m')
  if vim.v.shell_error == 0 then
    config.settings.formatting['local'] = go_module[1]
  end

  require('lspconfig').gopls.setup(config)
end

return M
