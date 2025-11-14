--Events:
--gmcp.Room.Info

function roomInfo()
	local vars = system.hunting.vars

	if vars.room ~= gmcp.Room.Info.num then
		system.hunting.vars.movedRooms = true
		system.hunting.vars.newPeopleInRoom = false
		system.hunting.vars.attackedRoom = false

		system.hunting.vars.lastRoom = vars.room

		if not vars.fleeing then
			if gmcp.Room.Info.exits then
				for dir, id in pairs(gmcp.Room.Info.exits) do
					if tonumber(id) == tonumber(vars.room) then
						system.hunting.vars.lastRoomDir = dir
					end
				end
			end
		else
			system.hunting.vars.lastRoomDir = ""
			killTimer(system.hunting.vars.fleeing)
			system.hunting.vars.fleeing = false
		end
	else
		system.hunting.vars.movedRooms = false
	end

	system.hunting.vars.room = gmcp.Room.Info.num
end