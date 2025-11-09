--^(?i)\s*hconfig\s+attacking(\s+.*)?$

local valid = {
	"off",
	"single",
	"room",
	"auto",
}

local info_string = {
	["off"] = " not automatically attack at all.",
	["single"] = " not automatically initiate attack and will stop attacking when your target is slain.",
	["room"] = " not automatically initiate attack, but will attack any and all valid targets once you do.",
	["auto"] = " automatically attack any and all valid targets.",
}

if matches[2] == nil or string.lower(string.trim(matches[2])) == "" then
	local valid_string = {}

	for _,type in ipairs(valid) do
		table.insert(valid_string, string.upper(type))
	end

	echo("Syntax: HCONFIG ATTACKING " .. table.concat(valid_string, "|") .. "\n")
   echo("        Set how you want to attack denizens.\n")
	echo("\n")
	echo("ATTACKING is currently set to " .. string.upper(system.hunting.vars.attackingMode) .. ". You will" .. info_string[system.hunting.vars.attackingMode])
else 
	matches[2] = string.lower(string.trim(matches[2]))
	if not table.contains(valid, matches[2]) then
		echo("That's not something you can configure.")
	else
		echo("You will now" .. info_string[matches[2]])
		system.hunting.vars.attackingMode = matches[2]
		system.hunting.funcs.updateHConfig("attackingMode", system.hunting.vars.attackingMode)
	end
end
send(" ")