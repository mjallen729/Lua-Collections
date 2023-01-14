local Search = {}
Search.__index = Search

Search.buffer = {}
Search.result = nil

-- Recursive agent for in-order traversal
function InOrder(root, target)
	if root == nil then
		return nil
	end

	InOrder(root.left, target)

	table.insert(Search.buffer, root.data)

	if target and root.data == target then
		Search.result = #Search.buffer
	end

	InOrder(root.right, target)
end

-- Given a tree's root node and a target value, searches for value via InOrder Traversal and returns index of target in the resulting traversal
-- If no target specified, returns an array containing results of a InOrder traversal (Left, Root, Right)
function Search.InOrder(root, target)
	Search.buffer = {}
	Search.result = nil

	InOrder(root, target)

	if not target or not Search.result then
		return Search.buffer
	end

	return Search.result
end

-- Recursive agent for pre-order traversal
function PreOrder(root, target)
	if root == nil then
		return nil
	end

	table.insert(Search.buffer, root.data)

	if target and root.data == target then
		Search.result = #Search.buffer
	end

	PreOrder(root.left, target)

	PreOrder(root.right, target)
end

-- Given a tree's root node and a target value, seaches for value via PreOrder Traversal and returns index of target in the resulting traversal
-- If no target specified, returns an array containing results of a PreOrder traversal (Root, Left, Right)
function Search.PreOrder(root, target)
	Search.buffer = {}
	Search.result = nil

	PreOrder(root, target)

	if not target or not Search.result then
		return Search.buffer
	end

	return Search.result
end

-- Recursive agent for post-order traversal
function PostOrder(root, target)
	if root == nil then
		return
	end

	PostOrder(root.left, target)

	PostOrder(root.right, target)

	table.insert(Search.buffer, root.data)

	if target and root.data == target then
		Search.result = #Search.buffer
	end
end

-- Given a tree's root node and a target value, searches for value via PostOrder Traversal and returns index of target in the resulting traversal
-- If no target specified, returns an array containing results of a PostOrder traversal (Left, Right, Root)
function Search.PostOrder(root, target)
	Search.buffer = {}
	Search.result = nil

	PostOrder(root, target)

	if not target or not Search.result then
		return Search.buffer
	end

	return Search.result
end

-- Given a root node and a target value, BFS looks for matching value and returns the TreeNode object that corresponds to target
-- Returns nil if target value not found
function Search.BFS(root, target)
	local q = require(script.Parent.Parent.Queue)
	local queue = q.new()

	queue:Push(root)

	while queue:Length() > 0 do
		local cur = queue:Pop()

		if cur.data == target then
			return cur
		end

		if cur.left then
			queue:Push(cur.left)
		end

		if cur.right then
			queue:Push(cur.right)
		end
	end

	return nil
end

-- Given a SORTED array and a target value, perform a Binary Search on the array for the target value.
-- Returns index of target if found, returns nil if target not found
function Search.BinarySearch(arr, target)
	local low = 1
	local high = #arr

	while low <= high do
		local mid = math.floor((low + high) / 2)

		if arr[mid] == target then
			return mid
		end

		if target < arr[mid] then
			high = mid - 1
		else
			low = mid + 1
		end
	end

	return nil
end

return Search
