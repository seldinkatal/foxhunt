system.hunting.defs.attackStrategems["bard"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["dam"] =
		function()
			local composition = system.hunting.funcs.getSkillRank("composition")
			-- Bards with at least Skilled in Composition have access to Nomos and can use that in their attack for all situations
			if composition >= system.hunting.defs.skillRanks.skilled then
				return "blade jab &tar torso nomos"
			else
				if not system.hunting.funcs.hasShield() then
					return "blade jab &tar torso"
				else
					return "blade punctuate &tar"
				end
			end
		end
}
