-- For testing bulk sorting ability
biglist = {66, 19, 67, 69, 44, 57, 53, 59, 39, 33, 23, 21, 47, 14, 26, 71,
15, 24, 12, 54, 37, 11, 79, 58, 70, 61, 38, 29, 31, 42, 10, 76, 45, 75, 74, 40,
18, 78, 36, 73, 51, 28, 43, 80, 27, 64, 55, 50, 20, 65, 17, 41, 56, 16, 72, 7, 
48, 25, 34, 22, 60, 77, 8, 68, 32, 63, 3, 62, 46, 52, 49, 6, 5, 30, 35, 4, 1, 2, 
13, 9, 81, 58, 79, 67, 55, 69, 18, 73, 59, 68, 80, 72, 61, 54, 19, 71, 21, 20, 
53, 25, 26, 64, 27, 50, 28, 45, 47, 44, 43, 42, 41, 38, 33, 37, 36, 35, 34, 31, 
29, 24, 23, 22, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1}

-- For testing sorting stability
biglist2 = {"apple-", "banana-", "cherry-", "dog", "elephant", "cherry--", 
"apple--", "banana--", "fox", "giraffe-", "horse", "igloo", "jaguar", "kangaroo", 
"lion", "monkey", "apple---", "cherry---", "giraffe--", "nest"}

table.freeze(biglist)
table.freeze(biglist2)

ds = require(game.ServerScriptService.Collections.Sort)

function mergeSort(arr)
	local function merge(arr, l, m, r)
		local n1 = m - l + 1
		local n2 = r - m

		-- create temp arrays
		local L = {}
		local R = {}

		-- copy data to temp arrays L[] and R[]
		for i = 1, n1 do
			L[i] = arr[l + i - 1]
		end
		for j = 1, n2 do
			R[j] = arr[m + j]
		end

		-- merge the temp arrays back into arr[l..r]
		local i = 1
		local j = 1
		local k = l
		while i <= n1 and j <= n2 do
			if L[i] <= R[j] then
				arr[k] = L[i]
				i = i + 1
			else
				arr[k] = R[j]
				j = j + 1
			end
			k = k + 1
		end

		-- copy the remaining elements of L[], if there are any
		while i <= n1 do
			arr[k] = L[i]
			i = i + 1
			k = k + 1
		end

		-- copy the remaining elements of R[], if there are any
		while j <= n2 do
			arr[k] = R[j]
			j = j + 1
			k = k + 1
		end
	end

	local function bottomUpMergeSort(arr)
		local n = #arr
		local curr_size
		local left_start

		-- sort individual subarrays of size 1
		for i = 1, n, 1 do
			curr_size = 1
			while curr_size < n do
				-- pick starting point of left sub array. We are merging arr[left_start..left_start+curr_size-1]
				-- and arr[left_start+curr_size, left_start + 2*curr_size - 1]
				-- Repeat until we have dealt with all subarrays of current size.
				left_start = 1
				while left_start < n do
					-- find ending point of left sub array
					-- mid+1 is starting point of right
					local mid = left_start + curr_size - 1
					local right_end = math.min(left_start + 2 * curr_size - 1, n)

					-- merge sub arrays
					merge(arr, left_start, mid, right_end)
					left_start = left_start + 2 * curr_size
				end
				curr_size = 2 * curr_size
			end
		end
	end

	bottomUpMergeSort(arr)

end


function isSorted(arr)
	local first = arr[1]

	for i,v in ipairs(arr) do
		if v < first then
			return false
		end
	end

	return true

end

qsort = table.clone(biglist)
qsort2 = table.clone(biglist2)

s = ds.MergeSort(qsort)
print(s)

s2 = ds.MergeSort(qsort2)
print(s2)