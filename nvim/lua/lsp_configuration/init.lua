local IsStripeLaptop = require('util').IsStripeLaptop
local make_config = require('lsp_configuration.config_builder').make_config

local function setup_servers()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { "bashls", "cssls", "dockerls", "gopls", "jsonls", "pyright", "sorbet", "lua_ls",
            "terraformls", "yamlls" },
    })

    require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler
            require("lspconfig")[server_name].setup(make_config())
        end,
        ["gopls"] = require("lsp_configuration.gopls").build_config,
        ["sorbet"] = require("lsp_configuration.sorbet").build_config,
        ["yamlls"] = require("lsp_configuration.yamlls").build_config,
    }

    -- Support custom LSP servers
    local additional_servers = { 'clangd' }
    for _, server in pairs(additional_servers) do
        local config = make_config()
        require 'lspconfig'[server].setup(config)
    end
end

setup_servers()
