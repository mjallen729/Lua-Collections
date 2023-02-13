local ds = require(game.ServerScriptService.Collections)
local dsort = ds.Sort

function compare(arr1, arr2)
	for i,v in ipairs(arr1) do
		if arr1[i] ~= arr2[i] then
			return false
			
		end
		
	end
	
	return true
	
end

local sort = {
	a = {2,3,1,5,4},
	b = {52,45,32,64,12,87,78,98,23,7},
	c = {45,12,85,32,89,39,69,44,42,1,6,8},
	d = {1}
}

local sorted = {
	a = {1,2,3,4,5},
	b = {7,12,23,32,45,52,64,78,87,98},
	c = {1,6,8,12,32,39,42,44,45,69,85,89},
	d = {1}
}

-- QuickSort
dsort.QuickSort(sort['a'])
dsort.QuickSort(sort['b'])
dsort.QuickSort(sort['c'])
dsort.QuickSort(sort['d'])
assert(compare(sort['a'],sorted['a']))
assert(compare(sort['b'],sorted['b']))
assert(compare(sort['c'],sorted['c']))
assert(compare(sort['d'],sorted['d']))