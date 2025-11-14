function system.hunting.funcs.resolveArea(str)
	local areas = {}

	for area,_ in pairs(system.hunting.defs.mobWhitelist) do
		areas[area:lower()] = area
	end

	for area,_ in pairs(system.hunting.defs.mobBlacklist) do
		areas[area:lower()] = area
	end

	local raw = str
	str = str:trim()
	str = str:lower()

	if areas[str] then
		return { areas[str] }
	end	

	local found = {}
	for area,fullarea in pairs(areas) do
		if string.find(area, str) then
			table.insert(found, fullarea)
		end
	end

	return found
end

function system.hunting.funcs.isGMCPvalid()
	local valid = true

	if gmcp == nil 
		or gmcp.IRE == nil
		or gmcp.IRE.Target == nil
		or gmcp.IRE.Target.Set == "Invalid"
	then
		valid = false
	end

	return valid
end

function system.hunting.funcs.executeAction(action, flags)
	if system.general then
		system.general.funcs.executeAction(action, flags)
	else
		send(action,false)
	end
end

function system.hunting.funcs.getClass()
	local class = gmcp.Char.Status.class

	if class:find("Elemental") then
		class = class:gsub(" Lady", "")
		class = class:gsub(" Lord", "")
	end

	return class:lower()
end

function system.hunting.funcs.getSpec(specialization)
	local spec = ""
	local class = gmcp.Char.Status.class

	if class == "Monk" then
		local stats = gmcp.Char.Skills.Groups
		for _,v in ipairs(stats) do
			if v.name == "Tekura" or v.name == "Shikudo" then
				spec = v.name
				break
			end		
		end
	else
		local stats = gmcp.Char.Vitals.charstats
		for i,v in ipairs(stats) do
			stat = string.split(v, ": ")
			if stat[1] == "Spec" then
				spec = stat[2]
			end
		end
	end

	if specialization then
		return string.lower(specialization) == string.lower(spec)
	else
		return spec
	end
end

function system.hunting.funcs.isHindered()
	if affs then
		return 
			affs.paralysis
			or affs.webbed
			or affs.asleep
			or affs.transfixed
			or affs.aeon	
			or (
				affs.prone
				and (
					affs.damagedleftleg
					or affs.damagedrightleg
				)
			)	
	else
		return false
	end
end

function system.hunting.funcs.resetLimiter(limiter)
	system.hunting.funcs.killTimer(system.hunting.vars.limiters[limiter])
	system.hunting.vars.limiters[limiter] = nil
end


function system.hunting.funcs.getDragonBreath()
	return system.hunting.defs.dragonBreath[system.hunting.funcs.getClass()] or ""
end

function system.hunting.funcs.killTimer(timerID)
	if timerID then
		killTimer(timerID)
		timerID = nil
	end
end

function system.hunting.funcs.getSkillRank(skill)
	-- A value of -1 will indicate you don't have the skill
	local skillRank = -1
	-- Make sure it is in lower case for consistency
	skill = string.lower(skill)
	for k,v in pairs(gmcp.Char.Skills.Groups) do
		local name = string.lower(v.name)
		local rank = string.lower(v.rank)
		if name == skill and system.hunting.defs.skillRanks and system.hunting.defs.skillRanks[rank] then
			skillRank = system.hunting.defs.skillRanks[rank]
			break
		end
	end
	return skillRank
end
