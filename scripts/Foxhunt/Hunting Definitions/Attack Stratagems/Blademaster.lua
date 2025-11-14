system.hunting.defs.attackStrategems["blademaster"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "drawslash &tar"
			else
				return "raze &tar"
			end		
		end,
	["burst"] = 
		function()
			return "burst &tar"
		end
}