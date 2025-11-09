--^(?i)\s*hconfig\s+whitelistpriorityorder(\s+.*)?$

local valid = {
	"on",
	"off",
}

local info_string = {
	["on"] = " prioritize denizens in the front of the whitelist over those in the back.",
	["off"] = " prioritize denizens in the order in which they appear on IH.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	local val = ""
	if system.hunting.vars.whitelistPriorityOrder == true then
		val = "on"
	else
		val = "off"
	end

	echo("Syntax: HCONFIG WHIETLISTPRIORITYORDER " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set how you want to prioritize targets when using a whitelist.\n")
	echo("\n")
	echo("WHIETLISTPRIORITYORDER is currently set to " .. string.upper(val) .. ". You will" .. info_string[val])
else 
	matches[2] = string.lower(string.trim(matches[2]))

	if matches[2] == "yes" then matches[2] = "on" end
	if matches[2] == "no" then matches[2] = "off" end

	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("You will now" .. info_string[matches[2]])

		if matches[2] == "on" then
			system.hunting.vars.whitelistPriorityOrder = true
		else
			system.hunting.vars.whitelistPriorityOrder = false
		end
		system.hunting.funcs.updateHConfig("whitelistPriorityOrder", system.hunting.vars.whitelistPriorityOrder)
	end
end
send(" ")