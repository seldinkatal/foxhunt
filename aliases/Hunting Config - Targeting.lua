--^(?i)\s*hconfig\s+targeting(\s+.*)?$

local valid = {
	"manual",
	"whitelist",
	"blacklist",
	"auto",
}

local info_string = {
	["manual"] = " not automatically change targets.",
	["auto"] = " automatically change targets. Most denizens are valid.",
	["whitelist"] = " automatically change targets. Only denizens present on an area whitelist are valid.",
	["blacklist"] = " automatically change targets. Denizens not present on an area blacklist are valid.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	echo("Syntax: HCONFIG TARGETING " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set how you want to target denizens.\n")
	echo("\n")
	echo("TARGETING is currently set to " .. string.upper(system.hunting.vars.targetingMode) .. ". You will" .. info_string[system.hunting.vars.targetingMode])
else 
	matches[2] = string.lower(string.trim(matches[2]))
	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		if matches[2] == "manual" then
			echo("You will" .. info_string[matches[2]]:gsub("not", "no longer"))
		else
			echo("You will" .. info_string[matches[2]])
		end
		system.hunting.vars.targetingMode = matches[2]
		system.hunting.funcs.updateHConfig("targetingMode", system.hunting.vars.targetingMode)
	end
end
send(" ")