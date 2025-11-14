--Events:
--gmcp.Char.Items.Add

function addRoomDenizen()
	if gmcp.Char.Items.Add.location == "room" then
		local item = gmcp.Char.Items.Add.item

		if item.name == "some gold sovereigns" then
			system.hunting.vars.goldDropped = true
		end

		if item.name:find("jagged crimson shard")
			or item.name:find("chipped tangerine shard")
			or item.name:find("smooth sable shard")
		then
			system.hunting.vars.shardsDropped = true
		end

		if item.attrib ~= nil 
			and item.attrib:find("m") 
			and not item.attrib:find("d") 
			and not item.attrib:find("x")
		then
--			system.hunting.vars.denizens[item.id] = item
			table.insert(system.hunting.vars.denizens, item)
		end
	end
end