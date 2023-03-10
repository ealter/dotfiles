local signature  = require('lsp_signature')
local M = {}


-- Toggle diagnostic virtual_text
local virtual_text = true
local function toggleVirtualText()
  virtual_text = not virtual_text
  vim.diagnostic.config({virtual_text = virtual_text})
end

local on_attach = function(client, bufnr)
  local lsp_signature_config = {
    bind         = true,
    hint_enable  = true,
    use_lspsaga = false,
    hint_prefix  = " ",
    hint_scheme  = "String",
    handler_opts = { border = "single" },
    decorator    = {"`", "`"},
    extra_trigger_chars = {"(", ","},
  }

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
    client.config.flags.debounce_text_changes  = 100
  end

  signature.on_attach(lsp_signature_config)

  -- helper function that lets us more easily define mappings
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', keys, func, { noremap=true, silent=true } )
  end

  -- nmap("<leader>r", vim.lsp.buf.rename, "[R]ename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("=", function()
    vim.lsp.buf.format({
      async = true,
    })
  end, "Format buffer")

  -- Format on save
  local autoformat_filetypes = { "ruby", "lua" }
  if
    client.server_capabilities.documentFormattingProvider
    and vim.tbl_contains(autoformat_filetypes, vim.bo[bufnr].filetype)
  then
    -- Remove prior autocmds so this only triggers once per buffer
    vim.api.nvim_clear_autocmds({
      group = autoformat_group,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Run LSP formatting",
      group = autoformat_group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          timeout_ms = 500,
        })
      end,
    })
  end
end

M.on_attach = on_attach

local function make_config()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end
M.make_config = make_config

return M
