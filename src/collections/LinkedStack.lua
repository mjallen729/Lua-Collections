local LinkedStack = {}
LinkedStack.__index = LinkedStack

local LinkedList = require(script.Parent.LinkedList)

-- Create a new linked stack, a linked list based implementation of stack.
-- Allows for array casting if desired (last item will be top of stack)
function LinkedStack.new(...)
	local linkedstack = {}
	setmetatable(linkedstack, LinkedStack)

	local args = ...

	linkedstack.buffer = LinkedList.new(args)

	return linkedstack
end

-- Keep in mind this method runs in O(N) time.
-- Returns element at the given index, does not remove (returns top of the stack by default)
function LinkedStack:peek(index)
	if self:length() == 0 then
		return nil
	end

	if not index then
		return self.buffer.last.data
	end

	return self.buffer:atIndex(index).data
end

-- Push a new element on to the top of the stack
function LinkedStack:push(value)
	self.buffer:add(value)
end

-- Remove and return the element at the top of the stack
function LinkedStack:pop()
	local len = self.buffer:length()

	if len == 0 then
		return nil
	end

	return self.buffer:pop(len).data
end

function LinkedStack:length()
	return self.buffer:length()
end

-- Returns index of element equal to the query or nil if does not exist
function LinkedStack:find(query)
	return self.buffer:find(query)
end

return LinkedStack
