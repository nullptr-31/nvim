return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Toggle diagnostics (Trouble)",
		},
		{
			"[t",
			function()
				require("trouble").next({
					mode = "diagnostics",
					jump = true,
				})
			end,
			desc = "Next diagnostic (Trouble)",
		},
		{
			"]t",
			function()
				require("trouble").prev({
					mode = "diagnostics",
					jump = true,
				})
			end,
			desc = "Previous diagnostic (Trouble)",
		},
	},
}
