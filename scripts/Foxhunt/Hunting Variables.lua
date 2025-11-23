system.hunting.vars = system.hunting.vars or {
	["customGold"] = {
		"put sovereigns in pack"
	},

	["hunting"] = false,
	["targetEnabled"] = false,

	["ignoredWhitelist"] = {},
	["ignoredBlacklist"] = {},

	-- HConfig settings begin
	["targetingMode"] = "whitelist",
	["attackingMode"] = "room",
	["whitelistPriorityOrder"] = true,
	["attackMode"]  = "dam",
	["battlerageMode"] = "dam",
	["ignoreOtherPlayers"] = false,
	["useQueueing"] = false,
	["targetOrder"] = "order",
	["targetCall"] = false,
	["autoGrabGold"] = true,
	["autoGrabShards"] = true,
	["showPrompt"] = false,
	["separator"] = "||",
	-- HConfig settings end

	["huntingAlias"] = "",

	["attacking"] = false,

	["currentTargetId"] = "",
	["targetName"]	= "",
	["targetShield"] = false,
	["mobAffs"] = {},

	["limiters"] = {
		["hunting"] = false,
		["battlerage"] = false,
		["targeting"] = false,
		["setting"] = false,
	},

	["denizens"] = {},
	["players"] = {},

	["room"] = "",
	["lastRoom"] = "",
	["lastRoomDir"] = "",
	["attackedRoom"] = false,
	["movedRooms"] = false,
	["newPeopleInRoom"] = false,
	
	["fleeing"] = false,

	["blackout"] = false,
	["attackQueued"] = false,

	["brBalTimers"] = {},
	["brBal"] = 
		{
			["br"] = true,
			["brTimer"] = "",
		}
}