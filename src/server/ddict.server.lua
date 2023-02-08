ds = require(game.ServerScriptService.Collections)

function f()
	return {}
end

-- initialized empty table
dd = ds.DefaultDict.new(f)

for i=0, 3 do
	print(dd[i])
end

print(dd)
print(#dd)

c = 0
for i in pairs(dd) do
	c += 1
end

print(c)