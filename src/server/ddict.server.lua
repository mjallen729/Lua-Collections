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

print(ds.DefaultDict.size(dd))