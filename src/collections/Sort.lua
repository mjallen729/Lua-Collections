-- Pass an unsorted array as input & sort (ascending, in-place) using the algorithm of your choice.
-- Works for both List<String> and List<Number> (but NOT List<String & Number>)
local Sort = {}

-- Avg time: O(nlog(n))
-- Worst space: O(log(n))
-- Low and high are optional parameters (nil recommended)
-- Stable: No
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
function Sort.MergeSort(arr) end

-- Avg time: O(nlog(n))
-- Worst space: O(n)
-- Stable: Yes
function Sort.TimSort(array)
	local function insertionSort(array, left, right)
		for i = left + 1, right do
			local value = array[i]
			local j = i - 1
			while j >= left and array[j] > value do
				array[j + 1] = array[j]
				j = j - 1
			end
			array[j + 1] = value
		end
	end

	local function merge(array, left, middle, right)
		local leftSize = middle - left + 1
		local rightSize = right - middle

		-- Create temp arrays
		local leftArray = {}
		local rightArray = {}

		-- Copy data to temp arrays
		for i = 1, leftSize do
			leftArray[i] = array[left + i - 1]
		end
		for i = 1, rightSize do
			rightArray[i] = array[middle + i]
		end

		-- Merge the temp arrays back into array[left..right]
		local i = 1
		local j = 1
		local k = left
		while i <= leftSize and j <= rightSize do
			if leftArray[i] <= rightArray[j] then
				array[k] = leftArray[i]
				i = i + 1
			else
				array[k] = rightArray[j]
				j = j + 1
			end
			k = k + 1
		end

		-- Copy the remaining elements of leftArray[], if there are any
		while i <= leftSize do
			array[k] = leftArray[i]
			i = i + 1
			k = k + 1
		end

		-- Copy the remaining elements of rightArray[], if there are any
		while j <= rightSize do
			array[k] = rightArray[j]
			j = j + 1
			k = k + 1
		end
	end

	local function timSort(array, left, right)
		local size = right - left + 1
		if size <= 16 then
			insertionSort(array, left, right)
			return
		end

		local middle = math.floor((left + right) / 2)
		timSort(array, left, middle)
		timSort(array, middle + 1, right)
		merge(array, left, middle, right)
	end

	timSort(array, 1, #array)
end

return Sort
