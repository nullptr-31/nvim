return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-plenary",
		"alfaix/neotest-gtest",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-gtest").setup({
					debug_adapter = "codelldb",
				}),
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
			if vim.bo.filetype == "lua" then
				vim.notify("neotest-plenary does not support DAP debugging", vim.log.levels.WARN)
				return
			end

			neotest.run.run({ strategy = "dap" })
		end, { desc = "Test: Debug nearest test" })

		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open()
		end, { desc = "Test: Open test output" })

		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.run(vim.fn.getcwd())
		end, { desc = "Test: Run all tests" })
	end,
}
