system.hunting.defs.attackStrategems["shaman"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "jinx bleed bleed &tar" .. system.hunting.vars.separator .. "curse &tar bleed"
			else
				return "touch hammer &tar"
			end
		end,
	["swift"] = 
		function()
			if tonumber(gmcp.Char.Vitals.wp) > 5000 then
				if not system.hunting.funcs.hasShield() then
					return "swiftcurse &tar bleed"
				else
					return "touch hammer &tar"
				end
			else
				return "invoke roar &tar"
			end
		end
}