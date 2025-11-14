function system.hunting.funcs.getRage()
	for _,stat in ipairs(gmcp.Char.Vitals.charstats) do
		local combo = string.split(stat, ": ")

		if combo[1] == "Rage" then
			return tonumber(combo[2])
		end
	end

	return 0
end

function system.hunting.funcs.handleRageHit(user, target, rage, raze, affs, consume)
	local funcs = system.hunting.funcs
	if string.lower(user) == "you" or string.lower(user) == "your" then
		funcs.loseBattlerageBalance(rage)
		selectString(line, 1)
		fg("green")
	else
		selectString(line, 1)
		fg("yellow")
	end

	if funcs.isHuntingTarget(target) then
		if raze then
			funcs.razeShield()
		end

		if affs then
			for _, aff in ipairs(affs) do
				funcs.addAffliction(aff)
			end
		end

		if consume then
			for _, aff in ipairs(consume) do
				funcs.removeAffliction(aff, target)
			end
		end
	end
end

function system.hunting.funcs.haveBattlerageBalance(attack)
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	local class = string.lower(funcs.getClass())

	if not vars.brBal[class] then
		vars.brBal[class] = {}
		return true
	end

	if vars.brBal[class][attack] == nil then
		vars.brBal[class][attack] = true
	end

	return vars.brBal[class][attack]
end

function system.hunting.funcs.loseBattlerageBalance(attack)
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	funcs.killTimer(vars.brBal.timer)
	vars.brBal.timer = tempTimer(1.3, [[system.hunting.vars.brBal.br = true]])

	local class = string.lower(funcs.getClass())

	if defs.classRage[class] and defs.classRage[class][attack] then
		vars.brBal[class] = vars.brBal[class] or {}

		vars.brBal[class][attack] = false
		local timerName = class .. "_" .. attack

		funcs.killTimer(vars.brBalTimers[timerName])

		if attack == "aff1" or attack == "aff2" then
			rageAttack = defs.classRage[class][attack]["aff"]
		elseif attack == "special" or attack == "special2" then
			rageAttack = attack .. "_" .. class
		else
			rageAttack = attack
		end

		local timerString = "system.hunting.vars.brBal[\""..class.."\"][\""..attack.."\"] = true"

		vars.brBalTimers[timerName] = tempTimer(defs.rageInfo[rageAttack]["cooldown"] + 0.5, timerString)
	end
end

function system.hunting.funcs.hasAffliction(aff)
	local vars = system.hunting.vars

	if vars.mobAffs[aff] and vars.mobAffs[aff].gained then
		return os.clock() - vars.mobAffs[aff].gained
	else
		return false
	end
end

function system.hunting.funcs.addAffliction(aff)
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	if vars.mobAffs[aff] then
		funcs.killTimer(vars.mobAffs[aff].timer)
	end

	vars.mobAffs[aff] = {}
	vars.mobAffs[aff].gained = os.clock()
	vars.mobAffs[aff].timer = tempTimer(defs.afflictionDuration[aff], [[system.hunting.funcs.removeAffliction(aff)]])

	if vars.debug then
		send("pt Target has gained <<< " .. aff:upper() .. " >>>!!!")
	end
	cecho("<yellow> [<green>" .. aff .. "<yellow>]")
end

function system.hunting.funcs.removeAffliction(aff, target)
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	if target ~= nil and not funcs.isHuntingTarget(target) then
		return
	end

	if vars.mobAffs[aff] then
		funcs.killTimer(vars.mobAffs[aff].timer)
		vars.mobAffs[aff] = nil
		cecho("<yellow> [<red>" .. aff .. "<yellow>]")

		if vars.debug then
			send("pt Target has lost --- " .. aff:upper() .. " --- !!!")
		end
	end
end

function system.hunting.funcs.chooseBattleRage()
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	local class = string.lower(funcs.getClass())
	local action = ""

	if vars.battlerageMode == "none" then
		return ""
	end

	if defs.battlerageStrategems[class] then
		if not defs.battlerageStrategems[class][vars.battlerageMode] then
			echo("BATTLERAGESTRAT INVALID, RELOADING PROFILE!!!! IT WAS: " .. vars.battlerageMode .. "\n")
			echo("BATTLERAGESTRAT INVALID, RELOADING PROFILE!!!! IT WAS: " .. vars.battlerageMode .. "\n")
			echo("BATTLERAGESTRAT INVALID, RELOADING PROFILE!!!! IT WAS: " .. vars.battlerageMode .. "\n")
			echo("BATTLERAGESTRAT INVALID, RELOADING PROFILE!!!! IT WAS: " .. vars.battlerageMode .. "\n")
			echo("BATTLERAGESTRAT INVALID, RELOADING PROFILE!!!! IT WAS: " .. vars.battlerageMode .. "\n")

			funcs.reloadProfile()
		end

		action = defs.battlerageStrategems[class][vars.battlerageMode]()
	end

	return action
end