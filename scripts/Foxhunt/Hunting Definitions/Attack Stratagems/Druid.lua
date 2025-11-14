system.hunting.defs.attackStrategems["druid"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "maul &tar"
			else
				return "touch hammer &tar"
			end
		end
}