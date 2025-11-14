system.hunting.defs.attackStrategems["sentinel"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "rivestrike &tar"
			else
				return "thrust &tar"
			end
		end,
	["maul"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "rivestrike &tar"
			else
				return "maul &tar"
			end
		end
}