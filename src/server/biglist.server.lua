-- For testing bulk sorting ability
biglist = {66, 19, 67, 69, 44, 57, 53, 59, 39, 33, 23, 21, 47, 14, 26, 71,
15, 24, 12, 54, 37, 11, 79, 58, 70, 61, 38, 29, 31, 42, 10, 76, 45, 75, 74, 40,
18, 78, 36, 73, 51, 28, 43, 80, 27, 64, 55, 50, 20, 65, 17, 41, 56, 16, 72, 7, 
48, 25, 34, 22, 60, 77, 8, 68, 32, 63, 3, 62, 46, 52, 49, 6, 5, 30, 35, 4, 1, 2, 
13, 9, 81, 58, 79, 67, 55, 69, 18, 73, 59, 68, 80, 72, 61, 54, 19, 71, 21, 20, 
53, 25, 26, 64, 27, 50, 28, 45, 47, 44, 43, 42, 41, 38, 33, 37, 36, 35, 34, 31, 
29, 24, 23, 22, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}

-- For testing sorting stability & strings
biglist2 = {"apple", "banana-", "cherry", "dog", "elephant", "cherry", 
"apple", "banana", "fox", "giraffe", "horse", "igloo", "jaguar", "kangaroo", 
"lion", "monkey", "apple", "cherry", "giraffe", "nest"}

table.freeze(biglist)
table.freeze(biglist2)

ds = require(game.ServerScriptService.Collections.Sort)

function isSorted(arr)
	local first = arr[1]

	for i, v in ipairs(arr) do
		if v < first then
			return false
		end
		first = v
	end

	return true
end

qsort = table.clone(biglist)
qsort2 = table.clone(biglist2)

print(isSorted(qsort))
ds.MergeSort(qsort)
print(isSorted(qsort))

print(isSorted(qsort2))
ds.MergeSort(qsort2)
print(isSorted(qsort2))