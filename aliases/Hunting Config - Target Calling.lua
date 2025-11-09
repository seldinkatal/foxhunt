--^(?i)\s*hconfig\s+targetcall(\s+.*)?$

local valid = {
	"yes",
	"no"
}

local info_string = {
	["yes"] = " call out targets on party talk.",
	["no"] = " not call out targets on party talk.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	local val = ""
	if system.hunting.vars.targetCall == true then
		val = "yes"
	else
		val = "no"
	end

	echo("Syntax: HCONFIG TARGETCALL " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set whether or not you'd like to call out targets over party talk.\n")
	echo("\n")
	echo("TARGETCALL is currently set to " .. string.upper(val) .. ". You will" .. info_string[val])
else 
	matches[2] = string.lower(string.trim(matches[2]))

	if matches[2] == "on" then matches[2] = "yes" end
	if matches[2] == "off" then matches[2] = "no" end

	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("You will now" .. info_string[matches[2]])

		if matches[2] == "yes" then
			system.hunting.vars.targetCall = true
		else
			system.hunting.vars.targetCall = false
		end
		system.hunting.funcs.updateHConfig("targetCall", system.hunting.vars.targetCall)
	end
end
send(" ")