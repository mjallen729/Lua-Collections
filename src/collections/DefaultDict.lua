-- Type of table that calls a factory function to supply missing values
local DefaultDict = {}
DefaultDict.__index = DefaultDict

-- Create a new DefaultDict using 'factory' as the factory function
-- Read more about DefaultDict in Python's collections library docs
function DefaultDict.new(factory)
	local defaultdict = {}
	setmetatable(defaultdict, DefaultDict)

	if type(factory) ~= "function" then
		error("[DataKit] Type 'function' must be passed to DefaultDict")

	end

	-- idea: store buffer table inside of new instance like queue does
	-- store metatable for buffer inside local object with metamethod __index
	-- for __index metamethod, include the factory function

	defaultdict.buffer = {}
	defaultdict.length = 0
	defaultdict.buffer_fac = {}
	defaultdict.buffer_fac.__index = function(table, index)
		table[index] = factory()
		
	end

	setmetatable(defaultdict.buffer, defaultdict.buffer_fac)
	
	return defaultdict

end

function DefaultDict:get(index)
	return self.buffer[index]
	
end


return DefaultDict
