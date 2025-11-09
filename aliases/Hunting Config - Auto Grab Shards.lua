--^(?i)\s*hconfig\s+autograbshards(\s+.*)?$

local valid = {
	"yes",
	"no"
}

local info_string = {
	["yes"] = " automatically grab shards that drop when hunting.",
	["no"] = " not automatically grab shards that drop when hunting.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	local val = ""
	if system.hunting.vars.autoGrabShards == true then
		val = "yes"
	else
		val = "no"
	end

	echo("Syntax: HCONFIG AUTOGRABSHARDS " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set whether or not you'd like to automatically grab shards that drop when hunting.\n")
	echo("\n")
	echo("AUTOGRABSHARDS is currently set to " .. string.upper(val) .. ". You will" .. info_string[val])
else 
	matches[2] = string.lower(string.trim(matches[2]))

	if matches[2] == "on" then matches[2] = "yes" end
	if matches[2] == "off" then matches[2] = "no" end

	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("You will now" .. info_string[matches[2]])

		if matches[2] == "yes" then
			system.hunting.vars.autoGrabShards = true
		else
			system.hunting.vars.autoGrabShards = false
		end
		system.hunting.funcs.updateHConfig("autoGrabShards", system.hunting.vars.autoGrabShards)
	end
end
send(" ")