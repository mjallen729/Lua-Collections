ds = require(game.ServerScriptService.Collections)

function f()
	print("A VALUE DOES NOT EXIST")
end

dd = ds.DefaultDict.new(f)

print(dd)
print(getmetatable(dd))

dd:get("hi") -- this works! 