function system.hunting.funcs.loadHConfig(class)
	class = class or system.hunting.funcs.getClass()
	local hprofile = { name = class, attackMode = "dam", battlerageMode = "dam" }
	local hconfigs = {
		profile = hprofile.name,
		attackMode = hprofile.attackMode,
		battlerageMode = hprofile.battlerageMode,
		attackingMode = 1,
		autoGrabGold = 1,
		autoGrabShards = 1,
		ignoreOtherPlayers = 1,
		targetCall = 1,
		targetingMode = 1,
		targetOrder = 1,
		useQueueing = 1,
		whitelistPriorityOrder = 1,
		separator = "||",
    showPrompt = 1,
	}

	local database = system.hunting.db
	-- Retrieve what is currently stored in the database. Order by hconfig name
	local dbconfig = db:fetch(database.hconfig, nil, { database.hconfig.name })
	local dbprofile = db:fetch(database.profile, db:eq(database.profile.name, hprofile.name))

	-- Update what we currently have stored
	if dbconfig then
		for i, config in ipairs(dbconfig) do
      if config then
  			if config.value == "false" then
  				config.value = false
  			elseif config.value == "true" then
  				config.value = true
  			end
  
  			system.hunting.vars[config.name] = config.value
  			-- For every hconfig we have retrieved from the database, remove it from the hconfigs table so that we don't rewrite it
  			hconfigs[config.name] = nil
      end
		end
	end

	if dbprofile[class] then
		system.hunting.funcs.loadProfile(dbprofile[class])
		hprofile = nil
	end

	-- Write any remaining hconfigs. Typically only new hconfigs are stored here
	if table.size(hconfigs) > 0 then
		for config, v in pairs(hconfigs) do
			db:add(database.hconfig, { name = config, value = tostring(system.hunting.vars[config]) })
		end
	end
	if hprofile then
		hprofile.attackMode = system.hunting.vars["attackMode"] or "dam"
		hprofile.battlerageMode = system.hunting.vars["attackMode"] or "dam"
		db:add(database.profile, hprofile)
	end
end

function system.hunting.funcs.updateHConfig(name, value)
	local database = system.hunting.db
	local funcs = system.hunting.funcs
	local class = system.hunting.funcs.getClass()
	local config = db:fetch(database.hconfig, db:eq(database.hconfig.name, name))[1]
	local profile = db:fetch(database.profile, db:eq(database.profile.name, class))[1]

	if not profile then
		-- No profile exists - make one now
		profile = funcs.createProfile()
	end

	value = tostring(value)
	if config.value ~= value then
		config.value = value
		db:update(database.hconfig, config)
	end
	if profile then
		if profile.name == class and profile[name] then
			profile[name] = value
			db:update(database.profile, profile)
		end
	end
end

system.hunting.funcs.loadWhitelists = 
	function()
		local database = system.hunting.db
		local dbconfig = db:fetch(database.whitelist, nil, { database.whitelist.area, database.whitelist.pos })
		local whitelists = {}

		for i, config in ipairs(dbconfig) do
			if not whitelists[config.area] then
				system.hunting.defs.mobWhitelist[config.area] = {}
				whitelists[config.area] = 1
			end
	
			table.insert(system.hunting.defs.mobWhitelist[config.area], config.name)

			if config.ignore > 0 then
				if not system.hunting.vars.ignoredWhitelist[config.area] then
					system.hunting.vars.ignoredWhitelist[config.area] = {}
				end
				system.hunting.vars.ignoredWhitelist[config.area][config.name] = 1
			end
		end

		for area,_ in pairs(system.hunting.defs.mobWhitelist) do
			if not whitelists[area] then
				for i, mob in ipairs(system.hunting.defs.mobWhitelist[area]) do
					db:add(database.whitelist, { area = area, pos = i, name = mob })
				end
			end
		end
	end
system.hunting.funcs.loadWhitelists()

system.hunting.funcs.loadBlacklists = 
	function()
		local database = system.hunting.db
		local dbconfig = db:fetch(database.blacklist, nil, { database.blacklist.area, database.blacklist.pos })
		local blacklists = {}

		for i, config in ipairs(dbconfig) do
			if config.area == "GLOBAL" and not blacklists.GLOBAL then 
				system.hunting.defs.globalBlacklist = {}
			elseif not blacklists[config.area] then
				system.hunting.defs.mobBlacklist[config.area] = {}
			end
			blacklists[config.area] = 1

			if config.area == "GLOBAL" then
				table.insert(system.hunting.defs.globalBlacklist, config.name)
			else 	
				table.insert(system.hunting.defs.mobBlacklist[config.area], config.name)
			end

			if config.ignore > 0 then
				if not system.hunting.vars.ignoredBlacklist[config.area] then
					system.hunting.vars.ignoredBlacklist[config.area] = {}
				end
				system.hunting.vars.ignoredBlacklist[config.area][config.name] = 1
			end
		end

		for area,_ in pairs(system.hunting.defs.mobBlacklist) do
			if not blacklists[area] then
				for i, mob in ipairs(system.hunting.defs.mobBlacklist[area]) do
					db:add(database.blacklist, { area = area, pos = i, name = mob })
				end
			end
		end

		if not blacklists.GLOBAL then
			for i, mob in ipairs(system.hunting.defs.globalBlacklist) do
				db:add(database.blacklist, { area = "GLOBAL", pos = i, name = mob })
			end
		end
	end
system.hunting.funcs.loadBlacklists()

system.hunting.funcs.initialize = 
	function()	
		if gmcp ~= nil then
			gmod.enableModule(gmcp.Char.Status.name, "IRE.Target")
			sendGMCP([[Core.Supports.Add ["IRE.Target 1"] ]])
		end
		system.hunting.funcs.loadHConfig()
	end