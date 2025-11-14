system.hunting.defs.attackStrategems["fire elemental"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			local attack
			if not system.hunting.funcs.hasShield() then
				attack = "ignite flamewhip &tar"
			else
				attack= "manifest superheat &tar"
			end
			return attack
		end
}