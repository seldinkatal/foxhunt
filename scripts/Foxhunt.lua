system = system or {}
system.hunting = system.hunting or {}

system.hunting.db = db:create("hunting", {
	hconfig = {
		name = "",
		value = "",
		_unique = { "name" },
		_violations = "IGNORE"
	},

	profile = {
		name = "",
		attackMode = 1,
		battlerageMode = 1,
		_unique = { "name" },
		_index = { "name" }
	},

	whitelist = {
		area = "",
		pos = 0,
		name = "",
		ignore = 0,
		_index  = { "area" },
	},

	blacklist = {
		area = "",
		pos = 0,
		name = "",
		ignore = 0,
		_index  = { "area" },
	}
})
system.hunting.db = db:get_database("hunting")
