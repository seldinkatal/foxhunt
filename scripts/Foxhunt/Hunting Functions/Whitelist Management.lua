system.hunting.funcs.ignoreWhitelist = 
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

		local database = system.hunting.db.whitelist
		local oldRow = db:fetch(database, db:AND(db:eq(database.name, entry), db:eq(database.area, area)))[1]
		if not oldRow then
			if system.hunting.vars.ignoredWhitelist[area] and system.hunting.vars.ignoredWhitelist[area][entry] then
				system.hunting.vars.ignoredWhitelist[area][entry] = nil
			end

			echo("That entry does not exist in the whitelist.\n")
			send(" ")
			return
		end

		local error = false
		if ignore then
			if oldRow.ignore == 1 then
				echo("This entry in the whitelist is already being ignored.\n")
				send(" ")
				error = true
			end
			oldRow.ignore = 1
			if not system.hunting.vars.ignoredWhitelist[area] then
				system.hunting.vars.ignoredWhitelist[area] = {}
			end
			system.hunting.vars.ignoredWhitelist[area][entry] = 1
		else
			if oldRow.ignore == 0 then
				echo("This entry in the whitelist is already not being ignored.\n")
				send(" ")
				error = true
			end
			oldRow.ignore = 0
			if system.hunting.vars.ignoredWhitelist[area] then
				system.hunting.vars.ignoredWhitelist[area][entry] = nil
			end
		end
		db:update(database, oldRow)

		if not error then
			system.hunting.funcs.displayWhitelist(area)
		end
	end

system.hunting.funcs.addWhitelist = 
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

		local whitelist = system.hunting.defs.mobWhitelist[area]		

		if not whitelist then 
			whitelist = {}
			system.hunting.defs.mobWhitelist[area] = whitelist
		end

		if table.contains(whitelist, entry) then
			echo("The whitelist already contains that entry.\n")
			send(" ")
			return
		end

		if not position 
			or position > #whitelist 
		then 
			position = #whitelist + 1
		end

		if position < 1 then 
			position = 1
		end
		
		local database = system.hunting.db.whitelist

		if position <= #whitelist then
			for i=#whitelist, position, -1 do
				local row = db:fetch(database, db:AND(db:eq(database.pos, i), db:eq(database.area, area)))[1]
				if row then
					row.pos = i + 1
					db:update(database, row)
				end
			end
		end

		db:add(database, { area = area, pos = position, name = entry })

		table.insert(system.hunting.defs.mobWhitelist[area], position, entry)
    if display then
		  system.hunting.funcs.displayWhitelist(area)
    end
	end

system.hunting.funcs.removeWhitelist = 
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

		local whitelist = system.hunting.defs.mobWhitelist[area]		

		if not whitelist or #whitelist == 0 then 
			echo("A whitelist does not exist for this area, or is empty.\n")
			send(" ")
			return
		end

		if (position and position < 1)
			or (position and position > #whitelist)
		then 
			echo("That position does not exist in the whitelist.\n")
			send(" ")
			return
		end
		
		local database = system.hunting.db.whitelist
		local oldRow = db:fetch(database, db:AND(db:eq(database.name, entry), db:eq(database.area, area)))[1]
		if position then
			oldRow = db:fetch(database, db:AND(db:eq(database.name, entry), db:eq(database.area, area), db:eq(database.pos, position)))[1]
		elseif oldRow then
			position = oldRow.pos 
		end
	
		if not oldRow then
			echo("That entry does not exist in the whitelist.\n")
			send(" ")
			return
		end

		db:delete(database, oldRow._row_id)
		
		if position < #whitelist then
			for i=position+1, #whitelist, 1 do
				local row = db:fetch(database, db:AND(db:eq(database.pos, i), db:eq(database.area, area)))[1]
				row.pos = tostring(i - 1)
				db:update(database, row)
			end
		end

		table.remove(system.hunting.defs.mobWhitelist[area], position)

    if display then
		  system.hunting.funcs.displayWhitelist(area)
    end
	end

system.hunting.funcs.shiftWhitelist =
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

		local whitelist = system.hunting.defs.mobWhitelist[area]		

		if not whitelist then return end

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

		local database = system.hunting.db.whitelist
		local oldRow = db:fetch(database, db:AND(db:eq(database.area, area), db:eq(database.name, entry)))[1]

		system.hunting.funcs.moveWhitelist(area, entry, oldRow.pos, oldRow.pos + (direction * amount))
	end

system.hunting.funcs.moveWhitelist =
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

		local whitelist = system.hunting.defs.mobWhitelist[area]

		local database = system.hunting.db.whitelist
	
		if not whitelist then return end
		if newPosition < 1 then newPosition = 1 end
		if newPosition > #whitelist then newPosition = #whitelist end

		if not oldPosition then
			local row = db:fetch(database, db:AND(db:eq(database.area, area), db:eq(database.name, entry)))[1]
			if row then
				oldPosition = row.pos
			else
				echo("That entry does not exist in the whitelist.\n")
				send(" ")
				return
			end
		end

		if not entry then
			local row = db:fetch(database, db:AND(db:eq(database.area, area), db:eq(database.pos, oldPosition)))[1]
			if row then
				entry = pos.name
			else
				echo("That position does not exist in the whitelist.\n")
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

		table.remove(system.hunting.defs.mobWhitelist[area], oldPosition)
		table.insert(system.hunting.defs.mobWhitelist[area], newPosition, entry)	

		system.hunting.funcs.displayWhitelist(area)
	end

system.hunting.funcs.whitelistAreas =
	function()
		local areas = {}
		local database = system.hunting.db.whitelist
		local rows = db:fetch(database, nil, {database.area})
		local found = {}

		for i, row in ipairs(rows) do
			if not found[row.area] then
				table.insert(areas, row.area)
				found[row.area] = true
			end
		end

		if #areas < 1 then
			echo("You have no whitelists.\n")
		else
			echo("You have whitelists for the following areas:\n")

			for i, area in ipairs(areas) do
				cechoLink("<grey>" .. area .. "\n", [[system.hunting.funcs.displayWhitelist("]] .. area .. [[")]], "Show the whitelist for " .. area, true)
			end	
		end

		send(" ")
	end

system.hunting.funcs.chooseWhitelistArea =
	function(areas)
		echo("Your area was unrecognized. Did you mean one of the below areas?\n")
		for _, area in pairs(areas) do
			cechoLink("<grey>" .. area .. "\n", [[system.hunting.funcs.displayWhitelist("]] .. area .. [[")]], "Show the whitelist for " .. area, true)
		end
		send(" ")
	end

system.hunting.funcs.displayWhitelist = 
	function(area)
		if not area then
			if gmcp then
				area = gmcp.Room.Info.area
			else
				echo("No area specified to display whitelist for.\n")
				return
			end
		end

		local whitelist = system.hunting.defs.mobWhitelist[area]

		local fromDatabase = true
		if fromDatabase then
			whitelist = {}

			local database = system.hunting.db.whitelist
			local dbWhite = db:fetch(database, db:eq(database.area, area), {database.pos})
			
			if dbWhite then
				for i, v in ipairs(dbWhite) do
					table.insert(whitelist, v.name)
				end 
			end
		end

		if not whitelist or #whitelist < 1 then
			if global then
				echo("No denizens are in the global whitelist.\n")
			else
				echo("No whitelist for this area (" .. area .. ").\n")
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

			cecho("<"..border..">+-<"..header..">Denizen whitelist for: " .. area .. "<" .. border ..">" .. string.rep("-", maxLength - length - 1) .. "+\n")

			for i, mob in ipairs(whitelist) do
				local ignored = false
				if system.hunting.vars.ignoredWhitelist[area] and system.hunting.vars.ignoredWhitelist[area][mob] then
					mobColor = off_value
					ignored = true
				else
					mobColor = "white"
				end
			
				cecho("<"..border..">|   ")
				cechoLink("<"..option..">Up", [[system.hunting.funcs.shiftWhitelist("]] .. area .. [[","]] .. mob .. [[", "up")]] , "Move " .. mob .. " higher on the priority order.", true)
				cecho("  ")
				cechoLink("<"..option..">Down", [[system.hunting.funcs.shiftWhitelist("]] .. area .. [[","]] .. mob .. [[", "down")]], "Move " .. mob .. " lower on the priority order.", true)
				cecho("  ")
				cechoLink("<"..option..">Remove", [[system.hunting.funcs.removeWhitelist("]] .. area .. [[","]] .. mob .. [[", ]] .. tostring(i) .. [[)]], "Remove " .. mob .. " from the whitelist.", true)
				cecho("  <"..mobColor..">" .. i .. "." .. string.rep(" ", string.len(tostring(#whitelist)) + 1 - string.len(tostring(i))))
				if ignored then
					cechoLink("<"..mobColor..">"..mob, [[system.hunting.funcs.ignoreWhitelist("]] .. area .. [[","]] .. mob .. [[", false)]], "Unignore " .. mob .. ".", true)
				else
					cechoLink("<"..mobColor..">"..mob, [[system.hunting.funcs.ignoreWhitelist("]] .. area .. [[","]] .. mob .. [[", true)]], "Ignore " .. mob .. ".", true)
				end
				cecho(string.rep(" ", maxLength - 26 - string.len(mob) - string.len(tostring(#whitelist))) .. "<"..border..">|\n")
			end
			cecho("<"..border..">+" .. string.rep("-", maxLength - 3) .. "+\n")
		end
		send(" ")
	end