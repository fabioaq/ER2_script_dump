--Const declarations
local MIN_DISTANCE = 20    -- Minimum distance for max accuracy (meters)
local MAX_DISTANCE = 300   -- Distance where accuracy reaches minimum
local CLOSE_SPREAD = 0.8   -- Spread multiplier at min_distance (more accurate)
local FAR_SPREAD = 2.5     -- Spread multiplier at max_distance (less accurate)
local UPDATE_INTERVAL = 1  -- Seconds between accuracy checks
local BEHAVIOR_INTERVAL = 10 -- Seconds between behavior checks
local ALERT_DURATION = 30  -- Seconds to keep AI alert


local c = BEHAVIOR_INTERVAL --Counter to keep track of behavior checks

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
            if not soldier.isInVehicle() and not soldier.isPlayer() then
            
                local target = soldier:getTarget()
                if target then
                    -- Calculate distance to target
                    local soldier_pos = soldier:getPosition()
                    local target_pos = target:getPosition()
                    local dist = distance(soldier_pos, target_pos)
                    
                    -- Calculate spread multiplier
                    local t = math.min(math.max((dist - MIN_DISTANCE) / (MAX_DISTANCE - MIN_DISTANCE), 0), 1)
                    local spread_multiplier = CLOSE_SPREAD + t * (FAR_SPREAD - CLOSE_SPREAD)
                    
                    -- Apply to current weapon
                    local weapon = soldier:getCurrentWeapon()
                    if weapon then
                        local base_spread = weapon:getBaseSpread()
                        weapon:setSpread(base_spread * (spread_multiplier - 1))  -- Additive to base spread
                    end
                end

                if c == BEHAVIOR_INTERVAL then
                    -- Configure cautious behavior parameters
                    local ai = soldier.getAiParams()
                    ai.allowFindCoverWhenSuppressed(true)
                    ai.allowChangePose(true)
                    ai.allowCheckForEnemies(true)
                    ai.allowFollowOrders(true)
                    ai.allowMovements(true)
                    soldier.alertFor(ALERT_DURATION)
                    c = 0
                end
                
            end
        end
    end

    c = c + 1
end