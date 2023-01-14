-- Node constructor for Linked Lists
local LinkedNode = {}
LinkedNode.__index = LinkedNode

function LinkedNode.new(data, next, prev)
	local node = {}
	setmetatable(node, LinkedNode)

	node.data = data
	node.next = next
	node.prev = prev

	return node
end

return LinkedNode
