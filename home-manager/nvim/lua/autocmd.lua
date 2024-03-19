-- Remove useless stuff from the terminal window and enter INSERT mode
vim.api.nvim_create_autocmd('TermOpen', {
    group = num_au,
    callback = function(data)
        if not string.find(vim.bo[data.buf].filetype, '^[fF][tT]erm') then
            vim.api.nvim_set_option_value('number', false, { scope = 'local' })
            vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
            vim.api.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
            vim.api.nvim_command('startinsert')
        end
    end,
})
