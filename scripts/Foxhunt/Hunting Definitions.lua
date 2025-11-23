local mobWhitelist = {}
local mobBlacklist = {}
local attackStrategems = {}
local battlerageStrategems = {}

if system.hunting.defs then
	mobWhitelist = system.hunting.defs.mobWhitelist or {}
	mobBlacklist = system.hunting.defs.mobBlacklist or {}
	attackStrategems = system.hunting.defs.attackStrategems or {}
	battlerageStrategems = system.hunting.defs.battlerageStrategems or {}
end

system.hunting.defs = {
	["version"] = "1.5.1",

	["afflictionDuration"] = {
		["sensitivity"] = 8.5,
		["amnesia"] = 10.5,
		["recklessness"] = 14.5,
		["weakness"] = 6.5,
		["fear"] = 8.5,
		["aeon"] = 6.5,
		["clumsiness"] = 7.5,
		["inhibit"] = 9.5,
		["charm"] = 5.5,
		["stun"] = 4.5
	},

	["classRage"] = {
		["air elemental"] = {
			light = {
				name = "bolt",
				com = "manifest bolt &tar"
			},
			heavy = {
				name = "pressurewave",
				com = "manifest pressurewave &tar"
			},
			raze = {
				name = "drill",
				com = "manifest drill &tar"
			},
			synergy = {
				name = "compress",
				aff1 = "sensitivity",
				aff2 = "stun",
				com = "aero compress &tar"
			},
			aff1 = {
				name = "suffocate",
				aff = "weakness",
				com = "aero suffocate &tar"
			},
			aff2 = {
				name = "vacuum",
				aff = "inhibit",
				com = "manifest vacuum &tar"
			}
		},
		["alchemist"] = {
			light = {
				name = "miasma",
				com = "throw miasma at &tar"
			},
			heavy = {
				name = "magnesium",
				com = "educe magnesium &tar"
			},
			raze = {
				name = "caustic",
				com = "throw caustic at &tar"
			},
			synergy = {
				name = "pathogen",
				aff1 = "inhibit",
				aff2 = "fear",
				com = "throw pathogen at &tar"
			},
			aff1 = {
				name = "cadmium",
				aff = "weakness",
				com = "educe cadmium &tar"
			},
			aff2 = {
				name = "hypnotic",
				aff = "amnesia",
				com = "throw hypnotic at &tar"
			}
		},
		["apostate"] = {
			light = {
				name = "convulsions",
				com = "stare &tar convulsions"
			},
			heavy = {
				name = "burrow",
				com = "daegger burrow &tar"
			},
			raze = {
				name = "pierce",
				com = "daegger pierce &tar"
			},
			synergy = {
				name = "bloodlet",
				aff1 = "sensitivity",
				aff2 = "stun",
				com = "bloodlet &tar"
			},
			aff1 = {
				name = "horrify",
				aff = "fear",
				com = "stare &tar horrify"
			},
			aff2 = {
				name = "possess",
				aff = "charm",
				com = "possess &tar"
			}
		},
		["bard"] = {
			light = {
				name = "moulinet",
				com = "moulinet &tar"
			},
			heavy = {
				name = "howlslash",
				com = "howlslash &tar"
			},
			raze = {
				name = "resonance",
				com = "play resonance at &tar"
			},
			synergy = {
				name = "cyclone",
				aff1 = "stun",
				aff2 = "clumsiness",
				com = "cyclone &tar"
			},
			aff1 = {
				name = "trill",
				aff = "amnesia",
				com = "play trill at &tar"
			},
			aff2 = {
				name = "charm",
				aff = "charm",
				com = "play charm at &tar"
			}
		},
		["black dragon"] = {
			light = {
				name = "dragonspit",
				com = "dragonspit &tar"
			},
			heavy = {
				name = "override",
				com = "override &tar"
			},
			raze = {
				name = "dissolve",
				com = "dissolve &tar"
			},
			synergy = {
				name = "corrode",
				aff1 = "clumsiness",
				aff2 = "aeon",
				com = "corrode &tar"
			},
			aff1 = {
				name = "dragonsting",
				aff = "sensitivity",
				com = "dragonsting &tar"
			},
			aff2 = {
				name = "dragonfear",
				aff = "fear",
				com = "dragonfear &tar"
			}
		},
		["blademaster"] = {
			light = {
				name = "leapstrike",
				com = "leapstrike &tar"
			},
			heavy = {
				name = "spinslash",
				com = "spinslash &tar"
			},
			raze = {
				name = "shatter",
				com = "shin shatter &tar"
			},
			synergy = {
				name = "headstrike",
				aff1 = "recklessness",
				aff2 = "fear",
				com = "strike &tar head"
			},
			aff1 = {
				name = "daze",
				aff = "stun",
				com = "shin daze &tar"
			},
			aff2 = {
				name = "nerveslash",
				aff = "weakness",
				com = "nsl &tar"
			}
		},
		["blue dragon"] = {
			light = {
				name = "dragonchill",
				com = "dragonchill &tar"
			},
			heavy = {
				name = "override",
				com = "override &tar"
			},
			raze = {
				name = "frostrive",
				com = "frostrive &tar"
			},
			synergy = {
				name = "frostwave",
				aff1 = "amnesia",
				aff2 = "recklessness",
				com = "frostwave &tar"
			},
			aff1 = {
				name = "glaciate",
				aff = "stun",
				com = "glaciate &tar"
			},
			aff2 = {
				name = "ague",
				aff = "clumsiness",
				com = "ague &tar"
			}
		},
		["depthswalker"] = {
			light = {
				name = "drain",
				com = "shadow drain &tar"
			},
			heavy = {
				name = "lash",
				com = "shadow lash &tar"
			},
			raze = {
				name = "nakail",
				com = "intone nakail &tar"
			},
			synergy = {
				name = "erasure",
				aff1 = "weakness",
				aff2 = "amnesia",
				com = "chrono erasure &tar"
			},
			aff1 = {
				name = "curse",
				aff = "aeon",
				com = "chrono curse &tar"
			},
			aff2 = {
				name = "boinad",
				aff = "charm",
				com = "intone boinad &tar"
			}
		},
		["druid"] = {
			light = {
				name = "strangle",
				com = "strangle &tar"
			},
			heavy = {
				name = "ravage",
				com = "ravage &tar"
			},
			raze = {
				name = "vinecrack",
				com = "vinecrack &tar"
			},
			synergy = {
				name = "sear",
				aff1 = "recklessness",
				aff2 = "stun",
				com = "sear &tar"
			},
			aff1 = {
				name = "redeem",
				aff = "weakness",
				com = "reclamation redeem &tar"
			},
			aff2 = {
				name = "glare",
				aff = "clumsiness",
				com = "qstaff glare &tar"
			}
		},
		["earth elemental"] = {
			light = {
				name = "smash",
				com = "terran smash &tar"
			},
			heavy = {
				name = "flurry",
				com = "terran flurry &tar"
			},
			raze = {
				name = "charge",
				com = "terran charge &tar"
			},
			synergy = {
				name = "magmaburst",
				aff1 = "clumsiness",
				aff2 = "recklessness",
				com = "manifest magmaburst &tar"
			},
			aff1 = {
				name = "rockfall",
				aff = "stun",
				com = "manifest rockfall &tar"
			},
			special = {
				name = "rampart",
				com = "terran rampart &tar"
			}
		},
		["fire elemental"] = {
			light = {
				name = "engulf",
				com = "manifest engulf &tar"
			},
			heavy = {
				name = "devastation",
				com = "manifest devastation &tar"
			},
			raze = {
				name = "wires",
				com = "manifest wires &tar"
			},
			synergy = {
				name = "cataclysm",
				aff1 = "stun",
				aff2 = "recklessness",
				com = "manifest cataclysm &tar"
			},
			aff1 = {
				name = "scourge",
				aff = "sensitivity",
				com = "manifest scourge &tar"
			},
			special = {
				name = "searingbonds",
				com = "manifest bonds &tar"
			}
		},
		["golden dragon"] = {
			light = {
				name = "overwhelm",
				com = "overwhelm &tar"
			},
			heavy = {
				name = "psiblast",
				com = "psiblast &tar"
			},
			raze = {
				name = "psishatter",
				com = "psishatter &tar"
			},
			synergy = {
				name = "psistorm",
				aff1 = "weakness",
				aff2 = "stun",
				com = "psistorm &tar"
			},
			aff1 = {
				name = "deaden",
				aff = "aeon",
				com = "deaden &tar"
			},
			aff2 = {
				name = "psidaze",
				aff = "amnesia",
				com = "psidaze &tar"
			}
		},
		["green dragon"] = {
			light = {
				name = "dragonspit",
				com = "dragonspit &tar"
			},
			heavy = {
				name = "override",
				com = "override &tar"
			},
			raze = {
				name = "deteriorate",
				com = "deteriorate &tar"
			},
			synergy = {
				name = "slaver",
				aff1 = "sensitivity",
				aff2 = "clumsiness",
				com = "slaver &tar"
			},
			aff1 = {
				name = "scour",
				aff = "inhibit",
				com = "scour &tar"
			},
			aff2 = {
				name = "dragonsap",
				aff = "weakness",
				com = "dragonsap &tar"
			}
		},
		["infernal"] = {
			light = {
				name = "ravage",
				com = "ravage &tar"
			},
			heavy = {
				name = "spike",
				com = "spike &tar"
			},
			raze = {
				name = "shiver",
				com = "shiver &tar"
			},
			synergy = {
				name = "hellstrike",
				aff1 = "fear",
				aff2 = "recklessness",
				com = "hellstrike &tar"
			},
			special = {
				name = "soulshield",
				com = "soulshield"
			},
			special2 = {
				name = "deathlink",
				com = "deathlink &tar"
			}
		},
		["jester"] = {
			light = {
				name = "noogie",
				com = "noogie &tar"
			},
			heavy = {
				name = "ensconce",
				com = "ensconce firecracker on &tar"
			},
			raze = {
				name = "jacks",
				com = "throw jacks at &tar"
			},
			synergy = {
				name = "befuddle",
				aff1 = "amnesia",
				aff2 = "aeon",
				com = "befuddle &tar"
			},
			aff1 = {
				name = "dustthrow",
				aff = "inhibit",
				com = "dustthrow &tar"
			},
			aff2 = {
				name = "rap",
				aff = "stun",
				com = "rap &tar"
			}
		},
		["magi"] = {
			light = {
				name = "windlash",
				com = "cast windlash at &tar"
			},
			heavy = {
				name = "squeeze",
				com = "cast squeeze &tar"
			},
			raze = {
				name = "disintegrate",
				com = "cast disintegrate at &tar"
			},
			synergy = {
				name = "firefall",
				aff1 = "recklessness",
				aff2 = "clumsiness",
				com = "cast firefall at &tar"
			},
			aff1 = {
				name = "dilation",
				aff = "aeon",
				com = "cast dilation at &tar"
			},
			aff2 = {
				name = "stormbolt",
				aff = "sensitivity",
				com = "cast stormbolt at &tar"
			}
		},
		["monk"] = {
			light = {
				name = "spinningbackfist",
				com = "sbp &tar"
			},
			heavy = {
				name = "tornadokick",
				com = "tnk &tar"
			},
			raze = {
				name = "splinterkick",
				com = "spk &tar"
			},
			synergy = {
				name = "mindblast",
				aff1 = "weakness",
				aff2 = "sensitivity",
				com = "mind blast &tar"
			},
			aff1 = {
				name = "scramble",
				aff = "clumsiness",
				com = "mind scramble &tar"
			},
			aff2 = {
				name = "ripplestrike",
				aff = "inhibit",
				com = "rpst &tar"
			}
		},
		["occultist"] = {
			light = {
				name = "harry",
				com = "harry &tar"
			},
			heavy = {
				name = "chaosgate",
				com = "chaosgate &tar"
			},
			raze = {
				name = "ruin",
				com = "ruin &tar"
			},
			synergy = {
				name = "fluctuate",
				aff1 = "fear",
				aff2 = "amnesia",
				com = "fluctuate &tar"
			},
			aff1 = {
				name = "temperance",
				aff = "charm",
				com = "temper &tar"
			},
			aff2 = {
				name = "stagnate",
				aff = "aeon",
				com = "stagnate &tar"
			}
		},
		["paladin"] = {
			light = {
				name = "harrow",
				com = "harrow &tar"
			},
			heavy = {
				name = "shock",
				com = "perform rite of shock at &tar"
			},
			raze = {
				name = "faithrend",
				com = "faithrend &tar"
			},
			synergy = {
				name = "punishment",
				aff1 = "weakness",
				aff2 = "clumsiness",
				com = "perform rite of punishment at &tar"
			},
			special = {
				name = "regeneration",
				com = "perform rite of regeneration"
			},
			special2 = {
				name = "recovery",
				com = "perform recovery &tar"
			}
		},
		["pariah"] = {
			light = {
				name = "boil",
				com = "blood boil &tar"
			},
			heavy = {
				name = "feast",
				com = "swarm feast &tar"
			},
			raze = {
				name = "ascour",
				com = "accursed scour &tar"
			},
			synergy = {
				name = "spider",
				aff1 = "inhibit",
				aff2 = "sensitivity",
				com = "trace spider &tar"
			},
			aff1 = {
				name = "wail",
				aff = "fear",
				com = "accursed wail"
			},
			aff2 = {
				name = "symphony",
				aff = "clumsiness",
				com = "swarm symphony &tar"
			}
		},
		["priest"] = {
			light = {
				name = "torment",
				com = "angel torment &tar"
			},
			heavy = {
				name = "desolation",
				com = "perform rite of desolation on &tar"
			},
			raze = {
				name = "crack",
				com = "crack &tar"
			},
			synergy = {
				name = "hammer",
				aff1 = "clumsiness",
				aff2 = "amnesia",
				com = "hammer &tar"
			},
			aff1 = {
				name = "incense",
				aff = "recklessness",
				com = "angel incense &tar"
			},
			aff2 = {
				name = "horrify",
				aff = "fear",
				com = "perform rite of horrify on &tar"
			}
		},
		["psion"] = {
			light = {
				name = "barbedblade",
				com = "weave barbedblade &tar"
			},
			heavy = {
				name = "devastate",
				com = "psi devastate &tar"
			},
			raze = {
				name = "pulverise",
				com = "weave pulverise &tar"
			},
			synergy = {
				name = "whirlwind",
				aff1 = "inhibit",
				aff2 = "stun",
				com = "weave whirlwind &tar"
			},
			aff1 = {
				name = "regrowth",
				aff = "inhibit",
				com = "enact regrowth &tar"
			},
			aff2 = {
				name = "terror",
				aff = "fear",
				com = "psi terror &tar"
			}
		},
		["red dragon"] = {
			light = {
				name = "overwhelm",
				com = "overwhelm &tar"
			},
			heavy = {
				name = "dragonblaze",
				com = "dragonblaze &tar"
			},
			raze = {
				name = "melt",
				com = "melt &tar"
			},
			synergy = {
				name = "flamebath",
				aff1 = "sensitivity",
				aff2 = "clumsiness",
				com = "flamebath &tar"
			},
			aff1 = {
				name = "dragontaunt",
				aff = "recklessness",
				com = "dragontaunt &tar"
			},
			aff2 = {
				name = "scorch",
				aff = "inhibit",
				com = "scorch &tar"
			}
		},
		["runewarden"] = {
			light = {
				name = "collide",
				com = "collide &tar"
			},
			heavy = {
				name = "onslaught",
				com = "onslaught &tar"
			},
			raze = {
				name = "fragment",
				com = "fragment &tar"
			},
			synergy = {
				name = "etch",
				aff1 = "aeon",
				aff2 = "stun",
				com = "etch rune at &tar"
			},
			special = {
				name = "bulwark",
				com = "bulwark"
			},
			special2 = {
				name = "safeguard",
				com = "safeguard &tar"
			}
		},
		["sentinel"] = {
			light = {
				name = "pester",
				com = "pester &tar"
			},
			heavy = {
				name = "skewer",
				com = "skewer &tar"
			},
			raze = {
				name = "bore",
				com = "bore &tar"
			},
			synergy = {
				name = "swarm",
				aff1 = "aeon",
				aff2 = "inhibit",
				com = "swarm &tar"
			},
			aff1 = {
				name = "tame",
				aff = "charm",
				com = "charm &tar"
			},
			aff2 = {
				name = "goad",
				aff = "recklessness",
				com = "goad &tar"
			}
		},
		["serpent"] = {
			light = {
				name = "thrash",
				com = "thrash &tar"
			},
			heavy = {
				name = "throatrip",
				com = "throatrip &tar"
			},
			raze = {
				name = "excoriate",
				com = "excoriate &tar"
			},
			synergy = {
				name = "snare",
				aff1 = "recklessness",
				aff2 = "inhibit",
				com = "snare &tar"
			},
			aff1 = {
				name = "flagellate",
				aff = "sensitivity",
				com = "flagellate &tar"
			},
			aff2 = {
				name = "obliviate",
				aff = "amnesia",
				com = "obliviate &tar"
			}
		},
		["shaman"] = {
			light = {
				name = "corruption",
				com = "curse &tar corruption"
			},
			heavy = {
				name = "haemorrhage",
				com = "curse &tar haemorrhage"
			},
			raze = {
				name = "vulnerability",
				com = "curse &tar vulnerability"
			},
			synergy = {
				name = "vurus",
				aff1 = "sensitivity",
				aff2 = "amnesia",
				com = "invoke vurus &tar"
			},
			aff1 = {
				name = "korkma",
				aff = "fear",
				com = "invoke korkma &tar"
			},
			aff2 = {
				name = "cesaret",
				aff = "recklessness",
				com = "invoke cesaret &tar"
			}
		},
		["silver dragon"] = {
			light = {
				name = "overwhelm",
				com = "overwhelm &tar"
			},
			heavy = {
				name = "dragonspark",
				com = "dragonspark &tar"
			},
			raze = {
				name = "splinter",
				com = "splinter &tar"
			},
			synergy = {
				name = "stormflare",
				aff1 = "amnesia",
				aff2 = "fear",
				com = "stormflare &tar"
			},
			aff1 = {
				name = "sizzle",
				aff = "sensitivity",
				com = "sizzle &tar"
			},
			aff2 = {
				name = "galvanize",
				aff = "recklessness",
				com = "galvanize &tar"
			}
		},
		["sylvan"] = {
			light = {
				name = "torrent",
				com = "cast torrent at &tar"
			},
			heavy = {
				name = "stonevine",
				com = "stonevine &tar"
			},
			raze = {
				name = "pierce",
				com = "pierce &tar"
			},
			synergy = {
				name = "leechroot",
				aff1 = "inhibit",
				aff2 = "weakness",
				com = "leechroot &tar"
			},
			aff1 = {
				name = "sandstorm",
				aff = "fear",
				com = "cast sandstorm at &tar"
			},
			aff2 = {
				name = "rockshot",
				aff = "amnesia",
				com = "cast rockshot at &tar"
			}
		},
		["unnamable"] = {
			light = {
				name = "shriek",
				com = "unnamable shriek &tar"
			},
			heavy = {
				name = "destroy",
				com = "unnamable destroy &tar"
			},
			raze = {
				name = "sunder",
				com = "unnamable sunder &tar"
			},
			synergy = {
				name = "onslaught",
				aff1 = "stun",
				aff2 = "sensitivity",
				com = "unnamable onslaught &tar"
			},
			aff1 = {
				name = "dread",
				aff = "fear",
				com = "croon dread &tar"
			},
			aff2 = {
				name = "entropy",
				aff = "aeon",
				com = "croon entropy &tar"
			}
		},
		["water elemental"] = {
			light = {
				name = "icicles",
				com = "manifest icicles &tar"
			},
			heavy = {
				name = "needlerain",
				com = "manifest needlerain &tar"
			},
			raze = {
				name = "aquahammer",
				com = "manifest aquahammer &tar"
			},
			synergy = {
				name = "waterfall",
				aff1 = "weakness",
				aff2 = "aeon",
				com = "manifest waterfall &tar"
			},
			aff1 = {
				name = "dehydrate",
				aff = "clumsiness",
				com = "manifest dehydrate &tar"
			},
			special = {
				name = "swell",
				com = "manifest swell &tar"
			}
		}
	},

	["rageInfo"] = {
		["light"] = {
			cost = 14, cooldown = 16
		},
		["heavy"] = {
			cost = 36, cooldown = 23
		},
		["raze"] = {
			cost = 17, cooldown = 0
		},
		["synergy"] = {
			cost = 25, cooldown = 23
		},
		["aeon"] = {
			cost = 24, cooldown = 35
		},
		["amnesia"] = {
			cost = 28, cooldown = 41
		},
		["charm"] = {
			cost = 32, cooldown = 43
		},
		["clumsiness"] = {
			cost = 14, cooldown = 23
		},
		["fear"] = {
			cost = 29, cooldown = 34
		},
		["inhibit"] = {
			cost = 18, cooldown = 25
		},
		["recklessness"] = {
			cost = 18, cooldown = 19
		},
		["sensitivity"] = {
			cost = 25, cooldown = 27
		},
		["stun"] = {
			cost = 26, cooldown = 33
		},
		["weakness"] = {
			cost = 22, cooldown = 31
		},
		["special_earth elemental"] = {
			cost = 30, cooldown = 40
		},
		["special_fire elemental"] = {
			cost = 30, cooldown = 42
		},
		["special_infernal"] = {
			cost = 20, cooldown = 37
		},
		["special2_infernal"] = {
			cost = 30, cooldown = 43
		},
		["special_paladin"] = {
			cost = 33, cooldown = 53
		},
		["special2_paladin"] = {
			cost = 31, cooldown = 44
		},
		["special_runewarden"] = {
			cost = 28, cooldown = 45
		},
		["special2_runewarden"] = {
			cost = 35, cooldown = 57
		},
		-- Unnamable has some unusual numbers on their abilities
		["entropy"] = {
			cost = 32, cooldown = 38
		},
		["dread"] = {
			cost = 24, cooldown = 35
		},
		["special_water elemental"] = {
			cost = 30, cooldown = 42
		}
	},

	["globalBlacklist"] = {
		"a crystalline golem",
		"a fiery efreeti",
		"a water weird",
		"a mature racing snail",
		"an adolescent racing snail",
		"a sharp-toothed gremlin",
		"a bloodleech",
		"a simpering sycophant",
		"a chaos hound",
		"a chaos storm",
		"a humbug",
		"a withered crone",
		"a doppleganger",
		"a green slime",
		"an eldritch abomination",
		"a bubonis",
		"an ethereal firelord",
		"a pathfinder"
	},

	["mobWhitelist"] = mobWhitelist,
	["mobBlacklist"] = mobBlacklist,
	["attackStrategems"] = attackStrategems,
	["battlerageStrategems"] = battlerageStrategems,

	["dragonBreath"] = {
		["golden dragon"] = "psi",
		["green dragon"] = "venom",
		["red dragon"] = "dragonfire",
		["black dragon"] = "acid",
		["silver dragon"] = "lightning",
		["blue dragon"] = "ice",
	},

	["incantationLimit"] = 15000,

	["skillRanks"] = {
		["inept"] = 0,
		["novice"] = 1,
		["apprentice"] = 2,
		["capable"] = 3,
		["adept"] = 4,
		["skilled"] = 5,
		["gifted"] = 6,
		["expert"] = 7,
		["virtuoso"] = 8,
		["fabled"] = 9,
		["transcendent"] = 10,
		["trans"] = 10,
	},
}