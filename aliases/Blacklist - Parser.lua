--^(?i)\s*blacklist(.*)$

local invalid = true

if matches[2] and matches[2] ~= "" and matches[2]:starts(" ") then
	local args = matches[2]:trim():lower():split("%s+")
	local raw = matches[2]:trim():split("%s+")

	if args[1] == "show" then
		invalid = false

		if args[2] then
			local area = table.concat(raw, " ", 2)
			local areas = system.hunting.funcs.resolveArea(area)
	
			if #areas == 1 then
				system.hunting.funcs.displayBlacklist(areas[1])
			elseif #areas == 0 then
				system.hunting.funcs.displayBlacklist(area)
			else
				system.hunting.funcs.chooseBlacklistArea(areas)
			end
		else
			system.hunting.funcs.displayBlacklist()
		end
	elseif args[1] == "add" then
		local startIndex = 2
		local endIndex = 2
		local position = nil
		local hasArea = false
		local hasPosition = false
		local area = nil
		local posIndex = nil
		local inIndex = nil
		invalid = false

		if #args < 2 then
			invalid = true
		end

		for i, arg in ipairs(args) do
			endIndex = i
			if tonumber(arg) then
				position = tonumber(arg)
				posIndex = endIndex
				endIndex = endIndex - 1
				hasPosition = true
				break
			elseif arg:trim() == "in" then
				inIndex = endIndex
				endIndex = endIndex - 1
				hasArea = true
				break
			end
		end

		local mob = table.concat(raw, " ", startIndex, endIndex)
		
		if hasPosition and args[posIndex + 1] then
			if args[posIndex + 1] == "in" then
				hasArea = true
				inIndex = posIndex + 1
			end
		end

		if hasArea and not args[inIndex + 1] then
			invalid = true
		elseif hasArea then
			 area = table.concat(raw, " ", inIndex + 1)
		end

		if not invalid then
			if area then
				local areas = system.hunting.funcs.resolveArea(area)
	
				if #areas == 1 then
					area = areas[1]
				end
			end

			system.hunting.funcs.addBlacklist(area, mob, position)
		end
	elseif args[1] == "remove" then
		local startIndex = 2
		local endIndex = 2
		local position = nil
		local hasArea = false
		local hasPosition = false
		local area = nil
		local posIndex = nil
		local inIndex = nil
		invalid = false

		if #args < 2 then
			invalid = true
		end

		for i, arg in ipairs(args) do
			endIndex = i
			if tonumber(arg) then
				position = tonumber(arg)
				posIndex = endIndex
				endIndex = endIndex - 1
				hasPosition = true
				break
			elseif arg:trim() == "in" then
				inIndex = endIndex
				endIndex = endIndex - 1
				hasArea = true
				break
			end
		end

		local mob = table.concat(raw, " ", startIndex, endIndex)
		
		if hasPosition and args[posIndex + 1] then
			if args[posIndex + 1] == "in" then
				hasArea = true
				inIndex = posIndex + 1
			end
		end

		if hasArea and not args[inIndex + 1] then
			invalid = true
		elseif hasArea then
			 area = table.concat(raw, " ", inIndex + 1)
		end

		if not invalid then
			if area then
				local areas = system.hunting.funcs.resolveArea(area)
	
				if #areas == 1 then
					area = areas[1]
				end
			end

			system.hunting.funcs.removeBlacklist(area, mob, position)
		end
	elseif args[1] == "shift" then
		local startIndex = 2
		local endIndex = 2
		local position = nil
		local hasArea = false
		local area = nil
		local direction = nil
		invalid = false

		if #args < 2 then
			invalid = true
		end

		for i, arg in ipairs(args) do
			endIndex = i
			if arg == "up" or arg == "down" then
				direction = arg
				endIndex = endIndex - 1
				break
			end
		end

		if not direction then
			invalid = true
		end

		local mob = table.concat(raw, " ", startIndex, endIndex)

		if not args[endIndex + 2] or not tonumber(args[endIndex + 2]) then
			invalid = true
		else
			position = args[endIndex + 2]
		end

		if args[endIndex + 3] and args[endIndex + 3] == "in" then
			hasArea = true
			inIndex = endIndex + 3
		end

		if hasArea and not args[inIndex + 1] then
			invalid = true
		elseif hasArea then
			area = table.concat(raw, " ", inIndex + 1)
		end

		if not invalid then
			if area then
				local areas = system.hunting.funcs.resolveArea(area)
	
				if #areas == 1 then
					area = areas[1]
				end
			end

			system.hunting.funcs.shiftBlacklist(area, mob, direction, position)
		end
	elseif args[1] == "move" then
		local startIndex = 2
		local endIndex = 2
		local position = nil
		local hasArea = false
		local area = nil
		local direction = nil
		invalid = false

		if #args < 2 then
			invalid = true
		end

		for i, arg in ipairs(args) do
			endIndex = i
			if arg == "to" then
				endIndex = endIndex - 1
				break
			end
		end

		local mob = table.concat(raw, " ", startIndex, endIndex)

		if not args[endIndex + 2] or not tonumber(args[endIndex + 2]) then
			invalid = true
		else
			position = tonumber(args[endIndex + 2])
		end

		if args[endIndex + 3] and args[endIndex + 3] == "in" then
			hasArea = true
			inIndex = endIndex + 3
		end

		if hasArea and not args[inIndex + 1] then
			invalid = true
		elseif hasArea then
			area = table.concat(raw, " ", inIndex + 1)
		end

		if not invalid then
			if area then
				local areas = system.hunting.funcs.resolveArea(area)
	
				if #areas == 1 then
					area = areas[1]
				end
			end

			system.hunting.funcs.moveBlacklist(area, mob, nil, position)
		end
	elseif args[1] == "areas" then
		invalid = false
		system.hunting.funcs.blacklistAreas()
	end
end

if invalid then
	echo("Syntax:\n")
	echo("BLACKLIST SHOW [area|GLOBAL]\n")
	echo("BLACKLIST ADD <denizen> [position] [IN <area|GLOBAL>]\n")
	echo("BLACKLIST REMOVE <denizen> [position] [IN <area|GLOBAL>]\n")
	echo("BLACKLIST SHIFT <denizen> UP|DOWN <amount> [IN <area|GLOBAL>]\n")
	echo("BLACKLIST MOVE <denizen> TO <position> [IN <area|GLOBAL>}\n")
	echo("BLACKLIST AREAS\n")
	send(" ")
end