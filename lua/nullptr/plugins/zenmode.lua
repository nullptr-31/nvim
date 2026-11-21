return {
	"folke/zen-mode.nvim",
	config = function()
		local zen = require("zen-mode")
		zen.setup({})

		vim.keymap.set("n", "<leader>zz", function()
			zen.toggle({
				window = {
					width = 90,
					options = {
						wrap = false,
						number = true,
						relativenumber = true,
					},
				},
			})
		end)

		vim.keymap.set("n", "<leader>zZ", function()
			zen.toggle({
				window = {
					width = 80,
					options = {
						wrap = false,
						number = false,
						relativenumber = false,
						colorcolumn = "0",
					},
				},
			})
		end)
	end,
}
