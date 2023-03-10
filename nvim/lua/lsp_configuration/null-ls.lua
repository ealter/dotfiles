local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local COMPLETION = methods.internal.COMPLETION

local github_users_completion = h.make_builtin({
    method = COMPLETION,
    filetypes = {"markdown"},
    name = "Github Users",
    generator_opts = {
      use_cache = true
    },

    generator = {
      fn = function(params, done)
        local items = {}
        local command = string.format([[
          gh api graphql -f query='
            query {
              search(type: USER, query: "%s", first: 5) {
                nodes {
                  ... on User {
                    login
                    name
                  }
                }
              }
            }
          ']], params.word_to_complete)
        local handle = io.popen(command)
        local result = handle:read("*a")
        handle:close()
        return done({{items = items, isIncomplete = #items == 0}})
      end,
      async = true,
    },
})


local rubocop = '/Users/eliot/.rbenv/shims/rubocop'
if vim.fn.glob('scripts/bin/rubocop-daemon/rubocop') ~= "" then
  rubocop = 'scripts/bin/rubocop-daemon/rubocop'
end

local null_ls = require('null-ls')
local diagnostics = {}

diagnostics['eslint_d'] = null_ls.builtins.diagnostics.eslint_d.with({
  cwd = function(params)
    return util.root_pattern(".eslintrc.js")(params.bufname)
  end
})
diagnostics['rubocop'] = null_ls.builtins.diagnostics.rubocop.with({
  command = rubocop
})

local formatting = {}
formatting['eslint_d'] = null_ls.builtins.formatting.eslint_d.with({
  cwd = function(params)
    return util.root_pattern(".eslintrc.js")(params.bufname)
  end
})
formatting['prettierd'] = null_ls.builtins.formatting.prettierd
formatting['rubocop'] = {
  method = null_ls.methods.FORMATTING,
  filetypes = { "ruby" },
  -- null_ls.generator creates an async source
  -- that spawns the command with the given arguments and options
  generator = null_ls.generator({
    command = rubocop,
    args = {"--auto-correct", "--no-color", "--force-exclusion", "--stdin", "$FILENAME"},
    to_stdin = true,
    from_stderr = false,
    -- choose an output format (raw, json, or line)
    format = "raw",
    check_exit_code = function(code)
      return code <= 1
    end,
    -- use helpers to parse the output from string matchers,
    -- or parse it manually with a function
    on_output = function(params, done)
      parsed_output = params.output

      delimiter = "==========\n"
      parts = vim.split(parsed_output, delimiter, { plain = true })
      table.remove(parts, 1)
      final_output = table.concat(parts, delimiter)

      done({
        {
          row = 1,
          col = 1,
          end_row = #vim.split(final_output, "\n") + 1,
          end_col = 1,
          text = final_output,
        },
      })
    end
  }),
}

null_ls.setup({
    sources = {
      -- All
      null_ls.builtins.formatting.trim_whitespace,
      --TODO: either change priority or use another source
      -- null_ls.builtins.completion.spell,
      --null_ls.builtins.completion.buildifier,

      -- Ruby
      diagnostics.rubocop,
      formatting.rubocop,

      -- Javascript
      diagnostics.eslint_d,
      formatting.eslint_d,
      formatting.prettierd,
    },
    on_attach = require('lsp_configuration.config_builder').on_attach,
})
