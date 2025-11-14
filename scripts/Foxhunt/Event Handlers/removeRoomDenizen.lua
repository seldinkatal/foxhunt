--Events:
--gmcp.Char.Items.Remove

function removeRoomDenizen()
	if gmcp.Char.Items.Remove.location == "room" then
		local item = gmcp.Char.Items.Remove.item

		if item.name == "some gold sovereigns" then
			system.hunting.vars.goldDropped = false
		end

		if item.name:find("jagged crimson shard")
			or item.name:find("chipped tangerine shard")
			or item.name:find("smooth sable shard")
		then
			system.hunting.vars.shardsDropped = false
		end

		if item.attrib ~= nil 
			and item.attrib:find("m") 
		then
			local index = -1
			for i,v in ipairs(system.hunting.vars.denizens) do
				if v.id == item.id then
					index = i
					break
				end
			end

			if index > 0 then
--			system.hunting.vars.denizens[item.id] = nil
				table.remove(system.hunting.vars.denizens, index)
			end
		end
	end
end