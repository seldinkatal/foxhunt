function system.hunting.funcs.findSynergy(class, class2)
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	if not defs.classRage[class] or not defs.classRage[class2] then
		return 0
	end

	local needAffs1 = {}
	if defs.classRage[class]["synergy"] then
		table.insert(needAffs1, defs.classRage[class]["synergy"]["aff1"])
		table.insert(needAffs1, defs.classRage[class]["synergy"]["aff2"])
	end

	local needAffs2 = {}
	if defs.classRage[class2]["synergy"] then
		table.insert(needAffs2, defs.classRage[class2]["synergy"]["aff1"])
		table.insert(needAffs2, defs.classRage[class2]["synergy"]["aff2"])
	end

	local giveAffs1 = {}
	if defs.classRage[class]["aff1"] then
		table.insert(giveAffs1, defs.classRage[class]["aff1"]["aff"])
	end
	if defs.classRage[class]["aff2"] then
		table.insert(giveAffs1, defs.classRage[class]["aff2"]["aff"])
	end

	local giveAffs2 = {}
	if defs.classRage[class2]["aff1"] then
		table.insert(giveAffs2, defs.classRage[class2]["aff1"]["aff"])
	end
	if defs.classRage[class2]["aff2"] then
		table.insert(giveAffs2, defs.classRage[class2]["aff2"]["aff"])
	end

	local synergy = 0
	if not table.is_empty(table.n_intersection(needAffs1, giveAffs2)) then
		synergy = synergy + 1
	end

	if not table.is_empty(table.n_intersection(needAffs2, giveAffs1)) then
		synergy = synergy + 1
	end

	return synergy
end

function system.hunting.funcs.displaySynergy(class, class2)
	local defs = system.hunting.defs
	local vars = system.hunting.vars
	local funcs = system.hunting.funcs

	local myClass = string.lower(funcs.getClass())
	local classList = {}
	for k,_ in pairs(defs.classRage) do
		table.insert(classList, k)
	end

	local partSynergyList = {}
	local fullSynergyList = {}

	local partSynergyColor = "yellow"
	local fullSynergyColor = "green"

	if not class and not class2 then
		for _,v in ipairs(classList) do
			local synergy = funcs.findSynergy(myClass, v)
			if synergy == 1 then
				table.insert(partSynergyList, "<" .. partSynergyColor .. ">" .. v)
			elseif synergy == 2 then
				table.insert(fullSynergyList, "<" .. fullSynergyColor .. ">" .. v)
			end
		end

		table.sort(partSynergyList)
		table.sort(fullSynergyList)

		partSynergyList = table.concat(partSynergyList, "<grey>, ")
		fullSynergyList = table.concat(fullSynergyList, "<grey>, ")

		cecho("Your class is: <green>" .. myClass .. "\n")
		cecho("You have one-way synergy with the following classes: " .. partSynergyList .. "\n")
		cecho("You have two-way synergy with the following classes: " .. fullSynergyList .. "\n")
	elseif class and not class2 then
		local synergyString = "<red>no synergy"
		local synergy = funcs.findSynergy(myClass, class)

		if synergy == 1 then
			synergyString = "<yellow>one-way synergy"
		elseif synergy == 2 then
			synergyString = "<green>two-way synergy"
		end

		cecho("Your class, <green>" .. myClass .. "<grey>, has " .. synergyString .. " <grey>with <green>" .. class .. "<grey>.\n")

		for _,v in ipairs(classList) do
			local synergy = funcs.findSynergy(class, v)
			if synergy == 1 then
				table.insert(partSynergyList, "<" .. partSynergyColor .. ">" .. v)
			elseif synergy == 2 then
				table.insert(fullSynergyList, "<" .. fullSynergyColor .. ">" .. v)
			end
		end

		table.sort(partSynergyList)
		table.sort(fullSynergyList)

		partSynergyList = table.concat(partSynergyList, "<grey>, ")
		fullSynergyList = table.concat(fullSynergyList, "<grey>, ")

		cecho("It has one-way synergy with the following classes: " .. partSynergyList .. "\n")
		cecho("It has two-way synergy with the following classes: " .. fullSynergyList .. "\n")
	elseif class and class2 then
		local synergyString = "<red>no synergy"
		local synergy = funcs.findSynergy(class, class2)

		if synergy == 1 then
			synergyString = "<yellow>one-way synergy"
		elseif synergy == 2 then
			synergyString = "<green>two-way synergy"
		end

		cecho("The class <green>" .. class .. "<grey> has " .. synergyString .. " <grey>with <green>" .. class2 .. "<grey>.")
	end
	send(" ")
end