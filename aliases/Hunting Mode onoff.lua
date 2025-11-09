--^(?i)\s*hunt\s*$

local color = "green"
local vars = system.hunting.vars

vars.attacking = false
if vars.hunting == false then
	system.hunting.funcs.initialize()
	
	if system.hunting.vars.separator == nil then
    system.hunting.vars.separator = "||"
		-- send("config separator", false)
	end

	system.hunting.vars.hunting	= true
elseif vars.hunting == true then
	system.hunting.vars.hunting = false
  send("queue clear freestand")
	color = "red"
end

cecho("<red>HUNTING <yellow>mode switched to: <" .. color .. ">" .. tostring(system.hunting.vars.hunting) .. "  "
		.. "<blue>t<yellow>(<white>" .. tostring(vars.targetingMode) .. "<yellow>) "
		.. "<red>a<yellow>(<white>" .. tostring(vars.attackingMode) .. "<yellow>)")
send(" ")