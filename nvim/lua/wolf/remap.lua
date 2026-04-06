vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>n', function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Toggle line numbers' })
