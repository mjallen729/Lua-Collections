local Stack = {}
Stack.__index = Stack

-- Create a new stack, allows for array casting if desired (last item in array will be top of stack)
function Stack.new(...)
	local stack = {}
	setmetatable(stack, Stack)

	local args = ...

	stack.buffer = {} -- An array-implementated Stack
	stack.length = 0

	if args ~= nil then
		if #{ ... } > 1 then
			warn("[DataKit] Stack recieved argument not of type array! An empty Stack has been created instead.")
			return stack
		end

		for i, v in ipairs(args) do
			if not v then
				continue
			end

			table.insert(stack.buffer, v)
			stack.length += 1
		end
	end

	return stack
end

-- Returns element at the given index, does not remove (returns top of the stack by default)
function Stack:peek(index)
	if not index then
		return self.buffer[#self.buffer]
	end

	return self.buffer[index]
end

-- Push a new element on to the top of the stack
function Stack:push(value)
	table.insert(self.buffer, value)
	self.length += 1
end

-- Remove and return the element at the top of the stack
function Stack:pop()
	if #self.buffer == 0 then
		return nil
	end

	local elem = self.buffer[#self.buffer]

	table.remove(self.buffer, #self.buffer)
	self.length -= 1

	return elem
end

function Stack:length()
	return self.length
end

-- Returns index of element equal to the query or nil if does not exist
function Stack:find(query)
	for i, v in ipairs(self.buffer) do
		if v == query then
			return i
		end
	end

	return nil
end

return Stack
