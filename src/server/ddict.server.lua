ds = require(game.ServerScriptService.Collections)

function f()
	return 0
end

dd = ds.DefaultDict.new(f)

dd:get("hi") += 17 -- this works!

print(dd)