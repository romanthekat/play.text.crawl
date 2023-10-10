
--- Creates simple humanoid object
-- @param name 
-- @param[opt=3] str The second argument
-- @param[opt=3] dex The second argument
-- @param[opt=3] int The second argument
-- @return humanoid object 
function createHumanoid(name, str, dex, int)
	local humanoid = {name = name, str = str or 3, dex = dex or 3, int = int or 3}
	
	function humanoid:test() 
		print('name=' .. self.name .. ' str=' .. str)
	end
	
	return humanoid
end