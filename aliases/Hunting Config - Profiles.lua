--^(?i)\s*hconfig\s+profiles$

local database = system.hunting.db
local funcs = system.hunting.funcs
local vars = system.hunting.vars
local defs = system.hunting.defs
local profiles = db:fetch(system.hunting.db.profile, nil)
local column

funcs.tableHeaderFooter("Hunting Profiles")
for k,v in ipairs(profiles) do
	if k % 2 == 0 then
		funcs.tableRow(column, funcs.makeColumn(string.title(v.name), v.attackMode .. "/" .. v.battlerageMode))
		column = nil
	else
		column = funcs.makeColumn(string.title(v.name), v.attackMode .. "/" .. v.battlerageMode)
	end
end
if column then 
	funcs.tableRow(column)
end
funcs.tableHeaderFooter()

send(" ")