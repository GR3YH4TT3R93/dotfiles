require("zoxide"):setup({
	update_db = true,
})

require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },
	--
	style_a = {
		fg = "#181a1f",
		bg_mode = {
			normal = "#98c379",
			select = "#c678dd",
			un_set = "#e86671",
		},
	},
	style_b = { bg = "#393f4a", fg = "#abb2bf" },
	style_c = { bg = "#31353f", fg = "#abb2bf" },
	--
	permissions_t_fg = "#98c379",
	permissions_r_fg = "#e5c07b",
	permissions_w_fg = "#e86671",
	permissions_x_fg = "#56b6c2",
	permissions_s_fg = "#5c6370",
	--
	tab_width = 20,
	tab_use_inverse = false,
	--
	selected = { icon = "󰻭", fg = "#e5c07b" },
	copied = { icon = "", fg = "#98c379" },
	cut = { icon = "", fg = "#e86671" },

	total = { icon = "󰮍", fg = "#e5c07b" },
	succ = { icon = "", fg = "#98c379" },
	fail = { icon = "", fg = "#e86671" },
	found = { icon = "󰮕", fg = "#61afef" },
	processed = { icon = "󰐍", fg = "#98c379" },
	--
	show_background = true,
	--
	display_header_line = true,
	display_status_line = true,
	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "date", params = { "%A, %d %B %Y" } },
			},
			section_b = {
				{ type = "string", custom = false, name = "date", params = { "%X" } },
			},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_name" },
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})
