system.hunting.defs.attackStrategems["serpent"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			if system.hunting.funcs.hasShield() then
				return "flay &tar shield"
			else
				return "garrote &tar"
			end
		end,
	["sum"] =
		function()
			return "bite &tar sumac"
		end,
	["cam"] =
		function()
			return "bite &tar camus"
		end
}