return {
	"stevearc/conform.nvim",
	config = function()
		local supported = {
			lua = true,
			c = true,
			cpp = true,
		}

		require("conform").setup({
			format_on_save = function(bufnr)
				if not supported[vim.bo[bufnr].filetype] then
					return
				end

				return {
					timeout_ms = 5000,
					lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = {
						"-style=file",
						"-fallback-style=LLVM",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			if not supported[vim.bo.filetype] then
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
