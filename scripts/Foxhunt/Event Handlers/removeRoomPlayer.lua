--Events:
--gmcp.Room.RemovePlayer

function removeRoomPlayer()
	if gmcp.Room.RemovePlayer ~= gmcp.Char.Status.name then
		system.hunting.vars.players[gmcp.Room.RemovePlayer] = nil
	end
end