-- TimSort function
function TimSort(array)
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

local sort = {
	a = { 2, 3, 1, 5, 4 },
	b = { 52, 45, 32, 64, 12, 87, 78, 98, 23, 7 },
	c = { 45, 12, 85, 32, 89, 39, 69, 44, 42, 1, 6, 8 },
	d = { 1 },
}

-- Testing
TimSort(sort["a"])
TimSort(sort['b'])
TimSort(sort["c"])
TimSort(sort["d"])

print(sort)