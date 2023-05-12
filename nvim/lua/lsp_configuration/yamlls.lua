local M = {}

M.build_config = function()
    local config = require('lsp_configuration.config_builder').make_config()

    config.settings = {
        yaml = {
            keyOrdering = false
        }
    }

    require('lspconfig').yamlls.setup(config)
end

return M
