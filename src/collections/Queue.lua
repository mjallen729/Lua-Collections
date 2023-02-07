local Queue = {}
Queue.__index = Queue

-- Create a new queue, allows for array casting if desired (last item in array will be last in queue)
function Queue.new(...)
	local queue = {}
	setmetatable(queue, Queue)

	local args = ...

	queue.buffer = {} -- An array-implemented Queue
	queue.length = 0
	queue.head = nil

	if args ~= nil then
		if #{ ... } > 1 then
			warn("[DataKit] Queue recieved argument not of type array! An empty Queue has been created instead.")
			return queue
		end

		for i, v in ipairs(args) do
			if not v then
				continue
			end

			table.insert(queue.buffer, v)
			queue.length += 1
		end

		queue.head = 1
	end

	return queue
end

-- Returns element at the given index, does not remove (returns top of the queue by default)
function Queue:peek(index)
	if self.head >= 5 then
		local tmp = {}

		for i = self.head, #self.buffer do
			tmp[#tmp + 1] = self.buffer[i]
		end

		self.buffer = tmp
		self.head = 1
	end

	if index == nil then
		return self.buffer[self.head]
	end

	return self.buffer[index + 1 - self.head]
end

-- Push a new element onto the bottom of the queue
function Queue:push(value)
	table.insert(self.buffer, value)
	self.length += 1

	if not self.head then
		self.head = 1
	end
end

-- Remove and return the element at the top of the queue
function Queue:pop()
	if self.length == 0 then
		warn("[DataKit] Tried to pop from an empty Queue!")
		return nil
	end

	local elem = self.buffer[self.head]

	self.head += 1
	self.length -= 1

	return elem
end

function Queue:length()
	return self.length
end

-- Returns index of element equal to the query or nil if does not exist
function Queue:find(query)
	for i = self.head, #self.buffer do
		if self.buffer[i] == query then
			return i + 1 - self.head
		end
	end

	return nil
end

return Queue
