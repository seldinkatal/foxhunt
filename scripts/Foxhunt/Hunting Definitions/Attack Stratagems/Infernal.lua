system.hunting.defs.attackStrategems["infernal"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["decay"] =
		function()
			local stats = gmcp.Char.Vitals.charstats
			local spec = ""
			for i,v in ipairs(stats) do
				stat = string.split(v, ": ")
				if stat[1] == "Spec" then
					spec = stat[2]
				end
			end

			if system.hunting.funcs.hasShield() then
				if spec == "Dual Cutting" then
					return "rsl &tar"
				elseif spec == "Two Handed" then
					return "carve &tar"
				elseif spec == "Sword and Shield" then
					return "combination &tar raze smash"
				end
			else
				return "decay &tar"
			end
		end
}
system.hunting.defs.attackStrategems["infernal"] = table.union(system.hunting.defs.attackStrategems["infernal"], system.hunting.defs.attackStrategems.warriorBase)