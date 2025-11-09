--^(?i)\s*hconfig\s+ignoreotherplayers(\s+.*)?$

local valid = {
	"yes",
	"no",
}

local info_string = {
	["yes"] = " automatically initiate attack if configured to do so regardless of the presence of ungrouped players.",
	["no"] = " not automatically initiate attack if configured to do if there are ungrouped players in the room.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	local val = ""
	if system.hunting.vars.ignoreOtherPlayers == true then
		val = "yes"
	else
		val = "no"
	end

	echo("Syntax: HCONFIG IGNOREOTHERPLAYERS " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set whether or not you want to automatically initiate attack despite other players.\n")
	echo("\n")
	echo("IGNOREOTHERPLAYERS is currently set to " .. string.upper(val) .. ". You will" .. info_string[val])
else 
	matches[2] = string.lower(string.trim(matches[2]))

	if matches[2] == "on" then matches[2] = "yes" end
	if matches[2] == "off" then matches[2] = "no" end

	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("You will now" .. info_string[matches[2]])

		if matches[2] == "yes" then
			system.hunting.vars.ignoreOtherPlayers = true
		else
			system.hunting.vars.ignoreOtherPlayers = false
		end
		system.hunting.funcs.updateHConfig("ignoreOtherPlayers", system.hunting.vars.ignoreOtherPlayers)
	end
end
send(" ")