-- Type of table that calls a factory function to supply missing values.
-- NOTE: "_pr" cannot be used as an index
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

	defaultdict._pr = {}  -- index stores properties
	defaultdict._pr["__index"] = function(table, index)
		table[index] = factory()
	
	end

	setmetatable(defaultdict, defaultdict._pr)
	
	return defaultdict

end

-- Return contents of DefaultDict as a table
-- Essential for looping and counting
function DefaultDict:toList()
	local t = {}

	for i,v in pairs(self) do
		if i ~= "_pr" then
			t[i] = v

		end

	end

	return t

end

function DefaultDict:size()
	local c = -1 -- ignores the properties index

	for i,v in pairs(self) do
		c += 1

	end

	return c
	
end

return DefaultDict
