system.hunting.defs.attackStrategems["pariah"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "trace fissure &tar"
			else
				return "blood wrack &tar"
			end
		end
}