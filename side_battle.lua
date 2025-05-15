--const declarations--------------------
local SQUAD_AXIS = "ger_afrikaKorps"
local SPAWN_AXIS = vec3(-228.939,5.18037,-133.1619)
local FACTION_AXIS = "Germany_axis"
local SQUAD_ALLIES = "usa_infantry_africa"
local SPAWN_ALLIES = vec3(-395.3201,5.180368,-174.9596)
local FACTION_ALLIES = "UnitedStates_allies"
local MOVE_TO_SCRIPT = "sideBattle.lua"
-----------------------------------------


if not er2.isMasterClient() then
    return  -- Only run on host
end

-- Check if already initialized
if not global.get("distant_battle") then
    global.set(true, "distant_battle")
end

local axisSquad = spawnSquad_script(SPAWN_AXIS, 20, FACTION_AXIS, SQUAD_AXIS, MOVE_TO_SCRIPT)
local alliesSquad = spawnSquad_script(SPAWN_ALLIES, 20, FACTION_ALLIES, SQUAD_ALLIES, MOVE_TO_SCRIPT)
local axis = {}
local allies = {}

while true do
	sleep(5)
	--local c = 0
	--local a = 0
	axisSquad.getAllMembers(axis)
	alliesSquad.getAllMembers(allies)
	
	if #axis < 2 then
		axisSquad = spawnSquad_script(SPAWN_AXIS, 20, FACTION_AXIS, SQUAD_AXIS, MOVE_TO_SCRIPT)
	end

	if #allies < 2 then
		alliesSquad = spawnSquad_script(SPAWN_ALLIES, 20, FACTION_ALLIES, SQUAD_ALLIES, MOVE_TO_SCRIPT)
	end

	axis = {}
	allies = {}

end