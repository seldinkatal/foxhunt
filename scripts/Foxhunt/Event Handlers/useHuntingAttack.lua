--Events:
--huntingPrompt

function useHuntingAttack()
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs
	if mmp.autowalking then return end
	if not gmcp or not gmcp.Char then
		return
	end

	if funcs.checkEB() then
		vars.attackQueued = false
	end

	if vars.hunting then
		local target = funcs.chooseHuntingTarget()
		local targetChanged = false

		if vars.showPrompt then
			local light_color = "red"
			if funcs.haveBattlerageBalance("light") then light_color = "green" end
			local aff1_color = "red"
			if funcs.haveBattlerageBalance("aff1") then aff1_color = "green" end
			local heavy_color = "red"
			if funcs.haveBattlerageBalance("heavy") then heavy_color = "green" end
			local synergy_color = "red"
			if funcs.haveBattlerageBalance("synergy") then synergy_color = "green" end
			local aff2_color = "red"
			if funcs.haveBattlerageBalance("aff2") then aff2_color = "green" end

			cecho("<yellow>(<" .. light_color .. ">L<yellow>|<" .. heavy_color .. ">H<yellow>|<" .. aff1_color .. ">1<yellow>|<" .. aff2_color .. ">2<yellow>|<" .. synergy_color .. ">S<yellow>)")
		end

		if vars.attacking and vars.attackingMode == "room" then
			vars.attackedRoom = true
		end

		if vars.debug then
			print(" T:" .. target .. "")
		end

		if target == "" or not funcs.isPresent(target) then
			if vars.debug then
				if vars.attacking == true then
					echo("No target")
				end
			end

			funcs.checkAndClearQueue()
			funcs.checkAndGrab()
			funcs.resetTarget()
			vars.attacking = false
			return
		end

		if target ~= vars.currentTargetId then
			funcs.resetTarget()
			vars.currentTargetId = target
			targetChanged = true

			if vars.attackingMode == "single" then
				funcs.checkAndClearQueue()
				funcs.checkAndGrab()
				vars.attacking = false
			end

			if vars.targetingMode == "manual" then
				vars.attacking = false
			elseif not vars.limiters.targeting or targetChanged then
				-- We want to make sure we're not doubling-up on timers, so we're going to kill off any existing timer
				funcs.killTimer(vars.limiters.targeting)
				-- Create a new timer
				vars.limiters.targeting = tempTimer(0.5, [[system.hunting.vars.limiters.targeting = nil]])

				sendGMCP([[IRE.Target.Set "]] ..target.. [["]])

				for _, v in ipairs(vars.denizens) do
					if v.id == target then
						vars.targetName = v.name
					end
				end

				if vars.targetCall then
					funcs.executeAction("pt Target: " .. target)
				else
					-- Blank send to action the GMCP call above
					send(" ")
				end
			end
		end

		if (vars.attackingMode == "single" and vars.attacking)
			or (vars.attackingMode == "room" and vars.attackedRoom)
			or (vars.attackingMode == "auto" and (vars.ignoreOtherPlayers or (not vars.newPeopleInRoom or vars.attacking)))
		then
			local action = funcs.checkAction(funcs.myPrepend() .. funcs.chooseHuntingAttack() .. funcs.myAppend())
			if action ~= "" then
				action = action:gsub(vars.separator, "/")
				if vars.useQueueing then
					if vars.huntingAlias ~= action or not vars.attackQueued then
						if vars.huntingAlias ~= action and not vars.limiters.setting then
							funcs.createAlias(action)
						end
						funcs.queueAttack()
					end
				elseif not vars.limiters.hunting then
					funcs.createAlias(action)
					funcs.executeAction("HUNTING_ATTACK")
				end
			end

			local action = funcs.chooseBattleRage()
			if action ~= "" and not vars.limiters.battlerage then
				if vars.debug then
					echo("battlerage: " .. action)
				end
				funcs.killTimer(vars.limiters.battlerage)
				vars.limiters.battlerage = tempTimer(0.5, [[system.hunting.vars.limiters.battlerage = nil]])
				funcs.executeAction(action)
			end
		end
	end
end