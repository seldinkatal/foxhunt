system.hunting.funcs.ignoreBlacklist = 
	function(area, entry, ignore) 
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified.\n")
				send(" ")
				return
			end
		end

		local global = false
		if area:upper() == "GLOBAL" then
			area = "GLOBAL"
			global = true
		end

		local database = system.hunting.db.blacklist
		local oldRow = db:fetch(database, db:AND(db:eq(database.name, entry), db:eq(database.area, area)))[1]
		if not oldRow then
			if system.hunting.vars.ignoredBlacklist[area] and system.hunting.vars.ignoredBlacklist[area][entry] then
				system.hunting.vars.ignoredBlacklist[area][entry] = nil
			end

			echo("That entry does not exist in the blacklist.\n")
			send(" ")
			return
		end

		local error = false
		if ignore then
			if oldRow.ignore == 1 then
				echo("This entry in the blacklist is already being ignored.\n")
				send(" ")
				error = true
			end
			oldRow.ignore = 1
			if not system.hunting.vars.ignoredBlacklist[area] then
				system.hunting.vars.ignoredBlacklist[area] = {}
			end
			system.hunting.vars.ignoredBlacklist[area][entry] = 1
		else
			if oldRow.ignore == 0 then
				echo("This entry in the blacklist is already not being ignored.\n")
				send(" ")
				error = true
			end
			oldRow.ignore = 0
			if system.hunting.vars.ignoredBlacklist[area] then
				system.hunting.vars.ignoredBlacklist[area][entry] = nil
			end
		end
		db:update(database, oldRow)

		if not error then
			system.hunting.funcs.displayBlacklist(area)
		end
	end

system.hunting.funcs.addBlacklist = 
	function(area, entry, position, display)
    display = display ~= false
    
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified.\n")
				send(" ")
				return
			end
		end

		local global = false
		if area:upper() == "GLOBAL" then
			area = "GLOBAL"
			global = true
		end

		local blacklist = system.hunting.defs.mobBlacklist[area]		
		if global then
			blacklist = system.hunting.defs.globalBlacklist
		end

		if not blacklist then 
			blacklist = {}

			if global then
				system.hunting.defs.globalBlacklist = blacklist	
			else
				system.hunting.defs.mobBlacklist[area] = blacklist
			end
		end

		if table.contains(blacklist, entry) then
			echo("The blacklist already contains that entry.\n")
			send(" ")
			return
		end

		if not position 
			or position > #blacklist 
		then 
			position = #blacklist + 1
		end

		if position < 1 then 
			position = 1
		end
		
		local database = system.hunting.db.blacklist

		if position <= #blacklist then
			for i=#blacklist, position, -1 do
				local row = db:fetch(database, db:AND(db:eq(database.pos, i), db:eq(database.area, area)))[1]
				if row then
					row.pos = i + 1
					db:update(database, row)
				end
			end
		end

		db:add(database, { area = area, pos = position, name = entry })

		if global then
			table.insert(system.hunting.defs.globalBlacklist, position, entry)		
		else		
			table.insert(system.hunting.defs.mobBlacklist[area], position, entry)
		end

    if display then
		  system.hunting.funcs.displayBlacklist(area)
    end
	end

system.hunting.funcs.removeBlacklist = 
	function(area, entry, position, display)
    display = display ~= false
    
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified.\n")
				send(" ")
				return
			end
		end

		local global = false
		if area:upper() == "GLOBAL" then
			area = "GLOBAL"
			global = true
		end

		local blacklist = system.hunting.defs.mobBlacklist[area]		
		if global then
			blacklist = system.hunting.defs.globalBlacklist
		end

		if not blacklist or #blacklist == 0 then 
			echo("A blacklist does not exist for this area, or is empty.\n")
			send(" ")
			return
		end

		if (position and position < 1)
			or (position and position > #blacklist)
		then 
			echo("That position does not exist in the blacklist.\n")
			send(" ")
			return
		end
		
		local database = system.hunting.db.blacklist
		local oldRow = db:fetch(database, db:AND(db:eq(database.name, entry), db:eq(database.area, area)))[1]
		if position then
			oldRow = db:fetch(database, db:AND(db:eq(database.name, entry), db:eq(database.area, area), db:eq(database.pos, position)))[1]
		elseif oldRow then
			position = oldRow.pos 
		end
	
		if not oldRow then
			echo("That entry does not exist in the blacklist.\n")
			send(" ")
			return
		end

		db:delete(database, oldRow._row_id)
		
		if position < #blacklist then
			for i=position+1, #blacklist, 1 do
				local row = db:fetch(database, db:AND(db:eq(database.pos, i), db:eq(database.area, area)))[1]
				row.pos = i - 1
				db:update(database, row)
			end
		end

		if global then
			table.remove(system.hunting.defs.globalBlacklist, position)
		else
			table.remove(system.hunting.defs.mobBlacklist[area], position)
		end

    if display then
		  system.hunting.funcs.displayBlacklist(area)
    end
	end

system.hunting.funcs.shiftBlacklist =
	function(area, entry, direction, amount)
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified.\n")
				send(" ")
				return
			end
		end

		local global = false
		if area:upper() == "GLOBAL" then
			global = true		
			area = "GLOBAL"
		end

		local blacklist = system.hunting.defs.mobBlacklist[area]		
		if global then
			blacklist = system.hunting.defs.globalBlacklist
		end
		if not blacklist then return end

		if direction:trim():lower() == "up" then
			direction = -1
		elseif direction:trim():lower() == "down" then
			direction = 1
		else
			direction = 0
		end

		if not amount or not tonumber(amount) then
			amount = 1
		end

		local database = system.hunting.db.blacklist
		local oldRow = db:fetch(database, db:AND(db:eq(database.area, area), db:eq(database.name, entry)))[1]

		system.hunting.funcs.moveBlacklist(area, entry, oldRow.pos, oldRow.pos + (direction * amount))
	end

system.hunting.funcs.moveBlacklist =
	function(area, entry, oldPosition, newPosition)
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified.\n")
				send(" ")
				return
			end
		end

		if not entry and not oldPosition then
			echo("No denizen specified.\n")
			send(" ")
			return
		end

		local global = false
		if area:upper() == "GLOBAL" then
			global = true		
			area = "GLOBAL"
		end
	
		local blacklist = system.hunting.defs.mobBlacklist[area]
		if global then
			blacklist = system.hunting.defs.globalBlacklist
		end

		local database = system.hunting.db.blacklist
	
		if not blacklist then return end
		if newPosition < 1 then newPosition = 1 end
		if newPosition > #blacklist then newPosition = #blacklist end

		if not oldPosition then
			local row = db:fetch(database, db:AND(db:eq(database.area, area), db:eq(database.name, entry)))[1]
			if row then
				oldPosition = row.pos
			else
				echo("That entry does not exist in the blacklist.\n")
				send(" ")
				return
			end
		end

		if not entry then
			local row = db:fetch(database, db:AND(db:eq(database.area, area), db:eq(database.pos, oldPosition)))[1]
			if row then
				entry = pos.name
			else
				echo("That position does not exist in the blacklist.\n")
				send(" ")
				return
			end
		end

		if oldPosition == newPosition then 
			echo("The starting position and ending position for this entry are the same.\n")
			send(" ")
			return
		end

		local shift = (newPosition - oldPosition) / math.abs(newPosition - oldPosition)
		local oldRow = db:fetch(database, db:AND(db:eq(database.pos, oldPosition), db:eq(database.area, area)))[1]

		for i=oldPosition, newPosition, shift do
			if i == oldPosition then
			else
				local row = db:fetch(database, db:AND(db:eq(database.pos, i), db:eq(database.area, area)))[1]
				row.pos = i + (shift * -1)
				db:update(database, row)

				if i == newPosition then
					oldRow.pos = newPosition
					db:update(database, oldRow)
				end
			end
		end

		if global then
			table.remove(system.hunting.defs.globalBlacklist, oldPosition)
			table.insert(system.hunting.defs.globalBlacklist, newPosition, entry)	
		else
			table.remove(system.hunting.defs.mobBlacklist[area], oldPosition)
			table.insert(system.hunting.defs.mobBlacklist[area], newPosition, entry)	
		end

		system.hunting.funcs.displayBlacklist(area)
	end

system.hunting.funcs.blacklistAreas =
	function()
		local areas = {}
		local database = system.hunting.db.blacklist
		local rows = db:fetch(database, nil, {database.area})
		local found = {}

		for i, row in ipairs(rows) do
			if not found[row.area] and row.area ~= "GLOBAL" then
				table.insert(areas, row.area)
				found[row.area] = true
			end
		end

		if #areas < 1 then
			echo("You have no blacklists.\n")
		else
			echo("You have blacklists for the following areas:\n")

			for i, area in ipairs(areas) do
				cechoLink("<grey>" .. area .. "\n", [[system.hunting.funcs.displayBlacklist("]] .. area .. [[")]], "Show the blacklist for " .. area, true)
			end	
		end

		send(" ")
	end

system.hunting.funcs.chooseBlacklistArea =
	function(areas)
		echo("Your area was unrecognized. Did you mean one of the below areas?\n")
		for _, area in pairs(areas) do
			cechoLink("<grey>" .. area .. "\n", [[system.hunting.funcs.displayBlacklist("]] .. area .. [[")]], "Show the blacklist for " .. area, true)
		end
		send(" ")
	end

system.hunting.funcs.displayBlacklist = 
	function(area)
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified to display blacklist for.\n")
				return
			end
		end

		local global = false
		if area:upper() == "GLOBAL" then
			global = true
			area = "GLOBAL"
		end
		
		local blacklist = system.hunting.defs.mobBlacklist[area]
		if global then
			blacklist = system.hunting.defs.globalBlacklist
		end

		local fromDatabase = true
		if fromDatabase then
			blacklist = {}

			local database = system.hunting.db.blacklist
			local dbBlack = db:fetch(database, db:eq(database.area, area), {database.pos})
			
			if dbBlack then
				for i, v in ipairs(dbBlack) do
					table.insert(blacklist, v.name)
				end 
			end
		end

		if not blacklist or #blacklist < 1 then
			if global then
				echo("No denizens are in the global blacklist.\n")
			else
				echo("No blacklist for this area (" .. area .. ").\n")
			end
		else
			color_table.ansi_three = { 128, 128, 0 }
			color_table.ansi_two = { 0, 179, 0 }
			color_table.ansi_six = { 0, 128, 128 }
			color_table.ansi_eight = { 128, 128, 128 }

			local header = "ansi_three"
			local border = "ansi_two"
			local option = "ansi_six"
			local value = "white"
			local off_value = "ansi_eight"
			local maxLength = 80
			local length = 26 + string.len(area)
			local mobColor = "white"

			if global then
				cecho("<"..border..">+-<"..header..">Global denizen blacklist:<" .. border ..">" .. string.rep("-", maxLength - 29) .. "+\n")	
			else
				cecho("<"..border..">+-<"..header..">Denizen blacklist for: " .. area .. "<" .. border ..">" .. string.rep("-", maxLength - length - 1) .. "+\n")
			end

			for i, mob in ipairs(blacklist) do
				local ignored = false
				if system.hunting.vars.ignoredBlacklist[area] and system.hunting.vars.ignoredBlacklist[area][mob] then
					mobColor = off_value
					ignored = true
				else
					mobColor = "white"
				end
			
				cecho("<"..border..">|   ")
				cechoLink("<"..option..">Up", [[system.hunting.funcs.shiftBlacklist("]] .. area .. [[","]] .. mob .. [[", "up")]] , "Move " .. mob .. " higher on the priority order.", true)
				cecho("  ")
				cechoLink("<"..option..">Down", [[system.hunting.funcs.shiftBlacklist("]] .. area .. [[","]] .. mob .. [[", "down")]], "Move " .. mob .. " lower on the priority order.", true)
				cecho("  ")
				cechoLink("<"..option..">Remove", [[system.hunting.funcs.removeBlacklist("]] .. area .. [[","]] .. mob .. [[", ]] .. tostring(i) .. [[)]], "Remove " .. mob .. " from the blacklist.", true)
				cecho("  <"..mobColor..">" .. i .. "." .. string.rep(" ", string.len(tostring(#blacklist)) + 1 - string.len(tostring(i))))
				if ignored then
					cechoLink("<"..mobColor..">"..mob, [[system.hunting.funcs.ignoreBlacklist("]] .. area .. [[","]] .. mob .. [[", false)]], "Unignore " .. mob .. ".", true)
				else
					cechoLink("<"..mobColor..">"..mob, [[system.hunting.funcs.ignoreBlacklist("]] .. area .. [[","]] .. mob .. [[", true)]], "Ignore " .. mob .. ".", true)
				end
				cecho(string.rep(" ", maxLength - 26 - string.len(mob) - string.len(tostring(#blacklist))) .. "<"..border..">|\n")
			end
			cecho("<"..border..">+" .. string.rep("-", maxLength - 3) .. "+\n")
		end
		send(" ")
	end