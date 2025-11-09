--^(?i)\s*hconfig\s+targetorder(\s+.*)?$

local valid = {
	"numeric",
	"order",
	"reverse",
}

local info_string = {
	["numeric"] = " evaluate targets in numeric order.",
	["order"] = " evaluate targets in the order in which they appear on INFO HERE.",
	["reverse"] = " evaluate targets in the reverse of the order in which they appear on INFO HERE.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	echo("Syntax: HCONFIG TARGETORDER " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set in which order you want automatic targeting to evaluate targets.\n")
	echo("\n")
	echo("TARGETORDER is currently set to " .. string.upper(system.hunting.vars.targetOrder) .. ". You will" .. info_string[system.hunting.vars.targetOrder])
else 
	matches[2] = string.lower(string.trim(matches[2]))
	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("You will now" .. info_string[matches[2]])
		system.hunting.vars.targetOrder = matches[2]
		system.hunting.funcs.updateHConfig("targetOrder", system.hunting.vars.targetOrder)
	end
end
send(" ")