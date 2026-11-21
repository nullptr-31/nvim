return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-plenary",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-plenary"),
			},
		})

		vim.keymap.set("n", "<leader>tr", function()
			neotest.run.run()
		end, { desc = "Test: Run nearest test" })

		vim.keymap.set("n", "<leader>tv", function()
			neotest.summary.toggle()
		end, { desc = "Test: Toggle summary" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.run(vim.fn.getcwd())
		end, { desc = "Test: Run suite" })

		vim.keymap.set("n", "<leader>td", function()
			vim.notify("neotest-plenary does not support DAP debugging", vim.log.levels.WARN)
		end, { desc = "Test: Debug nearest test (unsupported)" })

		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open()
		end, { desc = "Test: Open test output" })

		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.run(vim.fn.getcwd())
		end, { desc = "Test: Run all tests" })
	end,
}
