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

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

  local opts = { noremap=true, silent=true }
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', "<cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ga', ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gm', "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua require("lsp").peek_definition()<CR>', opts)

  signature.on_attach(lsp_signature_config)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[D', '<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']D', '<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lc', '<cmd>lua vim.diagnostic.hide()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lQ', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float({ scope = "line" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lt', "", { noremap = opts.noremap, silent = opts.silent, callback = toggleVirtualText })

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
