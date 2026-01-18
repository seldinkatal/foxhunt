system.hunting.defs.attackStrategems["earth elemental"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if not system.hunting.funcs.hasShield() then
				if system.hunting.vars.earthlord.titan then
					return "terran paste &tar"
				elseif system.hunting.vars.resources.shaping == 4 then
					return "manifest avalanche &tar"
				else
					return "terran pulverise &tar"
				end
			else
				return "terran crunch &tar"
			end
		end,
	["tit"] =
		function()
			if not system.hunting.funcs.hasShield() then
				if system.hunting.vars.earthlord.titan then
					return "terran paste &tar"
				elseif system.hunting.vars.resources.shaping == 4 then
					if not system.hunting.vars.earthlord.titanCooldown then
						return "terran titan"
					else
						return "manifest avalanche &tar"
					end
				else
					return "terran pulverise &tar"
				end
			else
				return "terran crunch &tar"
			end
		end
}