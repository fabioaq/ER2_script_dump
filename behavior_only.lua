--Const declarations
local UPDATE_INTERVAL = 10  -- Seconds between behavior checks
local ALERT_DURATION = 30  -- Seconds to keep AI alert

local all_soldiers = {} --soldiers array

if not er2.isMasterClient() then
    return  -- Only run on host
end

-- Check if already initialized
if not global.get("behavior_init") then
    global.set(true, "behavior_init")
end

while true do
    sleep(UPDATE_INTERVAL)

    er2.getAllSoldiers(all_soldiers)

    for _, soldier in ipairs(all_soldiers) do
    
        --Check if soldier is dead
        if soldier.isAlive() then
        
            --Check if soldier is in a Vehicle or the Player
            if not soldier.isPlayer() then

				-- Configure cautious behavior parameters
				local ai = soldier.getAiParams()
				ai.allowFindCoverWhenSuppressed(true)
				ai.allowChangePose(true)
				ai.allowCheckForEnemies(true)
				ai.allowFollowOrders(true)
				ai.allowMovements(true)
                soldier.alertFor(ALERT_DURATION)
            end
        end
    end
end