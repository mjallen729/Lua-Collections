ds = require(game.ServerScriptService.Collections)

node = ds.Queue

a = node.new({1,2,3})

a:push(10)
a:push(11)
a:push(15)

a:pop()
a:pop()
a:pop()
a:pop()

print(a:size())

print(a)