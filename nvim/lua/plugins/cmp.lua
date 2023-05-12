local cmp = require 'cmp'

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    formatting = {
        format = require("lspkind").cmp_format({
            with_text = true,
            menu = ({
            })
        }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'vsnip',    max_item_count = 20 }, -- For vsnip users.
        { name = 'nvim_lua', max_item_count = 20 },
        {
            name = 'buffer',
            max_item_count = 10,
            option = {
                get_bufnrs = function() -- Return results from all buffers
                    result = {}
                    local buffs = vim.api.nvim_list_bufs()
                    for _, buf in ipairs(buffs) do
                        local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                        if byte_size < 1024 * 1024 then -- 1 Megabyte max
                            table.insert(result, buf)
                        end
                    end
                    return result
                end
            }
        },
        { name = 'path', max_item_count = 20 },
        { name = 'calc', max_item_count = 5 },
        { name = 'omni', max_item_count = 5 },
    }),
})
