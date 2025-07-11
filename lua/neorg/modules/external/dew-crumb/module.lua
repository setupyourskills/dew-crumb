local neorg = require("neorg.core")
local modules = neorg.modules

local ts_utils = require("nvim-treesitter.ts_utils")

local api = vim.api
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

local module = modules.create("external.dew-crumb")

local crumb_group = augroup("dew-crumb", { clear = true })

module.setup = function()
	return {
		requires = {
			"core.neorgcmd",
		},
	}
end

module.load = function()
	module.required["core.neorgcmd"].add_commands_from_table({
		dew_crumb = {
			args = 1,
			subcommands = {
				enable = { args = 0, name = "dew-crumb.enable" },
				disable = { args = 0, name = "dew-crumb.disable" },
			},
		},
	})

	if module.config.public.enabled then
		module.private.set_autocmd()
	end
end

module.config.public = {
	enabled = false,
}

module.private = {
	enable = function()
		module.config.public.enabled = true

		module.private.set_autocmd()
	end,
	disable = function()
		module.config.public.enabled = false

		module.private.unset_autocmd()
		vim.wo.winbar = ""
	end,

	set_autocmd = function()
		autocmd({ "WinScrolled", "BufEnter", "WinEnter", "CursorMoved" }, {
			group = crumb_group,
			pattern = "*.norg",
			callback = function()
				module.private.crumb()
			end,
		})
	end,

	unset_autocmd = function()
		api.nvim_clear_autocmds({ group = crumb_group })
	end,

	crumb = function()
		local node = ts_utils.get_node_at_cursor()

		local headings = {}

		while true do
			while node and not node:type():match("^heading%d$") do
				node = node:parent()
			end

			if node then
				table.insert(headings, vim.treesitter.get_node_text(node:named_child(1), 0))
				node = node:parent()
			else
				local invert = {}
				for i = #headings, 1, -1 do
					table.insert(invert, headings[i])
				end

				vim.wo.winbar = table.concat(invert, " > ")
				return
			end
		end
	end,
}

module.on_event = function(event)
	if event.split_type[2] == "dew-crumb.enable" then
		module.private.enable()
	elseif event.split_type[2] == "dew-crumb.disable" then
		module.private.disable()
	end
end

module.events.subscribed = {
	["core.neorgcmd"] = {
		["dew-crumb.enable"] = true,
		["dew-crumb.disable"] = true,
	},
}

return module
