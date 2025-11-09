--^(?i)\s*run\s*$

local funcs = system.hunting.funcs
system.hunting.vars.attacking = false
system.hunting.vars.hunting = false

if system.hunting.vars.lastRoomDir == "" then
	cecho("<red>No flee direction set. Panic!\n")
	send(" ")
else
	local action = "wake/wake/apply mending to legs/" .. system.hunting.vars.lastRoomDir
	system.hunting.vars.fleeing = tempTimer(2, [[system.hunting.vars.fleeing = false]])
	funcs.executeAction("setalias HUNTING_ATTACK " .. action)
	funcs.executeAction("queue addclear freestand HUNTING_ATTACK")
end