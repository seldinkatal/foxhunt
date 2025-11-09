--^(?i)\s*synergy(\s+.+)?$

local params = {}
if matches[2] then
	matches[2] = matches[2]:trim()
	
	if matches[2] ~= "" then
		params = matches[2]:split(" and ")
	end
end

if not params[1] and not params[2] then
	system.hunting.funcs.displaySynergy()
elseif params[1] and not params[2] then
	system.hunting.funcs.displaySynergy(params[1])
elseif params[1] and params[2] then
	system.hunting.funcs.displaySynergy(params[1], params[2])
end