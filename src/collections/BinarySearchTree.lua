local BinarySearchTree = {}
BinarySearchTree.__index = BinarySearchTree

local node = require(script.Parent.TreeNode)

-- Recursive helper function to convert a sorted array to a BST.
-- This BST implementation does not allow duplicate values (standard)
function fromArray(arr, first, last, gcache)
	if first > last then
		return nil

	end

	local mid = math.ceil((first + last) / 2)
	local root = nil
	
	-- only add if value not in tree
	if not gcache[arr[mid]] then
		gcache[arr[mid]] = true
		root = node.new(arr[mid])

		root.left = fromArray(arr, first, mid - 1, gcache)
		root.right = fromArray(arr, mid + 1, last, gcache)
		
	else
		error('[DataKit] BST starting array contains duplicate values!')
		
	end

	return root

end

-- Create a new Binary Search Tree, a special implementation of a binary tree
-- Allows for array casting if desired (array will be sorted using table.sort)
-- Strings are ordered reverse-alphabetically
function BinarySearchTree.new(...)
	local bst = {}
	setmetatable(bst, BinarySearchTree)
	
	local args = ...
	
	bst.size = 0
	bst.root = nil
	bst.cache = {}  -- cache to track values, ensuring no duplicates (key = element, value = true)
	
	if args ~= nil then
		if #{...} > 1 then
			warn('[DataKit] BinarySearchTree recieved argument not of type array! An empty BST has been created instead.')
			return bst
			
		end
		
		table.sort(args)
		bst.size = #args
		
		bst.root = fromArray(args, 1, #args, bst.cache)
		
	end
	
	return bst
	
end

-- Add an element to the BinarySearchTree. Returns element if add successful, nil otherwise.
-- BinarySearchTrees do not support multiple datatypes within the same tree (for comparator reasons).
function BinarySearchTree:add(element)
	if not self.root then  -- if first element
		self.root = node.new(element)
		self.cache[element] = true
		self.size = self.size + 1
		return element

	end
	
	if typeof(self.root.data) ~= typeof(element) then  -- same data type?
		error('[DataKit] Cannot add type \'' .. typeof(element) .. '\' to BinarySearchTree<' .. 
			typeof(self.root.data) .. '>')
		return nil
		
	end
	
	if self.cache[element] then  -- no duplicates
		warn('[DataKit] Cannot add duplicate value ' .. element .. ' to BinarySearchTree.')
		return nil

	end
	
	-- if valid addition...
	local cur = self.root
	
	while cur do
		if element < cur.data then
			if not cur.left then
				cur.left = node.new(element)
				self.size = self.size + 1
				self.cache[element] = true
				return element
				
			end
			
			cur = cur.left
			continue
			
		end
		
		if element > cur.data then
			if not cur.right then
				cur.right = node.new(element)
				self.size += 1
				self.cache[element] = true
				return element
				
			end
			
			cur = cur.right
			continue
			
		end
		
	end
	
	return nil
	
end

-- Private helper function for the Pop() method
function FindMin(root)
	while root.left do
		root = root.left
		
	end
	
	return root
	
end

-- Remove an element from the BinarySearchTree
-- Returns the element if removal successful, returns nil otherwise
function BinarySearchTree:pop(element)	
	local cur = self.root
	local parent = nil
	
	while cur and cur.data ~= element do
		parent = cur
		if element < cur.data then
			cur = cur.left
			
		else
			cur = cur.right
			
		end
		
	end
	
	if not cur then
		return nil
		
	end
	
	-- leaf node
	if not cur.left and not cur.right then
		local ret = cur.data
		
		-- if cur is root
		if not parent then
			self.size -= 1
			self.cache[ret] = nil
			self.root = nil

			return ret
			
		end
		
		-- if cur is left child
		if parent.left and parent.left.data == ret then
			parent.left = nil
			self.size -= 1
			self.cache[ret] = nil
			
			return ret
			
		-- if cur is right child
		elseif parent.right and parent.right.data == ret then 
			parent.right = nil
			self.size -= 1
			self.cache[ret] = nil
			
			return ret
			
		end
		
		return nil
		
	-- node with two children
	elseif cur.left and cur.right then
		local ret = cur.data
		local successor = FindMin(cur.right) -- find inorder successor
		local sdata = self:pop(successor.data)  -- remove inorder successor
		
		if not successor then
			return nil
			
		end
		
		cur.data = successor.data
		
		return ret
		
	-- node with one child
	else
		local ret = cur.data
		
		-- if cur is root
		if not parent then
			if self.root.left then
				self.root = self.root.left
				self.size -= 1
				self.cache[ret] = nil
				
				return ret
				
			end
			
			if self.root.right then
				self.root = self.root.right
				self.size -= 1
				self.cache[ret] = nil
				
				return ret
				
			end
			
			return nil
			
		end
		
		-- if cur is left child
		if parent.left and parent.left.data == ret then
			if cur.right then
				parent.left = cur.right
				self.size -= 1
				self.cache[ret] = nil
				
				return ret
				
			end
			
			if cur.left then
				parent.left = cur.left
				self.size -= 1
				self.cache[ret] = nil
				
				return ret
				
			end

		-- if cur is right child
		elseif parent.right and parent.right.data == ret then 
			if cur.right then
				parent.right = cur.right
				self.size -= 1
				self.cache[ret] = nil
				
				return ret

			end

			if cur.left then
				parent.right = cur.left
				self.size -= 1
				self.cache[ret] = nil
				
				return ret

			end

		end
		
	end
	
	return nil
	
end

-- Find an given element within the BinarySearchTree (this is where BST shines, very efficient search)
-- Returns the TreeNode object if target found, returns nil otherwise
function BinarySearchTree:find(target)
	local cur = self.root
	
	while cur do
		if cur.data == target then
			return cur
			
		end
		
		if target < cur.data then
			cur = cur.left
			continue
			
		end
		
		if target > cur.data then
			cur = cur.right
			continue
			
		end
		
	end
	
	return nil
	
end

function BinarySearchTree:length()
	return self.size
	
end

return BinarySearchTree