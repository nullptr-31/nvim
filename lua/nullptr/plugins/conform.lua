return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = function(bufnr)
				if vim.bo[bufnr].filetype ~= "lua" then
					return
				end

				return {
					timeout_ms = 5000,
					lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			if vim.bo.filetype ~= "lua" then
				return
			end

			require("conform").format({
				bufnr = 0,
				timeout_ms = 5000,
				lsp_format = "fallback",
			})
		end)
	end,
}
