system.hunting.funcs = system.hunting.funcs or {}

function system.hunting.funcs.chooseHuntingTarget()
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs
	local area = gmcp.Room.Info.area

	local denizens = vars.denizens
	if vars.targetOrder == "numeric" then
		table.sort(denizens, function(a,b) return tonumber(a.id) < tonumber(b.id) end)
	elseif vars.targetOrder == "reverse" then
		local reverse = {}
		local count = #denizens
		for i,v in ipairs(denizens) do
			reverse[count + 1 - i] = v
		end
		denizens = reverse
	end

	if vars.targetingMode == "manual" then
		return vars.currentTargetId
	elseif vars.targetingMode == "whitelist" then
		if vars.attacking == true and vars.currentTargetId ~= "" then
			return vars.currentTargetId
		end

		local ignoreList = {}
		if defs.mobWhitelist[area] == nil then
			return ""
		end

		if vars.ignoredWhitelist[area] then
			ignoreList = vars.ignoredWhitelist[area]
		end

		if vars.whitelistPriorityOrder then
			for _, mob in ipairs(defs.mobWhitelist[area]) do
				for _, denizen in ipairs(denizens) do
					if denizen.name == mob
						and denizen.attrib ~= nil
						and denizen.attrib:find("m")
						and not denizen.attrib:find("d")
						and not denizen.attrib:find("x")
						and (
							not table.contains(defs.globalBlacklist, denizen.name)
							or table.contains(vars.ignoredBlacklist.GLOBAL, denizen.name)
						)
						and not table.contains(ignoreList, denizen.name)
					then
						return denizen.id
					end
				end
			end
		else
			for _, denizen in ipairs(denizens) do
				if table.contains(defs.mobWhitelist[area], denizen.name)
					and denizen.attrib ~= nil
					and denizen.attrib:find("m")
					and not denizen.attrib:find("d")
					and not denizen.attrib:find("x")
					and (
						not table.contains(defs.globalBlacklist, denizen.name)
						or table.contains(vars.ignoredBlacklist.GLOBAL, denizen.name)
					)
					and not table.contains(ignoreList, denizen.name)
				then
					return denizen.id
				end
			end
		end
		return ""
	elseif vars.targetingMode == "blacklist" then
		if vars.attacking == true and vars.currentTargetId ~= "" then
			return vars.currentTargetId
		end

		if defs.mobBlacklist[area] == nil then
			defs.mobBlacklist[area] = {}
		end

		local ignoreList = {}
		if vars.ignoredBlacklist[area] then
			ignoreList = vars.ignoredBlacklist[area]
		end

		for _, denizen in ipairs(denizens) do
			if denizen.attrib ~= nil
				and denizen.attrib:find("m")
				and not denizen.attrib:find("d")
				and not denizen.attrib:find("x")
				and (
					not table.contains(defs.mobBlacklist[area], denizen.name)
					or table.contains(ignoreList, denizen.name)
				)
				and (
					not table.contains(defs.globalBlacklist, denizen.name)
					or table.contains(vars.ignoredBlacklist.GLOBAL, denizen.name)
				)
			then
				return denizen.id
			end
		end
		return ""
	elseif vars.targetingMode == "auto" then
		if vars.attacking == true and vars.currentTargetId ~= "" then
			return vars.currentTargetId
		end

		for id, denizen in pairs(denizens) do
			if denizen.attrib ~= nil
				and denizen.attrib:find("m")
				and not denizen.attrib:find("d")
				and not denizen.attrib:find("x")
				and (
					not table.contains(defs.globalBlacklist, denizen.name)
					or table.contains(vars.ignoredBlacklist.GLOBAL, denizen.name)
				)
			then
				return denizen.id
			end
		end
		return ""
	end
end

function system.hunting.funcs.checkEB()
	return gmcp.Char.Vitals.bal == "1" and gmcp.Char.Vitals.eq == "1"
end

function system.hunting.funcs.chooseHuntingAttack()
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	local class = string.lower(funcs.getClass())

	local action = ""
	if gmcp ~= nil and ((funcs.checkEB() and not funcs.isHindered()) or (vars.useQueueing and not funcs.isHindered())) then
		if defs.attackStrategems[class] ~= nil then
			if defs.attackStrategems[class][vars.attackMode] == nil then
				vars.attackMode = "dam"
			end
			action = defs.attackStrategems[class][vars.attackMode]()
		end

		funcs.checkAndGrab()
		if action ~= "" then
			action = "stand" .. vars.separator .. action
		end
	end
	return action
end

function system.hunting.funcs.reloadProfile()
	local funcs = system.hunting.funcs
	local class = funcs.getClass()
	local database = system.hunting.db
	local profile = db:fetch(database.profile, db:eq(database.profile.name, class))[1]
	if not profile then
		profile = funcs.createProfile()
	end
	funcs.loadProfile(profile)
end

function system.hunting.funcs.loadProfile(profile)
	local vars = system.hunting.vars
	if profile then
		vars.profile = profile.name
		vars.attackMode = profile.attackMode
		vars.battlerageMode = profile.battlerageMode
	else
		vars.profile = system.hunting.funcs.getClass()
	end
end

function system.hunting.funcs.createProfile()
	local class = system.hunting.funcs.getClass()
	local database = system.hunting.db
	local profile = db:fetch(database.profile, db:eq(database.profile.name, class))[1]
	if not profile then
		echo("RESET PROFILE FOR " .. string.upper(class) .. "!!!!\n")
		echo("RESET PROFILE FOR " .. string.upper(class) .. "!!!!\n")
		echo("RESET PROFILE FOR " .. string.upper(class) .. "!!!!\n")
		echo("RESET PROFILE FOR " .. string.upper(class) .. "!!!!\n")
		echo("RESET PROFILE FOR " .. string.upper(class) .. "!!!!\n")
		profile = { name = class, attackMode = "dam", battlerageMode = "dam" }
		db:add(database.profile, profile)
		system.hunting.funcs.loadProfile(profile)
	end
	return profile
end

function system.hunting.funcs.customQueueAttack()
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs
	-- Add your logical checks here
	if false then
		funcs.setLimiter("hunting")
	end
end

function system.hunting.funcs.postAttack()
	local vars = system.hunting.vars
	vars.actionOverride = false
	vars.newAction = nil
end

function system.hunting.funcs.createAlias(action)
	local vars = system.hunting.vars
	local defs = system.hunting.defs
	local funcs = system.hunting.funcs

	funcs.setLimiter("setting")
	funcs.executeAction("setalias HUNTING_ATTACK " .. action)
end

function system.hunting.funcs.queueAttack()
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs
	local add = false
	if not vars.attackQueued and not vars.limiters.hunting then
		if ori then
			if not ori.affs.aeon and (funcs.checkEB() or not table.contains(ori.queues.eb, "HUNTING_ATTACK")) then
				add = true
			end
		elseif wsys then
			if not wsys.isslowed() and (funcs.checkEB() or not vars.attackQueued) then
				add = true
			end
		elseif svo then
			if not svo.affl.aeon and (funcs.checkEB() or not vars.attackQueued) then
				add = true
			end
		else
			-- Unknown system! Relying on custom queue attack code
			funcs.customQueueAttack()
		end
	end

	if add == true then
		funcs.setLimiter("hunting")
		funcs.executeAction("queue addclear freestand HUNTING_ATTACK")
	end
end

function system.hunting.funcs.checkAction(action)
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs
	vars.actionOverride = vars.actionOverride or false

	if vars.actionOverride == false then
		if wsys then
			if wsys.isslowed() and wanttodiag == 0 then
				vars.actionOverride = true
				vars.newAction = ""
			elseif wanttodiag == 1 then
				enableTrigger("Diagnose")
				funcs.killTimer(wsys.timer.diagwait)
				wsys.timer.diagwait = tempTimer(wsys.myPing() * 3, [[wsys.timer.diagwait = nil;disableTrigger("Diagnose")]])
				vars.actionOverride = true
				vars.newAction = "diagnose"
			elseif wanttocatarin == 1 then
				vars.actionOverride = true
				vars.newAction = "legenddeck draw catarin"
			end
		end
	end

	if vars.actionOverride == true then
		action = vars.newAction
	end

	return action
end

function system.hunting.funcs.tryOverride(action)
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs
	if vars.hunting and vars.attacking then
		vars.actionOverride = true
		vars.attackQueued = false
		vars.newAction = action

		if vars.limiters.hunting then
			funcs.killTimer(vars.limiters.hunting)
			vars.limiters.hunting = nil
		end

		if vars.limiters.setting then
			funcs.killTimer(vars.limiters.setting)
			vars.limiters.setting = nil
		end

    send(" ")
	else
		vars.actionOverride = false
		vars.newAction = nil
	end
	return vars.actionOverride
end

function system.hunting.funcs.myPrepend()
	-- Ensure that if this is filled out with anything that it ends with the command separator (vars.separator)
	local prepend = ""
	if ori then
		prepend = ori.prepend()

		if system.hunting.funcs.getClass() == "fire elemental" then
			if ori.cla.fire.bals.slough and ori.vitals.spark == 4 and (ori.affs.blackout or ori.ssc.unknownAffs > 0) then
				prepend = prepend .. "slough impurities invoke" .. system.hunting.vars.separator
			end
		end
	end
	return prepend
end

function system.hunting.funcs.myAppend()
	-- If necessary, start the append with the command separator (vars.separator)
	local append = ""
	return append
end

function system.hunting.funcs.checkAndClearQueue()
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	if vars.useQueueing and (vars.attackQueued or vars.limiters.hunting) then
		send("clearqueue all", false)
		vars.attackQueued = false
		funcs.removeLimiter("hunting")
	end
end

function system.hunting.funcs.checkAndGrab()
	local defs = system.hunting.defs
	local vars = system.hunting.vars

	if vars.attacking then
		if vars.autoGrabGold then
			if vars.goldDropped then
				send("queue prepend eb get sovereigns" .. vars.separator .. table.concat(vars.customGold, vars.separator), false)
				vars.goldDropped = false
			elseif vars.goldAttracted then
				send("queue prepend eb " .. table.concat(vars.customGold, vars.separator), false)
				vars.goldAttracted = false
			end
		end

		if vars.shardsDropped and vars.autoGrabShards then
			send("queue prepend eb get shard", false)
			vars.shardsDropped = false
		end
	end
end