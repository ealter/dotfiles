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
        { name = 'buffer' },
        { name = 'path',     max_item_count = 20 },
        { name = 'calc',     max_item_count = 5 },
    }),
})
