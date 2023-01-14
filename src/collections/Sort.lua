-- The following functions take an UNSORTED array as an input & sort it using the algorithm of your choice.
-- It should work for both List<String> and List<Number> (but NOT List<String & Number>)
-- Algorithms sort from least to greatest
local Sort = {}
Sort.__index = Sort

-- TODO: BubbleSort
-- Helper method for QuickSort
function partition(arr, low, high)
	local pivot = arr[high]
	local i = low - 1

	for j = low, high - 1 do
		if arr[j] < pivot then
			i += 1
			local tmp = arr[i]

			arr[i] = arr[j]
			arr[j] = tmp
		end
	end

	local tmp = arr[i + 1]

	arr[i + 1] = arr[high]
	arr[high] = tmp

	return i + 1
end

-- Recursive agent
function qSort(arr, low, high)
	if low < high then
		local pi = partition(arr, low, high)

		qSort(arr, low, pi - 1)
		qSort(arr, pi + 1, high)
	end
end

-- Avg time: O(nlog(n))
-- Worst space: O(log(n))
-- Low and high are optional parameters (nil recommended)
function Sort.QuickSort(arr, low, high)
	if not arr then
		error("[DataKit] Cannot QuickSort an empty array!")
		return nil
	end

	local newlow = low
	local newhigh = high

	if not low or low < 0 or low > high then
		newlow = 1
		warn("[DataKit] Invalid low parameter for QuickSort! Forced default value (1).")
	end

	if not high or high > #arr or high < low then
		newhigh = #arr
		warn("[DataKit] Invalid high parameter for QuickSort! Forced default value (#arr).")
	end

	qSort(arr, newlow, newhigh)
end

-- Avg time: O(nlog(n))
-- Worst space: O(n)
function Sort.MergeSort(arr) end

-- Avg time: O(nlog(n))
-- Worst space: O(1)
function Sort.HeapSort(arr) end

return Sort
