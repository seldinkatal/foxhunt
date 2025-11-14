system.hunting.defs.attackStrategems["jester"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] = 
		function()
			if system.hunting.funcs.hasShield() then
				return "touch hammer &tar"
			else
				return "bop &tar"
			end
		end
}
