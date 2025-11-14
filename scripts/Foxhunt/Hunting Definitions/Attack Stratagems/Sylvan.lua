system.hunting.defs.attackStrategems["sylvan"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "thornrend &tar"
			else
				return "cast shear at &tar"
			end
		end
}