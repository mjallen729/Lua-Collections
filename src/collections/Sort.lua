-- Pass an unsorted array as input & sort (ascending) using the algorithm of your choice.
-- Works for both List<String> and List<Number> (but NOT List<String & Number>)
local Sort = {}

-- Avg time: O(nlog(n))
-- Worst space: O(log(n))
-- Low and high are optional parameters (nil recommended)
-- Stable: No | In-Place: Yes
function Sort.QuickSort(arr, low, high)
	local function partition(arr, low, high)
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

	-- Recursive agent for QuickSort
	local function qSort(arr, low, high)
		if low < high then
			local pi = partition(arr, low, high)

			qSort(arr, low, pi - 1)
			qSort(arr, pi + 1, high)
		end
	end

	if not arr then
		error("[DataKit] Cannot QuickSort an empty array!")
		return nil
	end

	local newlow = low
	local newhigh = high

	if not low or low < 0 or low > high then
		newlow = 1
		warn("[DataKit] Low parameter for QuickSort forced default value (1).")
	end

	if not high or high > #arr or high < low then
		newhigh = #arr
		warn("[DataKit] High parameter for QuickSort forced default value (#arr).")
	end

	qSort(arr, newlow, newhigh)
	
end

-- Avg time: O(nlog(n))
-- Worst space: O(n)
-- Stable: Yes | In-Place: Yes
function Sort.MergeSort(arr)
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

-- Avg time: O(nlog(n))
-- Worst space: O(n)
-- Stable: Yes | In-Place: Yes
function Sort.TimSort(arr)
	local function insertionSort(arr, left, right)
		for i = left + 1, right do
			local value = arr[i]
			local j = i - 1
			while j >= left and arr[j] > value do
				arr[j + 1] = arr[j]
				j = j - 1
			end
			arr[j + 1] = value
		end
	end

	local function merge(arr, left, middle, right)
		local leftSize = middle - left + 1
		local rightSize = right - middle

		-- Create temp arrays
		local leftArray = {}
		local rightArray = {}

		-- Copy data to temp arrays
		for i = 1, leftSize do
			leftArray[i] = arr[left + i - 1]
		end
		for i = 1, rightSize do
			rightArray[i] = arr[middle + i]
		end

		-- Merge the temp arrays back into array[left..right]
		local i = 1
		local j = 1
		local k = left
		while i <= leftSize and j <= rightSize do
			if leftArray[i] <= rightArray[j] then
				arr[k] = leftArray[i]
				i = i + 1
			else
				arr[k] = rightArray[j]
				j = j + 1
			end
			k = k + 1
		end

		-- Copy the remaining elements of leftArray[], if there are any
		while i <= leftSize do
			arr[k] = leftArray[i]
			i = i + 1
			k = k + 1
		end

		-- Copy the remaining elements of rightArray[], if there are any
		while j <= rightSize do
			arr[k] = rightArray[j]
			j = j + 1
			k = k + 1
		end
	end

	local function timSort(arr, left, right)
		local size = right - left + 1
		if size <= 16 then
			insertionSort(arr, left, right)
			return
		end

		local middle = math.floor((left + right) / 2)
		timSort(arr, left, middle)
		timSort(arr, middle + 1, right)
		merge(arr, left, middle, right)
	end

	timSort(arr, 1, #arr)
end

return Sort
