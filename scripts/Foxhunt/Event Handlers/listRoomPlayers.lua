--Event:
--gmcp.Room.Players

function listRoomPlayers()
	local vars = system.hunting.vars
	local newPlayers = {}

	for _,player in ipairs(gmcp.Room.Players) do
		if player.name ~= gmcp.Char.Status.name then
			newPlayers[player.name] = true

			if vars.movedRooms and not vars.players[player.name] then
				system.hunting.vars.newPeopleInRoom = true
			end
		end
	end

	system.hunting.vars.movedRooms = false
	system.hunting.vars.players = newPlayers
end