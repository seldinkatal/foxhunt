system.hunting.defs.attackStrategems["alchemist"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "educe iron &tar"
			else
				return "educe copper &tar"
			end
		end
}