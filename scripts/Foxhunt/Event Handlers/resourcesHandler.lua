function resourcesHandler()
	if system and system.hunting and system.hunting.vars then
		system.hunting.vars.resources = {}
		for _, str in pairs(gmcp.Char.Vitals.charstats) do
			local key, value = unpack(string.split(str, ": "))
			value = tonumber(value) or value
			system.hunting.vars.resources[key:lower()] = value
		end
	end
end

registerAnonymousEventHandler("gmcp.Char.Vitals", "resourcesHandler")