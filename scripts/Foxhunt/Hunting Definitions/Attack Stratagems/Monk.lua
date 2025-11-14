system.hunting.defs.attackStrategems["monk"] = {
	["none"] = system.hunting.defs.attackStrategems.general.none,
	["crush"] =
		function()
			if system.hunting.funcs.getSpec("Tekura") then
				if not system.hunting.funcs.hasShield() then
					return "mind crush &tar"
				else
					return "combo &tar rhk ucp ucp"
				end
			elseif system.hunting.funcs.getSpec("Shikudo") then
				if not system.hunting.funcs.hasShield() then
					return "mind crush &tar"
				else
					return "transition to rain form" .. system.hunting.vars.separator .. "combo &tar shatter frontkick ruku"
				end
			end
		end,
	["dam"] =
		function()
			if system.hunting.funcs.getSpec("Tekura") then
				if not system.hunting.funcs.hasShield() then
					return "combo &tar sdk ucp ucp"
				else
					return "combo &tar rhk ucp ucp"
				end
			elseif system.hunting.funcs.getSpec("Shikudo") then
				local stats = gmcp.Char.Vitals.charstats
				local form = ""
				local action = ""
				local kata = system.hunting.defs.attackStrategems.monk.kata

				for i,v in ipairs(stats) do
					stat = string.split(v, ": ")
					if stat[1] == "Form" then
						form = stat[2]
					end
				end

				if form == "Willow" then
					if kata > 11 then
						action = "transition to rain form"
						form = "Rain"
					end
				end

				if form == "Tykonos" and form == "Oak" then
					if kata > 5 then
						action = "transition to willow form"
						form = "Willow"
					end
				end

				if form == "Rain" or form == "Maelstrom" then
					if kata > 5 then
						action = "transition to oak form"
						form = "Oak"
					end
				end

				if form == "Gaital" then
					if kata > 5 then
						action = "transition to rain form"
						form = "Rain"
					end
				end

				if form == "Tykonos" then
					if not system.hunting.funcs.hasShield() then
						action = action .. system.hunting.vars.separator .. "combo risingkick head thrust head thrust head"
					else
						action = action .. system.hunting.vars.separator .. "combo shatter risingkick head thrust head"
					end
				elseif form == "Willow" then
					if not system.hunting.funcs.hasShield() then
						action = action .. system.hunting.vars.separator .. "combo flashheel left hiru hiraku"
					else
						action = action .. system.hunting.vars.separator .. "combo shatter flashheel left hiraku"
					end
				elseif form == "Rain" then
					if not system.hunting.funcs.hasShield() then
						action = action .. system.hunting.vars.separator .. "combo frontkick left ruku left kuro left"
					else
						action = action .. system.hunting.vars.separator .. "combo shatter frontkick left ruku left"
					end
				elseif form == "Oak" then
					if not system.hunting.funcs.hasShield() then
						action = action .. system.hunting.vars.separator .. "combo risingkick head nervestrike livestrike"
					else
						action = action .. system.hunting.vars.separator .. "combo shatter risingkick head nervestrike"
					end
				elseif form == "Gaital" then
					if not system.hunting.funcs.hasShield() then
						action = action .. system.hunting.vars.separator .. "combo flashheel left ruku left kuro left"
					else
						action = action .. system.hunting.vars.separator .. "combo shatter flashheel left ruku left"
					end
				elseif form == "Maelstrom" then
					if not system.hunting.funcs.hasShield() then
						action = action .. system.hunting.vars.separator .. "combo risingkick head ruku left livestrike"
					else
						action = action .. system.hunting.vars.separator .. "combo shatter risingkick head livestrike"
					end
				else
					action = "transition to willow form"
				end

				return action
			end
		end
}