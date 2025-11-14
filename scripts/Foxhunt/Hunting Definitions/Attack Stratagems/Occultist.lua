system.hunting.defs.attackStrategems["occultist"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "warp &tar"
			else
				return "touch hammer &tar"
			end
		end
}