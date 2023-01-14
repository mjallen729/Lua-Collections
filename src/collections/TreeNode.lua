-- Node constructor for trees
local TreeNode = {}
TreeNode.__index = TreeNode

function TreeNode.new(data, left, right, color)
	local node = {}
	setmetatable(node, TreeNode)

	node.data = data
	node.left = left
	node.right = right

	-- For red/black tree
	node.color = nil

	return node
end

return TreeNode
