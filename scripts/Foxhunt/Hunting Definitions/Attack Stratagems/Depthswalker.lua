system.hunting.defs.attackStrategems["depthswalker"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "wield dagger shield/shadow strike &tar"
			else
				return "wield scythe shield/shadow reap &tar"
			end
		end,
	["cull"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "shadow strike &tar"
			else
				return "shadow cull &tar"
			end
		end
}
