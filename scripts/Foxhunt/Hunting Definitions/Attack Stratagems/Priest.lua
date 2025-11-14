system.hunting.defs.attackStrategems["priest"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "angel strip &tar"
			else
				return "smite &tar"
			end
		end
}