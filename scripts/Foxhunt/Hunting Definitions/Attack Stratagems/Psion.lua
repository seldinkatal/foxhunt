system.hunting.defs.attackStrategems["psion"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "weave cleave &tar"
			else
				return "weave overhand &tar"
			end
		end,
	["psi"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "psi splinter &tar"
			else
				return "psi shatter &tar"
			end
		end
}