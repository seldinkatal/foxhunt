--^(?i)\s*hconfig\s+battleragestrat(\s+.*)?$

local valid = {}

for name,_ in pairs(system.hunting.defs.battlerageStrategems[string.lower(system.hunting.funcs.getClass())]) do
	table.insert(valid, name)
end

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	echo("Syntax: HCONFIG BATTLERAGESTRAT " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set your battlerage strategem. These are user-defined in the Hunting Definitions script.\n")
	echo("        Set to NONE to use no battlerage.\n")
	echo("\n")
	echo("BATTLERAGESTRAT is currently set to " .. string.upper(system.hunting.vars.battlerageMode))
else 
	matches[2] = string.lower(string.trim(matches[2]))
	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("BATTLERAGESTRAT has been set to " .. string.upper(matches[2]))
		system.hunting.vars.battlerageMode = matches[2]
		system.hunting.funcs.updateHConfig("battlerageMode", system.hunting.vars.battlerageMode)
	end
end
send(" ")