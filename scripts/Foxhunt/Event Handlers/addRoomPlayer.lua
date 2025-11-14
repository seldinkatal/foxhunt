--Events:
--gmcp.Room.AddPlayer

function addRoomPlayer()
	if gmcp.Room.AddPlayer.name ~= gmcp.Char.Status.name then
		system.hunting.vars.players[gmcp.Room.AddPlayer.name] = true
	end
end