--test AI

--set current soldier
local soldier = myself()
local ai = soldier.getAiParams()

--Const declarations
local UPDATE_INTERVAL = 1  -- Seconds between accuracy checks
local ALERT_DURATION = 30  -- Seconds to keep AI alert


while true do
    sleep(UPDATE_INTERVAL)
	
	--Check if soldier is dead
	if not soldier.isAlive() then
		break
    
    --Check if soldier is in a Vehicle or the Player
    elseif not soldier.isInVehicle() and not soldier.isPlayer() then
	
		local target = soldier:getTarget()
		if target then
			-- Calculate distance to target
			local soldier_pos = soldier:getPosition()
			local target_pos = target:getPosition()
			local dist = distance(soldier_pos, target_pos)
			
			-- Calculate spread multiplier
			local t = math.min(math.max((dist - min_distance) / (max_distance - min_distance), 0), 1)
			local spread_multiplier = close_spread + t * (far_spread - close_spread)
			
			-- Apply to current weapon
			local weapon = soldier:getCurrentWeapon()
			if weapon then
				local base_spread = weapon:getBaseSpread()
				weapon:setSpread(base_spread * (spread_multiplier - 1))  -- Additive to base spread
			end
		end
		
		-- Keep AI in alert state
		soldier.alertFor(ALERT_DURATION)
		
	end
end