color_table.ansi_three = { 128, 128, 0 }
color_table.ansi_two = { 0, 179, 0 }
color_table.ansi_six = { 0, 128, 128 }
color_table.ansi_eight = { 128, 128, 128 }

local header = "<ansi_three>"
local border = "<ansi_two>"
local option = "<ansi_six>"
local value = "<white>"
local off_value = "<ansi_eight>"
local table_width_max = 80
local table_width_contents = 78
local margin = {
	header = 1,
	outside = 2,
	inside = 2,
}
local column_width = (table_width_contents / 2) - margin.outside

function system.hunting.funcs.tableHeaderFooter(name)
	if not name then
		name = ""
	end
	local nameLength = string.len(name)
	cecho(border .. "+-" .. header .. name)
	cecho(border .. string.rep("-", table_width_contents - nameLength - margin.header) .. "+\n")
end

function system.hunting.funcs.tableRow(column1, column2)
	cecho(border.."|" .. string.rep(" ", margin.outside))
	system.hunting.funcs.echoColumn(column1)
	cecho(string.rep(" ", margin.inside * 2))
	system.hunting.funcs.echoColumn(column2)
	cecho(string.rep(" ", margin.outside) ..border.."|\n")
end

function system.hunting.funcs.echoColumn(column)
	local text

	if column then
		text = option .. column.option .. string.rep(" ", column_width - string.len(column.option) - string.len(column.value) - margin.inside)
		if column.highlight then
			text = text .. value .. column.value
		else
			text = text .. off_value .. column.value
		end
	else
		text = string.rep(" ", column_width - margin.inside)
	end

	cecho(text)
end

function system.hunting.funcs.makeColumn(option, value, highlight)
	option = tostring(option)
	value = tostring(value)
	local lowerValue = string.lower(value)
	if not highlight then
		if lowerValue == "manual" or lowerValue == "off" or lowerValue == "no" or lowerValue == "none" or lowerValue == "false" then
			highlight = false
		else
			highlight = true
		end
	end
	if lowerValue == "true" then
		value = "on"
	elseif lowerValue == "false" then
		value = "off"
	end
	return {
		option = option,
		value = string.upper(value),
		highlight = highlight
	}
end