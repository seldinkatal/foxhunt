system.hunting.defs.battlerageStrategems.general.pullBase =
	function(raze)
		local defs = system.hunting.defs
		local vars = system.hunting.vars
		local funcs = system.hunting.funcs

		local rage = funcs.getRage()
		local action = ""
		local class = string.lower(funcs.getClass())

		local heavy = defs.classRage[class]["heavy"]
		local raze = defs.classRage[class]["raze"]
		local synergy = defs.classRage[class]["synergy"]
		local special = defs.classRage[class].special

		local rageInfo = defs.rageInfo

		local baseRageBuffer = rageInfo.light.cost
		if raze == true then
			baseRageBuffer = baseRageBuffer + rageInfo.raze.cost
		end

		if vars.brBal.br then
			if funcs.haveBattlerageBalance("synergy") and rage >= (rageInfo.synergy.cost + baseRageBuffer)
				and (
					funcs.hasAffliction(synergy.aff1)
					or funcs.hasAffliction(synergy.aff2)
				)
			then
				action = synergy.com
			elseif raze == true
				and rage >= baseRageBuffer and funcs.hasShield()
				and not funcs.hasAffliction(synergy.aff1)
				and not funcs.hasAffliction(synergy.aff2)
			then
				action = raze.com
			elseif funcs.haveBattlerageBalance("heavy")
				and rage >= (rageInfo.heavy.cost + baseRageBuffer)
				and funcs.getTargetHealth() > 10
				and not funcs.hasAffliction(synergy.aff1)
				and not funcs.hasAffliction(synergy.aff2)
			then
				action = heavy.com
			elseif funcs.getClass() == "fire elemental" and funcs.haveBattlerageBalance("special") and rage >= (30 + baseRageBuffer) then
				action = special.com
			end
		end

		return action
	end
system.hunting.defs.battlerageStrategems.general.praze = system.hunting.defs.battlerageStrategems.general.pullBase(true)
system.hunting.defs.battlerageStrategems.general.pnoraze = system.hunting.defs.battlerageStrategems.general.pullBase(false)
