# Foxhunt
Adaptation of the Foxhunt system updated by Seldin Ka'Tal.

## Credits
Armali - Original Foxhunt creator
Orinna - Orion support
Fendo - Wundersys support, support for some classes (i.e. Unnamable)
Seldin - New features, bug fixes, Bard attack strategem update

## Features

- Hunting package for your current room only. This does not include any auto-walking

### HCONFIG
Usage: `hconfig`

This command is the primary way to configure settings within Foxhunt. You can see a list of your current configurations by doing `hconfig`

Example output:
```
+-Hunting Configuration--------------------------------------------------------+
|  Targeting                 WHITELIST    Attacking                      AUTO  |
|  WhitelistPriorityOrder           ON    IgnoreOtherPlayers              OFF  |
|  AttackStrat                     DAM    BattlerageStrat                AMNE  |
|  UseQueueing                      ON    TargetOrder                   ORDER  |
|  TargetCall                      OFF    AutoGrabGold                     ON  |
|  AutoGrabShards                   ON    Separator                         |  |
|  ShowPrompt                      OFF    Version                       1.5.0  |
+------------------------------------------------------------------------------+
```

Some recommended settings are:
- Targeting: WHITELIST
- Attacking: AUTO
- WhitelistPriorityOrder: ON
- IgnoreOtherPlayers: OFF

If you have a high-latency connection, it is recommended to set UseQueueing to ON. This will utilise the FREESTAND queue to perform attacks.

#### Targeting
Usage `hconfig targeting [manual/whitelist/blacklist/auto]`

This determines how Foxhunt handles the current target within the room.

- Manual will require user input to define the current target
- Whitelist will only target denizens that are whitelisted for your current area
- Blacklist will only target denizens that are blacklisted for your current area
- Auto will target all valid denizens

#### Attacking
Usage: `hconfig attacking [off/single/room/auto]`

- Off will result in not Attacking
- Single will only hunt a single denizen at a time (i.e. it will not move on to the next denizen)
- Room will hunt all valid denizens in the room (per Targeting), but will not start attacking until the user starts
- Auto is the same as Room, except it will automatically start attacking immediately without user input

#### WhitelistPriorityOrder
Usage: `hconfig whitelistpriorityorder [on/off]`

This setting is only used if `TARGETING` is set to `WHITELIST`

- On will target in order of Whitelist Priority
- Off will target purely based on the `TargetOrder` setting

#### IgnoreOtherPlayers
Usage: `hconfig ignoreotherplayers [on/off]`

- On will result in Foxhunt not respecting that there may have already been another player in your room when you entered, and therefore start attacking immediately if configured to do so
- Off will result in Foxhunt respecting that another player was in the room before you entered and not attack, and thus not 'steal their kills'

NOTE: If you are in a group and get separated from your group leader, having this set to `OFF` will result in needing to manually start attacking in the room again, as it does not respect that the other player in the room was your group leader and that you're following them. This may be fixed in future.

#### AttackStrat
Usage: `hconfig attackstrat [none/dam/...]`

All classes have access to the `NONE` and `DAM` attack strategems. `DAM` will choose a base default attack strategem used by your class. Each class may have their own set of different attack strategems that may be more applicable to your situation. As an example, warrior classes also have access to the attack strategem `HAM` which, for two-handed warriors, will use the Splinter ability to break shields.

NOTE: If you notice `NONE` or `DAM` is missing for your class, please report this! If you have suggestions on better ways to handle your class's attacking strategem, please submit the details!

#### BattlerageStrat
Usage `hconfig battleragestrat [none/dam/praze/pnoraze/...]`

All classes have access to the `NONE`, `DAM`, `PRAZE`, `PNORAZE` battlerage strategems. Each class will have their own additional battlerage strategems based on the afflictions they can apply, such as `AMNE` for Amnesia.

- `DAM` will focus on doing damage only - it will not use any battlerage abilities to give afflictions, but it will use synergy attacks enabled by other adventurer's applying afflictions
- `PRAZE` and `PNORAZE` are specifically designed strategems to use for "Pulling" (typically used in Forays). It is the same as `DAM` except:
  - It will never use the LIGHT attack for your class, as this is typically the ability used to pull denizens
  - It will keep enough of a buffer on your Battlerage to ensure that you can do at least one LIGHT battlerage attack
  - NOTE: If the enemies die too quickly, you might run out of battlerage!

#### UseQueueing
Usage: `hconfig usequeueing [on/off]`

If enabled, Foxhunt will use the FREESTAND queue for attacks. Recommended if you have a high-latency connection.

#### TargetOrder
Usage: `hconfig targetorder [numeric/order/reverse]`

- Numeric will target in numerical order (ascending)
- Reverse will target in numerical order (descending)
- Order will target in the order in which they appear on INFO HERE

#### TargetCall
Usage: `hconfig targetcall [yes/no]`

If enabled, you will call out your target over a Party.

#### AutoGrabGold
Usage: `hconfig autograbgold [on/off]`

If enabled, you will try to pick up gold and put it away, as set by the "customGold" definition (touched on further below).

NOTE: This will not put away gold if you have the Attractor power. It also does not account for Amnesia if it might prevent you from picking up the gold.

#### AutoGrabShards
Usage: `hconfig autograbshards [on/off]`

DEPRECATED! Shards are no longer used in Achaea. But it may return at some point, you never know!

#### Separator
Usage: `hconfig separator [sep]`

Used to configure the Command Separator for a character. This should match what you have set in game using `CONFIG COMMANDSEPARATOR`. Foxhunt will automatically detect your Separator if you do `CONFIG COMMANDSEPARATOR` as mentioned.

#### Show Prompt
Usage: `hconfig showprompt [on/off]`

Used to turn on/off a small helper string on your prompt. How this shows will be based on how your prompt is handled by your system. This shows you which battlerage abilities are available in the form:
```
(L|H|1|2|S)
```
- L is LIGHT attack
- H is HEAVY attack
- 1 is AFF1 (dependent on your class)
- 2 is AFF2 (dependent on your class)
- S is SYNERGY (dependent on your class)

### Whitelist/Blacklist
Foxhunt supports using a whitelist and a blacklist for hunting. You can adjust these as necessary.

These are stored in a database and will persist between sessions.

Command: `[whitelist/blacklist] show`
- Shows the list for the area you are currently standing in. Allows adjustment of the list via clicking

Command: `[whitelist/blacklist] add [name]`
- Adds `name` to your list for the current area at the bottom of the list

Command: `[whitelist/blacklist] remove [name]`
- Removes `name` from your list for the current area

Command: `[whitelist/blacklist] shift [name] [up/down]`
- Shifts `name` either `up` or `down` in your list

Command: `[whitelist/blacklist] move [name] [number]`
- Moves `name` to list position `number`

#### INFO HERE Integration
You can adjust your lists through using `INFO HERE` or `IH`. It will make all killable denizens clickable in the list. Based on the list they are in, the names will be highlighted in different colours.

Colours:
- White: Not on any list
- Green: whitelisted
- Red: blacklisted

When clicking the names, the denizen will be moved between the above settings in that order. If white, it will move to green. If green, it will move to red. If red, it will move back to white.

### Profiles
A basic profile system has been introduced to Foxhunt which will keep track of the last used Attack Strategem and Battlerage Strategem used for each class that you access. When changing class, the strategems will be changed over automatically as per what you used last.

You can see these profiles with the command: `hconfig profiles`

You cannot adjust these profiles with `hconfig` at this time - you must change your strategems while in the appropriate class.

NOTE: There is currently a bug where the profile does not appear to change over as expected. There is some debug echoes that will output a few lines alerting you to when this happens. This can be ignored, as when this occurs, there is a workaround in place that will resolve itself automatically.

## Customisable Settings
There are some definitions within Foxhunt that you can customise to better suit your needs. You can achieve this by editing the Scripts directly, or you can write a new Script to overwrite the code by redefining it.

### Custom Gold Containment
Found in: Hunting Definitions
Stored in: `system.hunting.defs.customGold`

Defines the actions to perform to store gold that you've picked up - must be defined as a table. This can be multiple commands - supply them as separate strings in the table. An example is given below.

Base definition:
```lua
	["customGold"] = {
		"put sovereigns in pack"
	}
```

Example overwrite script:
```lua
	if system and system.hunting and system.hunting.defs and system.hunting.defs.customGold then
		system.hunting.defs.customGold = {
			"get knapsack from pack654321"
			"put sovereigns in knapsack123456",
			"put knapsack in pack654321"
		}
	end
```

### Incantation Willpower Limit
Found in: Hunting Definitions
Stored in: `system.hunting.defs.incantationLimit`

For Dragons, this defines how low your Willpower must get before you then change over to using Gut, if you are using the `MAG` attack strategem (which uses incantation).

Base definition:
```lua
	["incantationLimit"] = 15000
```

### MyPrepend
Found in: Hunting Functions
Function defined as: `system.hunting.funcs.myPrepend()`

This defines custom commands to include as a prepend to the hunting attack determined by your Attack Strategem. Currently by default this includes using SLOUGH for Fire Elementals to cure afflictions while hunting - if using Orion.

This code was either added by Orinna or by someone who regularly played Fire Elemental enough to add this code.

Base definition:
```lua
function system.hunting.funcs.myPrepend()
	-- Ensure that if this is filled out with anything that it ends with the command separator (vars.separator)
	local prepend = ""
	if ori then
		prepend = ori.prepend()

		if system.hunting.funcs.getClass() == "fire elemental" then
			if ori.cla.fire.bals.slough and ori.vitals.spark == 4 and (ori.affs.blackout or ori.ssc.unknownAffs > 0) then
				prepend = prepend .. "slough impurities invoke" .. system.hunting.vars.separator
			end
		end
	end
	return prepend
end
```

### MyAppend
Found in: Hunting Functions
Function defined as: `system.hunting.funcs.myAppend()`

This defines custom commands to include as an append to the hunting attack determined by your Attack Strategem. This could be used for adding suffixes to your attacks such as adding SHRUGGING for Serpents.

Base definition:
```lua
function system.hunting.funcs.myAppend()
	-- If necessary, start the append with the command separator (vars.separator)
	local append = ""
	return append
end
```

### Attack Override
Function defined as: `system.hunting.funcs.tryOverride(action)`

This is a feature that is currently a work-in-progress. The intention of this function is to enable the ability to override what Foxhunt is using for the next attack. An example usage of this is to force Foxhunt to draw a Matic card next, instead of doing the standard attack.

This is not yet fully functioning as desired, but works to an extent. Sometimes it requires re-doing the alias. Provided below are two example usages of this function.

Draw Matic:
```lua
local action = "ldeck draw matic"
if not system.hunting.funcs.tryOverride(action) then
  send("queue prepend eb " .. action)
end
```

Diagnose:
```lua
local action = "diagnose"
if not system.hunting.funcs.tryOverride(action) then
  send("queue prepend eb " .. action)
end
```