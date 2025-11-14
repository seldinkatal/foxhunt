system.hunting.defs.attackStrategems["apostate"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "deadeyes bleed bleed"
			else
				return "demon strip &tar"
			end
		end,
	["decay"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "decay &tar"
			else
				return "demon strip &tar"
			end
		end
}