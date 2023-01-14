-- A two-way linked list (nodes have next & prev functionality built-in).
local LinkedList = {}
LinkedList.__index = LinkedList

local node = require(script.Parent.LinkedNode)

-- Create a new linked list, allows for array casting if desired
function LinkedList.new(...)
	local linkedlist = {}
	setmetatable(linkedlist, LinkedList)

	local args = ...

	linkedlist.head = nil
	linkedlist.length = 0
	linkedlist.last = nil

	if args ~= nil then
		if #{ ... } > 1 then
			warn(
				"[DataKit] LinkedList recieved argument not of type array! An empty LinkedList has been created instead."
			)
			return linkedlist
		end

		for i, v in ipairs(args) do
			if not v then
				continue
			end

			if i == 1 then
				linkedlist.head = node.new(v, nil, nil)
				linkedlist.last = linkedlist.head
				linkedlist.length += 1
				continue
			end

			local newnode = node.new(v, nil, linkedlist.last)
			linkedlist.last.next = newnode
			linkedlist.last = newnode
			linkedlist.length += 1
		end
	end

	return linkedlist
end

-- Add a node containing data to the linked list
function LinkedList:add(data)
	local newnode = node.new(data, nil, self.last)

	if self.head == nil then
		self.head = newnode
		self.length += 1
		self.last = self.head
		return
	end

	self.last.next = newnode
	self.last = newnode

	self.length += 1
end

-- Insert a node at the start of the linked list
function LinkedList:addFront(data)
	local newhead = node.new(data, self.head, nil)

	if self.head == nil then
		self.head = newhead
		self.length += 1
		self.last = self.head
		return
	end

	self.head = newhead
	self.length += 1
end

-- Remove and return the node at the given index in the linked list (removes last by default)
function LinkedList:pop(index)
	if self.head == nil then
		return nil
	end

	if self.length == 1 then
		local elem = node.new(self.head.data, self.head.next, self.head.prev)
		self.head = nil
		self.last = nil
		self.length -= 1

		return elem
	end

	if index == 1 then -- if head is being removed
		local elem = node.new(self.head.data, self.head.next, self.head.prev)

		self.head = self.head.next
		self.head.prev.next = nil
		self.head.prev = nil
		self.length -= 1

		return elem
	end

	if not index or index == self.length then -- if index is nil (remove last entry)
		local removed = node.new(self.last.data, self.last.next, self.last.prev)

		self.last = self.last.prev
		self.last.next = nil

		self.length -= 1

		return removed
	end

	local removed = self:atIndex(index)

	if not removed then
		error("[DataKit] Index out of bounds error on LinkedList:Pop()")
	end

	removed.prev.next = removed.next
	removed.next.prev = removed.prev
	self.length -= 1

	return removed
end

function LinkedList:length()
	return self.length
end

-- Returns index of node with data equal to the query or nil if doest not exist
function LinkedList:find(query)
	local cur = self.head
	local i = 1

	while cur do
		if cur.data == query then
			return i
		end

		cur = cur.next
		i += 1
	end

	return nil
end

-- Returns node at the given index or nil if does not exist
function LinkedList:atIndex(index)
	local i = 1
	local cur = self.head

	while cur do
		if i == index then
			return cur
		end

		i += 1
		cur = cur.next
	end

	return nil
end

return LinkedList
