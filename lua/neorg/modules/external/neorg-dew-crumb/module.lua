local neorg = require("neorg.core")
local modules = neorg.modules

local ts_utils = require("nvim-treesitter.ts_utils")

local autocmd = vim.api.nvim_create_autocmd

local module = modules.create("external.neorg-dew-crumb")

module.setup = function()
	return {
		requires = {
			"core.neorgcmd",
		},
	}
end

module.load = function()
	module.required["core.neorgcmd"].add_commands_from_table({
		["crumb"] = {
			args = 0,
			name = "external.crumb.show",
		},
	})

	autocmd({ "WinScrolled", "BufEnter", "WinEnter", "CursorMoved" }, {
		pattern = "*.norg",
		callback = function()
			module.private.crumb()
		end,
	})
end

module.private = {
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
	if event.split_type[2] == "external.crumb.show" then
		module.private.crumb()
	end
end

module.events.subscribed = {
	["core.neorgcmd"] = {
		["external.crumb.show"] = true,
	},
}

return module
