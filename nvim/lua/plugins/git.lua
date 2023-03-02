if require('util').IsStripeLaptop then
    vim.g.github_enterprise_urls = {'https://git.corp.stripe.com'}
end

vim.api.nvim_set_keymap('n', '<leader>gh', ':.GBrowse!<CR>', {noremap=true}) -- Copy github URL to clipboard
vim.api.nvim_set_keymap('n', '<leader>ghv', ':.GBrowse<CR>', {noremap=true}) -- Open github URL in browser

vim.api.nvim_set_keymap('v', '<leader>gh', ':.GBrowse!<CR>', {noremap=true}) -- Copy github URL to clipboard
vim.api.nvim_set_keymap('v', '<leader>ghv', ':.GBrowse<CR>', {noremap=true}) -- Open github URL in browser
