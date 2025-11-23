system.hunting.defs.attackStrategems = system.hunting.defs.attackStrategems or {}

system.hunting.defs.attackStrategems.general = {
	["none"] =
		function()
			return ""
		end
}

local function warriorBaseDualCutting()
	if not system.hunting.funcs.hasShield() then
		return "dsl &tar"
	else
		return "rsl &tar"
	end
end

local function warriorBaseTwoHanded(blade)
	local command = "battlefury focus speed" .. system.hunting.vars.separator
	if not system.hunting.funcs.hasShield() then
		command = command .. "slaughter &tar"
	else
		if blade then
			command = command .. "carve &tar"
		else
			command = command .. "splinter &tar"
		end
	end
	return command
end

local function warriorBaseSwordShield(main)
	local command = "combination &tar "
	main = main or "slice"
	if not system.hunting.funcs.hasShield() then
		command = command .. main
	else
		command = command .. "raze"
	end
	command = command .. " smash"
	return command
end

system.hunting.defs.attackStrategems.warriorBase = {
	["dam"] =
		function()
			local stats = gmcp.Char.Vitals.charstats
			local spec = ""
			for i,v in ipairs(stats) do
				stat = string.split(v, ": ")
				if stat[1] == "Spec" then
					spec = stat[2]
				end
			end

			if spec == "Dual Cutting" then
				return warriorBaseDualCutting()
			elseif spec == "Two Handed" then
				return warriorBaseTwoHanded(true)
			elseif spec == "Sword and Shield" then
				return warriorBaseSwordShield()
			end
		end,
	["rend"] =
		function()
			local stats = gmcp.Char.Vitals.charstats
			local spec = ""
			for i,v in ipairs(stats) do
				stat = string.split(v, ": ")
				if stat[1] == "Spec" then
					spec = stat[2]
				end
			end

			if spec == "Dual Cutting" then
				return warriorBaseDualCutting()
			elseif spec == "Two Handed" then
				return warriorBaseTwoHanded(true)
			elseif spec == "Sword and Shield" then
				return warriorBaseSwordShield("rend")
			end
		end,
	["break"] =
		function()
			local stats = gmcp.Char.Vitals.charstats
			local spec = ""
			for i,v in ipairs(stats) do
				stat = string.split(v, ": ")
				if stat[1] == "Spec" then
					spec = stat[2]
				end
			end

			if spec == "Dual Cutting" then
				return warriorBaseDualCutting()
			elseif spec == "Two Handed" then
				return warriorBaseTwoHanded(true)
			elseif spec == "Sword and Shield" then
				return warriorBaseSwordShield("guardbreak")
			end
		end,
	["ham"] =
		function()
			local stats = gmcp.Char.Vitals.charstats
			local spec = ""
			for i,v in ipairs(stats) do
				stat = string.split(v, ": ")
				if stat[1] == "Spec" then
					spec = stat[2]
				end
			end

			if spec == "Dual Cutting" then
				return warriorBaseDualCutting()
			elseif spec == "Two Handed" then
				return warriorBaseTwoHanded(false)
			elseif spec == "Sword and Shield" then
				return warriorBaseSwordShield()
			end
		end
}

system.hunting.defs.attackStrategems.dragonBase = {
	["gut"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "blast &tar"
			else
				if tonumber(gmcp.Char.Vitals.ep) < 1000 then
					return "summon " .. system.hunting.funcs.getDragonBreath() .. system.hunting.vars.separator .. "incantation &tar"
				else
					return "summon " .. system.hunting.funcs.getDragonBreath() .. system.hunting.vars.separator .. "gut &tar"
				end
			end
		end,
	["mag"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "blast &tar"
			else
				if tonumber(gmcp.Char.Vitals.wp) < system.hunting.defs.incantationLimit then
					return "summon " .. system.hunting.funcs.getDragonBreath() .. system.hunting.vars.separator .. "gut &tar"
				else
					return "summon " .. system.hunting.funcs.getDragonBreath() .. system.hunting.vars.separator .. "incantation &tar"
				end
			end
		end,
	["jab"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "blast &tar"
			else
				return "summon " .. system.hunting.funcs.getDragonBreath() .. system.hunting.vars.separator .. "jab &tar"
			end
		end
}