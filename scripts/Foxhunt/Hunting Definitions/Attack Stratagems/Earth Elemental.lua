system.hunting.defs.attackStrategems["earth elemental"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "terran pulverise &tar"
			else
				return "terran crunch &tar"
			end
		end
}