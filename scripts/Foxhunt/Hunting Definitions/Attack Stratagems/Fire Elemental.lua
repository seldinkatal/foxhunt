system.hunting.defs.attackStrategems["fire elemental"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			local attack
			if not system.hunting.funcs.hasShield() then
				attack = "ignite flamewhip &tar"
			else
				attack = "manifest superheat &tar"
			end
			return attack
		end,
	["inv"] =
		function()
			local attack
			if not system.hunting.funcs.hasShield() then
				attack = "ignite flamewhip &tar"
				if system.hunting.vars.resources.spark == 4 then
					local addInvoke = true
					if system.hunting.vars.firelord.invokeAction then
						if system.hunting.vars.firelord.invokeAction ~= "flamewhip" then
							addInvoke = false
						end
					end

					if addInvoke then
						attack = attack .. " invoke"
						system.hunting.vars.firelord.invokeAction = "flamewhip"
					end
				end
			else
				attack = "manifest superheat &tar"
			end
			return attack
		end
}