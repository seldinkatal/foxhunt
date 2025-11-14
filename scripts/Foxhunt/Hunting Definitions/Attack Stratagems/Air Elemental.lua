system.hunting.defs.attackStrategems["air elemental"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "manifest buffet &tar"
			else
				return "manifest gale &tar"
			end
		end
}