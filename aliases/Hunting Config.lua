--^(?i)\s*hconfig\s*$

local funcs = system.hunting.funcs
local vars = system.hunting.vars
local defs = system.hunting.defs

funcs.tableHeaderFooter("Hunting Configuration")

-- FIRST ROW
funcs.tableRow(
	funcs.makeColumn("Targeting", vars.targetingMode),
	funcs.makeColumn("Attacking", vars.attackingMode)
	)

--- SECOND ROW
funcs.tableRow(
	funcs.makeColumn("WhitelistPriorityOrder", vars.whitelistPriorityOrder),
	funcs.makeColumn("IgnoreOtherPlayers", vars.ignoreOtherPlayers)
	)

--- THIRD ROW
funcs.tableRow(
	funcs.makeColumn("AttackStrat", vars.attackMode),
	funcs.makeColumn("BattlerageStrat", vars.battlerageMode)
	)

--- FOURTH ROW
funcs.tableRow(
	funcs.makeColumn("UseQueueing", vars.useQueueing),
	funcs.makeColumn("TargetOrder", vars.targetOrder)
	)

--- FIFTH ROW
funcs.tableRow(
	funcs.makeColumn("TargetCall", vars.targetCall),
	funcs.makeColumn("AutoGrabGold", vars.autoGrabGold)
	)

--- SIXTH ROW
funcs.tableRow(
	funcs.makeColumn("AutoGrabShards", vars.autoGrabShards),
	funcs.makeColumn("Separator", vars.separator)
	)

--- SEVENTH ROW
funcs.tableRow(
	funcs.makeColumn("ShowPrompt", vars.showPrompt),
	funcs.makeColumn("Version", defs.version)
	)

funcs.tableHeaderFooter()

send(" ")