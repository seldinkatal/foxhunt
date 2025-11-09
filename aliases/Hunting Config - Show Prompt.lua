--^(?i)\s*hconfig\s+showprompt(\s+.*)?$

local valid = {
	"yes",
	"no"
}

local info_string = {
	["yes"] = " use the serverside queue to buffer your attack actions.",
	["no"] = " not use the serverside queue to buffer your attack actions.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	local val = ""
	if system.hunting.vars.showPrompt == true then
		val = "yes"
	else
		val = "no"
	end

	echo("Syntax: HCONFIG SHOWPROMPT " .. table.concat(valid_string, "|") .. "\n")
   echo("        Choose whether or not to show Battlerage on Prompt when hunting.\n")
	echo("\n")
	echo("SHOWPROMPT is currently set to " .. string.upper(val))
else 
	matches[2] = string.lower(string.trim(matches[2]))

	if matches[2] == "on" then matches[2] = "yes" end
	if matches[2] == "off" then matches[2] = "no" end

	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("SHOWPROMPT has been set to " .. string.upper(matches[2]))

		if matches[2] == "yes" then
			system.hunting.vars.showPrompt = true
		else
			system.hunting.vars.showPrompt = false
		end
		system.hunting.funcs.updateHConfig("showPrompt", system.hunting.vars.showPrompt)
	end
end
send(" ")