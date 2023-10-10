
function createDungeon(level)
	local dungeon = {level = level or 1}
	
	-- item, enemy, ?trap, ?next level
	function dungeon:explore()
		local result = math.random(3)
		if result == 1 then
			
		elseif (result == 2) then
			
		elseif (result == 3) then
			
		end
	end	
	
	return dungeon	
end