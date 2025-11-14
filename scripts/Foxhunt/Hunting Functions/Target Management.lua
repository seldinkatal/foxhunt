function system.hunting.funcs.hasShield()
	local vars = system.hunting.vars

	if vars.targetShield then
		return os.clock() - vars.targetShield.gained
	else
		return false
	end
end

function system.hunting.funcs.razeShield()
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	if vars.targetShield then
		funcs.killTimer(vars.targetShield.timer)
		vars.targetShield = nil

		if vars.useQueueing then
			funcs.resetLimiter("setting")
		end
	end
end

function system.hunting.funcs.addShield()
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	if vars.targetShield and vars.targetShield.timer then
		funcs.killTimer(vars.targetShield.timer)
	end

	vars.targetShield = {}
	vars.targetShield.gained = os.clock()
	vars.targetShield.timer = tempTimer(3, [[system.hunting.funcs.razeShield()]])

	if vars.useQueueing then
		funcs.resetLimiter("setting")
	end
end

function system.hunting.funcs.getTargetHealth()
	if system.hunting.funcs.isGMCPvalid()
		and gmcp.IRE.Target.Info ~= nil
		and gmcp.IRE.Target.Info.hpperc ~= nil
	then
		local num = gmcp.IRE.Target.Info.hpperc:gsub("%%", "")
		return tonumber(num)
	else
		return 100
	end
end

function system.hunting.funcs.isHuntingTarget(target)
	return string.lower(target) == string.lower(system.hunting.vars.targetName)
end

function system.hunting.funcs.isPresent(target)
	for _,v in ipairs(system.hunting.vars.denizens) do
		if v.id == target then
			return true
		end
	end
	return false
end

function system.hunting.funcs.resetTarget()
	system.hunting.vars.targetName = ""
	system.hunting.vars.mobAffs = {}
	system.hunting.vars.targetShield = nil
end
