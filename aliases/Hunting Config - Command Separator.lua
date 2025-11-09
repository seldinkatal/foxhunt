--^(?i)\s*hconfig\s+separator(\s+.*)?$

if matches[2] == nil or matches[2] == "" then
	echo("SEPARATOR is currently set to " .. system.hunting.vars.separator .. ".")
else 
	local separator = string.trim(matches[2])
	echo("SEPARATOR changed to " .. separator)
	system.hunting.vars.separator = separator
	system.hunting.funcs.updateHConfig("separator", system.hunting.vars.separator)
end
send(" ")