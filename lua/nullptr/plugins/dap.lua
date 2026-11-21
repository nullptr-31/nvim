return {
	"mfussenegger/nvim-dap",
	lazy = false,
	dependencies = {
		"jbyuki/one-small-step-for-vimkind",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.adapters.nlua = function(callback, config)
			callback({
				type = "server",
				host = config.host or "127.0.0.1",
				port = config.port or 8086,
			})
		end

		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
			},
		}

		vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Conditional Breakpoint" })

		local panels = {
			{ key = "<leader>dr", name = "repl" },
			{ key = "<leader>ds", name = "stacks" },
			{ key = "<leader>dw", name = "watches" },
			{ key = "<leader>db", name = "breakpoints" },
			{ key = "<leader>dS", name = "scopes" },
			{ key = "<leader>dc", name = "console" },
		}

		local layouts = {}

		for _, panel in ipairs(panels) do
			layouts[#layouts + 1] = {
				elements = { { id = panel.name } },
				size = 40,
				position = "right",
			}
		end

		dapui.setup({
			layouts = layouts,
			enter = true,
		})

		local active_layout

		local function close_ui()
			dapui.close()
			active_layout = nil
		end

		for index, panel in ipairs(panels) do
			local layout_index = index

			vim.keymap.set("n", panel.key, function()
				local was_active = active_layout == layout_index
				close_ui()

				if not was_active then
					dapui.open({ layout = layout_index })
					active_layout = layout_index
				end
			end, { desc = "Debug: Toggle " .. panel.name })
		end

		local group = vim.api.nvim_create_augroup("DapGroup", { clear = true })

		vim.api.nvim_create_autocmd("BufEnter", {
			group = group,
			pattern = "*dap-repl*",
			callback = function()
				vim.wo.wrap = true
			end,
		})

		dap.listeners.before.event_terminated.dapui_config = close_ui
		dap.listeners.before.event_exited.dapui_config = close_ui
	end,
}
