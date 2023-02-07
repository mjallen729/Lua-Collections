-- Type of table that calls a factory function to supply missing values

local DefaultDict = {}
DefaultDict.__index = DefaultDict

-- Create a new DefaultDict using 'factory' as the factory function
-- Read more about DefaultDict in Python's collections library docs
function DefaultDict.new(factory)
	local defaultdict = {}
	setmetatable(defaultdict, DefaultDict)

	
end

return DefaultDict
