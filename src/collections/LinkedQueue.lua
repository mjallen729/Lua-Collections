local LinkedQueue = {}
LinkedQueue.__index = LinkedQueue

local LinkedList = require(script.Parent.LinkedList)

-- Create a new linked queue, a linked list based implementation of queue.
-- Allows for array casting if desired (last item in array will be last in queue)
function LinkedQueue.new(...)
	local linkedqueue = {}
	setmetatable(linkedqueue, LinkedQueue)

	local args = ...

	linkedqueue.buffer = LinkedList.new(args)

	return linkedqueue
end

-- Keep in mind this method runs in O(N) time.
-- Returns element at the given index, does not remove (returns top of the queue by default)
function LinkedQueue:peek(index)
	if self:length() == 0 then
		return nil
	end

	if not index then
		return self.buffer.head.data
	end

	return self.buffer:atIndex(index).data
end

-- Push a new element onto the bottom of the queue
function LinkedQueue:push(value)
	self.buffer:add(value)
end

-- Remove and return the element at the top of the queue
function LinkedQueue:pop()
	if self.buffer:length() == 0 then
		return nil
	end

	return self.buffer:pop(1).data
end

function LinkedQueue:size()
	return self.buffer:size()
end

function LinkedQueue.__len(t)
	return t.buffer:size()
end

-- Returns index of element equal or nil if does not exist
function LinkedQueue:find(query)
	return self.buffer:find(query)
end

function LinkedQueue.__tostring(t)
	return tostring(t.buffer)

end

return LinkedQueue
