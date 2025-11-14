system.hunting.defs.attackStrategems["magi"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["fl"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "cast firelash at &tar"
			else
				return "cast erode at &tar"
			end
		end,
	["dis"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "staffcast dissolution at &tar"
			else
				return "cast erode at &tar"
			end
		end,
	["hor"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "staffcast horripilation at &tar"
			else
				return "cast erode at &tar"
			end
		end,
	["lig"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "staffcast lightning at &tar"
			else
				return "cast erode at &tar"
			end
		end,
	["sci"] =
		function()
			if not system.hunting.funcs.hasShield() then
				return "staffcast scintilla at &tar"
			else
				return "cast erode at &tar"
			end
		end
}