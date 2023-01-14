--[[
Lua Collections v1.0
DATA STRUCTURES:
	LinkedList, @TODO SkipList
	Stack, LinkedStack
	Queue, LinkedQueue
	BinarySearchTree, @TODO RedBlackTree
	@TODO MinHeap, @TODO MaxHeap
	@TODO Graph
	@TODO DefaultDict
	
SEARCH ALGORITHMS:
	Breadth-First (BFS)
	BinarySearch
	InOrder, PostOrder, PreOrder (Search + Traversal)

SORTING ALGORITHMS:
	QuickSort

	
]]

local collections = {}

collections['Search'] = require(script.Search)
collections['Sort'] = require(script.Sort)

collections['LinkedNode'] = require(script.LinkedNode)
collections['LinkedList'] = require(script.LinkedList)

collections['Stack'] = require(script.Stack)
collections['LinkedStack'] = require(script.LinkedStack)

collections['Queue'] = require(script.Queue)
collections['LinkedQueue'] = require(script.LinkedQueue)

collections['TreeNode'] = require(script.TreeNode)
collections['BinarySearchTree'] = require(script.BinarySearchTree)

return collections
